using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.IO;
using System.Net;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;

namespace MusicChecker
{
    public class MusicAPI
    {
        public static bool CheckSound(string SoundId, string[] Filter)
        {
            try
            {
                WebClient client = new WebClient();
                string webSource = client.DownloadString("https://roblox.com/library/" + SoundId + "/#");
                foreach (string filter in Filter)
                {
                    if (webSource.Contains(filter)) return false;
                };
                return true;
            }
            catch
            {
                return false;
            };
        }

        public static string GetSourceURL(string Data)
        {
            int num = Data.IndexOf("data-mediathumb-url=\"") + "data-mediathumb-url=\"".Length;
            if (num < 0) return "Failed.";
            int num2 = Data.LastIndexOf("asset-status-icon") - 62;
            if (num2 < 0) return "Failed.";
            return Data.Substring(num, num2 - num);
        }

        public static JObject GetSettings()
        {
            // Handling
            if (!Directory.Exists(Directory.GetCurrentDirectory() + "\\bin"))
            {
                Directory.CreateDirectory(Directory.GetCurrentDirectory() + "\\bin");
            };
            if (!File.Exists(Directory.GetCurrentDirectory() + "\\bin\\Settings.json"))
            {
                using(FileStream fs = File.Create(Directory.GetCurrentDirectory() + "\\bin\\Settings.json"))
                {
                    JObject Obj = new JObject(
                        new JProperty("MusicTableLocation", "../../../../../MusicTable.json"),
                        new JProperty("PreviewSounds", true),
                        new JProperty("RemoveAudioOnExit", true),
                        new JProperty("PreviewStorageFolder", "AudioPreviews"),
                        new JProperty("Filter", new JArray("https://images.rbxcdn.com/9281912c23312bc0d08ab750afa588cc.png", "https://t6.rbxcdn.com/70608418c648be7ac4e323e3294bb059"))
                    );
                    byte[] info = new UTF8Encoding(true).GetBytes(Obj.ToString());
                    fs.Write(info, 0, info.Length);
                    return Obj;
                };
            };

            string jsonString = System.IO.File.ReadAllText(Directory.GetCurrentDirectory() + "\\bin\\Settings.json");
            return JObject.Parse(jsonString);
        }

        public static JArray GetMusicTable()
        {
            JObject Settings = GetSettings();
            string MusicTableLocation = (string)Settings["MusicTableLocation"];
            string jsonString = File.ReadAllText(MusicTableLocation);
            return JArray.Parse(jsonString);
        }

        public static bool IsSoundInMusicTable(string SoundId, JArray MusicTable)
        {
            foreach (JObject item in MusicTable)
            {
                if ((string)item["SoundId"] == SoundId) return true;
            };

            return false;
        }

        public static JArray RemoveDuplicates(JArray Obj)
        {
            JArray Cleaned = new JArray();
            foreach (JObject item in Obj)
            {
                if (!IsSoundInMusicTable((string)item["SoundId"], Cleaned))
                {
                    Cleaned.Add(item);
                }
            };

            return Cleaned;
        }

        public static JArray AddSoundToMusicTable(string Name, string SoundId, JArray MusicTable)
        {
            if (IsSoundInMusicTable(SoundId, MusicTable)) return MusicTable;

            JObject Obj = new JObject(
                new JProperty("Name", Name),
                new JProperty("SoundId", SoundId),
                new JProperty("UUID", MusicTable.Count + 1)
            );
            MusicTable.Add(Obj);

            return MusicTable;
        }

        public static void UpdateMusicTableFile(JArray MusicTable)
        {
            string jsonString = MusicTable.ToString();
            JObject Settings = GetSettings();
            string MusicTableLocation = (string)Settings["MusicTableLocation"];

            using (FileStream fs = File.Create(MusicTableLocation))
            {
                byte[] info = new UTF8Encoding(true).GetBytes(jsonString);
                fs.Write(info, 0, info.Length);
            };
        }

        public static void ConsoleError(string message)
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("[!] " + message);
            Console.ResetColor();
        }

        public static void ConsoleWarn(string message)
        {
            Console.ForegroundColor = ConsoleColor.Yellow;
            Console.WriteLine("[*] " + message);
            Console.ResetColor();
        }

        public static void ConsoleSuccess(string message)
        {
            Console.ForegroundColor = ConsoleColor.Green;
            Console.WriteLine("[+] " + message);
            Console.ResetColor();
        }
    }
}
