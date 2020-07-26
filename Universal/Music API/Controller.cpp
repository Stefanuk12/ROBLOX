// pls no hate on bad code

#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <jsoncons/json.hpp>
#include <curl/curl.h>
#include <algorithm>
#include <chrono>
#include <thread>
#include <sstream>
#include <cctype>
#include <iomanip>
#include <cassert>

bool Verbose = true;
unsigned int waitTime = 30;
std::string MusicTableURL = "https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Music%20API/MusicTable.json";

// Make a CURL Get Request and return the Response Body
size_t curlWriteFunc(void* contents, size_t size, size_t nmemb, std::string* s)
{
    size_t newLength = size * nmemb;
    try {
        s->append((char*)contents, newLength);
    }
    catch (std::bad_alloc& e) {
        //Handle Mem Problems
        return 0;
    }
    return newLength;
};

void sleep(int ms) {
    std::this_thread::sleep_for(std::chrono::seconds(ms));
};

std::string webGet(std::string targetURL, bool Verbose) {
    if (Verbose) {
        //std::cout << "\x1B[33m[-] Getting the source of: " + targetURL << "\x1B[37m\n";
    };
    // Initialise Variables
    std::string source = "";
    CURL* curl;
    curl = curl_easy_init();

    // Check if was able to initialise curl
    if (curl) {
        CURLcode res;
        // Set curl options
        curl_easy_setopt(curl, CURLOPT_URL, targetURL.c_str());
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, curlWriteFunc);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &source);

        // Perform CURL Get request
        res = curl_easy_perform(curl);

        // Check for errors
        if (res != CURLE_OK) {
            fprintf(stderr, "\x1B[31m[!] curl_easy_perform() failed: %s\n\x1B[37m",
            curl_easy_strerror(res));
        }
        else {
            if (res == CURLE_OK && Verbose) {
                //std::cout << "\x1B[32m[+] Successfully performed curl get request for: " + targetURL << "\x1B[37m\n";
            };
        }

        // Cleanup
        curl_easy_cleanup(curl);
    };

    // Return Source
    return source;
};

// Has the assets that indicate an audio has been removed
std::vector<std::string> removedAssets = {
    "9281912c23312bc0d08ab750afa588cc",
    "70608418c648be7ac4e323e3294bb059",
};

// Checks if the SoundId has been removed or not
bool checkSoundId(std::string SoundId) {
    std::string targetURL = "roblox.com/library/" + SoundId;
    std::string targetURLSource = webGet(targetURL, Verbose); // Gets source of SoundId page
    bool passed = false;
    for (unsigned int i = 0; i < removedAssets.size(); i++) {
        std::string Asset = removedAssets[i];
        if (targetURLSource.find(Asset) == std::string::npos) { // Check if its not removed
            passed = true;
        };
    };
    return passed;
};

bool isInTable(jsoncons::json targetTable, std::string givenSoundId) {
    for (auto& item : targetTable.array_range()) {
        if (item != NULL && item["SoundId"] == givenSoundId) { // Checking if there is a duplicate SoundId
            return true;
        };
    };
    return false;
};

jsoncons::json removeDuplicates(jsoncons::json musicTable) {
    jsoncons::json checkTable = jsoncons::json::parse("[]");
    for (auto& item : musicTable.array_range()) {
        std::string SoundId = item["SoundId"].as<std::string>();
        if (!isInTable(checkTable, SoundId)) { // Checking if there is not a duplicate SoundId
            checkTable.push_back(item); // Add it to the table  
        }
        else {
            std::cout << "\x1B[31m[!] Removed Duplicate Sound ID: Name - " + item["Name"].as<std::string>() + " SoundId - " + SoundId + "\x1B[37m\n";
        };
    };
    return checkTable;
};

// Checks all sounds if they've been removed/updates the table
jsoncons::json checkAllSounds() {
    jsoncons::json musicTable = jsoncons::json::parse(webGet(MusicTableURL, Verbose));
    jsoncons::json musicTableB = jsoncons::json::parse("[]");
   
    musicTable = removeDuplicates(musicTable); // Remove any duplicate Sound Ids

    for (const auto& item : musicTable.array_range()) {
        std::string SoundName = item["Name"].as<std::string>();
        std::string SoundId = item["SoundId"].as<std::string>();

        if (!checkSoundId(SoundId)) {
            std::cout << "\x1B[31m[!] " + SoundName + " has been removed!\x1B[37m\n";
        }
        else {
            std::cout << "\x1B[32m[+] Audio Passed: " << item["Name"].as<std::string>() << " (" << item["SoundId"].as<std::string>() << ")\x1B[37m\n";
            musicTableB.push_back(item); // Adding it to the update table
        };
    };

    //sleep(waitTime);

    int count = 1;
    for (auto& item : musicTableB.array_range()) {
        item["UUID"] = count;
        count++;
    };

    return musicTableB; // Returning the new table
};

bool doesFileExist(std::string FileDirectory) {
    std::fstream fileStream;
    fileStream.open(FileDirectory);
    if (fileStream.fail()) {
        fileStream.close();
        return false;
    };
    fileStream.close();
    return true;
};

int main(int argc, std::vector<std::string> argv) {
    // Settings
    std::string SettingsSource;
    if (!doesFileExist("Settings.json")) {
        std::ofstream Settings("Settings.json");
        std::string jsonSettings = R"(
            {           
                "MusicTableURL":  "https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Music%20API/MusicTable.json",
                "waitTime" : 60,
                "Verbose" : true
            }
        )";
        Settings << jsonSettings;
        Settings.close();

        SettingsSource = jsonSettings;
        std::cout << "\x1B[31m[!] Settings.json was not available, therefore it was created!\x1B[37m\n";
    }
    else {
        std::ifstream Settings("Settings.json");
        std::ostringstream ss;
        ss << Settings.rdbuf();
        SettingsSource = ss.str();
        Settings.close();
        std::cout << "\x1B[32m[+] Got Settings!\x1B[37m\n";
    };
    
    jsoncons::json Settings = jsoncons::json::parse(SettingsSource);
    waitTime = Settings["waitTime"].as<int>();
    Verbose = Settings["Verbose"].as<bool>();
    MusicTableURL = Settings["MusicTableURL"].as<std::string>();

    // Checking
    std::ofstream musicTableFile("MusicTable.json"); // Opening the MusicTable file
    std::cout << "\x1B[33m[-] Updating/Creating MusicTable.json with the updated Music List, please wait..." << "\x1B[37m\n";
    auto mT = checkAllSounds(); // Checking Sounds
    musicTableFile << mT;
    musicTableFile.close(); // Closing file
    std::cout << "\x1B[32m[+] Successfully updated/created MusicTable.json at the directory of the .exe file with the updated Music List! Music Count - " << mT.size() << "\x1B[37m\n";

    return 0;
}