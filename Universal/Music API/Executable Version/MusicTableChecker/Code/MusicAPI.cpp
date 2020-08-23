#include "MusicAPI.h"
#include <string>
#include <vector>
#include <curl/curl.h>
#include <jsoncons/json.hpp>
#include <fstream>
#include <windows.h>
#include <conio.h>

size_t WriteCallbackCURL(char* contents, size_t size, size_t nmemb, void* userp){
	((std::string*)userp)->append((char*)contents, size * nmemb);
	return size * nmemb;
}

std::string getWebSource(std::string websiteURL) {
	// Vars
	std::string webSource;
	curl_global_init(CURL_GLOBAL_ALL);
	CURL* curl;
	curl = curl_easy_init();

	// Check if curl was able to initialise
	if (curl) {
		// Set curl options
		curl_easy_setopt(curl, CURLOPT_URL, websiteURL.c_str());
		curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, TRUE);
		curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteCallbackCURL);
		curl_easy_setopt(curl, CURLOPT_WRITEDATA, &webSource);

		// Perform curl get request, check result and cleanup
		CURLcode result;
		result = curl_easy_perform(curl);

		if (result != CURLE_OK) {
			fprintf(stderr, "\x1B[31m[!] curl_easy_perform() failed: %s\n\x1B[37m",
				curl_easy_strerror(result));
		};

		curl_easy_cleanup(curl);
		curl = NULL;
	};

	return webSource;
};

bool stringFind(std::string s1, std::string s2) {
	if (s1.find(s2) != std::string::npos) {
		return true;
	}
	return false;
};

bool checkSoundId(std::string SoundId, std::vector<std::string> removedAssets) {
	std::string soundWebSource = getWebSource("roblox.com/library/" + SoundId);
	for (unsigned int i = 0; i < removedAssets.size(); i++) {
		if ( soundWebSource.find(removedAssets[i]) != std::string::npos ) {
			return false;
		};
	}
	return true;
};

bool isSoundInTable(jsoncons::json targetTable, std::string SoundId) {
	for (auto item : targetTable.array_range()) {
		if (item != NULL && item["SoundId"].as<std::string>() == SoundId) {
			return true;
		};
	};
	return false;
};

jsoncons::json removeDuplicates(jsoncons::json targetTable) {
	jsoncons::json checkTable = jsoncons::json::parse("[]");
	for (auto& item : targetTable.array_range()) {
		std::string SoundId = item["SoundId"].as<std::string>();
		if (!isSoundInTable(checkTable, SoundId)) {
			checkTable.push_back(item);
		};
	};
	return checkTable;
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

/*
COLORS LIST
1: Blue
2: Green
3: Cyan
4: Red
5: Purple
6: Yellow (Dark)
7: Default white
8: Gray/Grey
9: Bright blue
10: Brigth green
11: Bright cyan
12: Bright red
13: Pink/Magenta
14: Yellow
15: Bright white
*/

void coutWarn(std::string message) {
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 6);
	std::cout << "[-] " + message + "\n";
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 15);
};

void coutSuccess(std::string message) {
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 2);
	std::cout << "[+] " + message + "\n";
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 15);
};

void coutError(std::string message) {
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 4);
	std::cout << "[!] " + message + "\n";
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 15);
};

std::string returnSettings() {
	std::string SettingsSource;
	if (doesFileExist("Settings.json")) {
		std::ifstream Settings("Settings.json");
		std::ostringstream ss;
		ss << Settings.rdbuf();
		SettingsSource = ss.str();
		Settings.close();
		coutSuccess("Got Settings!");
	}
	else {
		std::ofstream Settings("Settings.json");
		std::string jsonSettings = R"(
			{
				"MusicTableURL" : "https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Music%20API/MusicTable.json",
				"outputMusicTableName" : "MusicTable",
				"waitTime" : 60,
				"Verbose" : true
			}
		)";
		Settings << jsonSettings;
		Settings.close();

		SettingsSource = jsonSettings;
		coutError("Settings.json was not availble. It has been created with default settings.");
	};

	return SettingsSource;
};