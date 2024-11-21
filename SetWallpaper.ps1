# Define the wallpaper path
$wallpaperPath = "C:\Wallpapers\MyWallpaper.jpg"

# Check if the wallpaper file exists
if (-Not (Test-Path $wallpaperPath)) {
    Write-Host "Wallpaper file not found at path: $wallpaperPath"
    exit
}

# Set the wallpaper
try {
    Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    public class Wallpaper {
        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
        public const int SPI_SETDESKWALLPAPER = 20;
        public const int SPIF_UPDATEINIFILE = 0x01;
        public const int SPIF_SENDCHANGE = 0x02;
        public static void Set(string path) {
            SystemParametersInfo(SPI_SETDESKWALLPAPER, 0, path, SPIF_UPDATEINIFILE | SPIF_SENDCHANGE);
        }
    }
    "@
    [Wallpaper]::Set($wallpaperPath)
    Write-Host "Wallpaper set successfully!"
} catch {
    Write-Host "Failed to set wallpaper: $_"
}
