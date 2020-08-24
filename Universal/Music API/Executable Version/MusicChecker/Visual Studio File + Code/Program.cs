using Newtonsoft.Json.Linq;
using System;
using System.Diagnostics;
using System.IO;
using System.Net;
using System.Text.RegularExpressions;
using System.Threading;

namespace MusicChecker
{
    static class Program
    {
        // Removes all files in a directory
        public static void Empty(this System.IO.DirectoryInfo directory)
        {
            try
            {
                foreach (System.IO.FileInfo file in directory.GetFiles()) file.Delete();
                foreach (System.IO.DirectoryInfo subDirectory in directory.GetDirectories()) subDirectory.Delete(true);
            }
            catch
            {

            };  
        }

        static void DoStuff()
        {
            // Vars
            JArray MusicTable = MusicAPI.GetMusicTable();
            JObject Settings = MusicAPI.GetSettings();
            string[] Filter = Settings["Filter"].ToObject<string[]>();
            bool PreviewSounds = (bool)Settings["PreviewSounds"];
            bool RemoveAudioOnExit = (bool)Settings["RemoveAudioOnExit"];
            string StorageFolderName = "\\" + (string)Settings["StorageFolderName"];

            // Get the Sound Id
            MusicAPI.ConsoleWarn("Please enter the Sound ID");
            string SoundId = Console.ReadLine();
            SoundId = Regex.Replace(SoundId, "[\\D]+", "");

            // Test the Sound Id
            if (!MusicAPI.CheckSound(SoundId, Filter))
            {
                MusicAPI.ConsoleError("Sound ID (" + SoundId + ") Failed.");
                return;
            };
            MusicAPI.ConsoleSuccess("Sound ID (" + SoundId + ") Passed.");

            // Play Sound Preview
            string StorageAudioLocation = Directory.GetCurrentDirectory() + StorageFolderName;
            string SoundStorageName = StorageAudioLocation + "\\" + "Preview Audio" + " (" + SoundId + ")";
            if (PreviewSounds)
            {
                try
                {
                    // Create Audio Preview Storage
                    if (!Directory.Exists(StorageAudioLocation))
                    {
                        Directory.CreateDirectory(StorageAudioLocation);
                    };

                    // Download the file
                    using (WebClient webClient = new WebClient())
                    {
                        string SoundURL = "https://roblox.com/library/" + SoundId + "/#";
                        string SoundURLSource = MusicAPI.GetSourceURL(webClient.DownloadString(SoundURL));
                        if (SoundURLSource == "Failed.") throw new Exception("Unable to get the Preview File.");
                        webClient.DownloadFile(SoundURLSource, SoundStorageName + ".wav");
                        MusicAPI.ConsoleSuccess("Downloaded Preview of Audio, now opening... (Will be removed on exit).");

                        // Opening the file
                        Process cmd = new Process();
                        cmd.StartInfo.FileName = "cmd.exe";
                        cmd.StartInfo.RedirectStandardInput = true;
                        cmd.StartInfo.RedirectStandardOutput = true;
                        cmd.StartInfo.CreateNoWindow = true;
                        cmd.StartInfo.UseShellExecute = false;
                        cmd.Start();

                        cmd.StandardInput.WriteLine("cmd /c start \"explorer.exe shell: C:\\Program Files\\WindowsApps\\Microsoft.ZuneMusic_3.6.25021.0_x64__8wekyb3d8bbwe!Microsoft.ZuneMusic\" \"" + SoundStorageName + ".wav" + "\"");
                        cmd.StandardInput.Flush();
                        cmd.StandardInput.Close();
                        cmd.WaitForExit();
                        Console.WriteLine(cmd.StandardOutput.ReadToEnd());
                    };
                }
                catch (Exception e)
                {
                    MusicAPI.ConsoleError("Sound Preview failed. Error: " + e);
                };
            };

            // Getting Sound Name
            MusicAPI.ConsoleWarn("Please enter the Sound Name. Say -exit to exit.");
            string Name = Console.ReadLine();

            if (Name == "-exit") return;

            // Adding the sound to the music table
            MusicAPI.ConsoleWarn("Do you wish to add the sound to the Music Table? Y/N");
            string AddSound = Console.ReadLine().ToLower();
            if (AddSound == "y")
            {
                try
                {
                    MusicTable = MusicAPI.AddSoundToMusicTable(Name, SoundId, MusicTable);
                    // Success
                    MusicAPI.ConsoleSuccess("Added " + Name + " (" + SoundId + ") to the Music Table.");
                }
                catch (Exception e)
                {
                    MusicAPI.ConsoleError("Adding sound to Music Table failed. Error: " + e);
                };
            };

            // Cleanup
            if (PreviewSounds && RemoveAudioOnExit)
            {
                System.IO.DirectoryInfo directory = new System.IO.DirectoryInfo(StorageAudioLocation);
                directory.Empty();
                MusicTable = MusicAPI.RemoveDuplicates(MusicTable);
                MusicAPI.UpdateMusicTableFile(MusicTable);
            };
        }

        static void Main(string[] args)
        {
            while (true)
            {
                DoStuff();
            };
        }
    };
};
