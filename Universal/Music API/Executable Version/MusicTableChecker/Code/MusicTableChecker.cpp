#include "MusicAPI.h"
#include <string>
#include <jsoncons/json.hpp>
#include <fstream>
#include <sstream>
#include <cassert>
#include <iostream>

// Default Settings
std::vector<std::string> removedAssets = {
	"https://images.rbxcdn.com/9281912c23312bc0d08ab750afa588cc.png",
	"https://t6.rbxcdn.com/70608418c648be7ac4e323e3294bb059",
};
std::string MusicTableURL = "https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Music%20API/MusicTable.json";
std::string outputMusicTableName = "MusicTable";
int waitTime = 60;
bool Verbose = true;

int main() {
	// Vars
	jsoncons::json musicTable = jsoncons::json::parse(getWebSource(MusicTableURL));
	musicTable = removeDuplicates(musicTable);
	jsoncons::json updatedMusicTable = jsoncons::json::parse("[]");

	// Load Settings
	jsoncons::json Settings = jsoncons::json::parse(returnSettings());
	MusicTableURL = Settings["MusicTableURL"].as<std::string>();
	outputMusicTableName = Settings["outputMusicTableName"].as<std::string>();
	waitTime = Settings["waitTime"].as<int>();
	Verbose = Settings["Verbose"].as<bool>();

	// Checking each sound
	coutWarn("Updating the Music Table, please wait...");
	for (auto item : musicTable.array_range()) {
		std::string Name = item["Name"].as<std::string>();
		std::string SoundId = item["SoundId"].as<std::string>();
		if (checkSoundId(SoundId, removedAssets)) {
			updatedMusicTable.push_back(item);
			if (Verbose) {
				coutSuccess("Audio passed: " + Name + " | " + SoundId );
			};
		}
		else {
			if (Verbose) {
				coutError("Audio failed: " + Name + " | " + SoundId );
			};
		};
	}

	// Adding a UUID to each sound
	int currentUUID = 1;
	for (auto& item : updatedMusicTable.array_range()) {
		item["UUID"] = currentUUID;
		currentUUID++;
	};

	// Creating new Music Table file
	std::ofstream musicTableFile(outputMusicTableName + ".json");
	musicTableFile << updatedMusicTable;
	musicTableFile.close();

	// Output
	coutSuccess("Successfuly updated the Music Table (Count: " + std::to_string(updatedMusicTable.size()) + ") ! Exported at the directory of the .exe file. Press type exit then enter to continue.");
	std::string holder;
	std::cin >> holder;

	return 0;
}