#pragma once

#include <string>
#include <jsoncons/json.hpp>

std::string getWebSource(std::string websiteURL);
bool stringFind(std::string s1, std::string s2);
bool checkSoundId(std::string SoundId, std::vector<std::string> removedAssets);
jsoncons::json removeDuplicates(jsoncons::json targetTable);
bool doesFileExist(std::string FileDirectory);
void coutWarn(std::string message);
void coutSuccess(std::string message);
void coutError(std::string message);
std::string returnSettings();