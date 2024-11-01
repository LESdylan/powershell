# Charger l'assembly nécessaire
Add-Type @"
using System;
using System.Runtime.InteropServices;

public class Display {
    [DllImport("user32.dll")]
    public static extern int ChangeDisplaySettings(ref DEVMODE lpDevMode, int dwFlags);
    
    [DllImport("user32.dll")]
    public static extern bool EnumDisplaySettings(string deviceName, int modeNum, ref DEVMODE devMode);

    public const int ENUM_CURRENT_SETTINGS = -1;
    public const int DMDO_DEFAULT = 0;
    public const int DMDO_90 = 1;
    public const int DMDO_180 = 2;
    public const int DMDO_270 = 3;

    [StructLayout(LayoutKind.Sequential)]
    public struct DEVMODE {
        public const int CCHDEVICENAME = 0x20;
        public const int CCHFORMNAME = 0x20;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = CCHDEVICENAME)]
        public string dmDeviceName;
        public short dmSpecVersion;
        public short dmDriverVersion;
        public short dmSize;
        public short dmDriverExtra;
        public int dmFields;
        public int dmPositionX;
        public int dmPositionY;
        public int dmDisplayOrientation;
        public int dmDisplayFixedOutput;
        public short dmColor;
        public short dmDuplex;
        public short dmYResolution;
        public short dmTTOption;
        public short dmCollate;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = CCHFORMNAME)]
        public string dmFormName;
        public short dmLogPixels;
        public int dmBitsPerPel;
        public int dmPelsWidth;
        public int dmPelsHeight;
        public int dmDisplayFlags;
        public int dmDisplayFrequency;
        public int dmICMMethod;
        public int dmICMIntent;
        public int dmMediaType;
        public int dmDitherType;
        public int dmReserved1;
        public int dmReserved2;
        public int dmPanningWidth;
        public int dmPanningHeight;
    }
    
    public static void SetOrientation(int orientation) {
        DEVMODE dm = new DEVMODE();
        dm.dmSize = (short)Marshal.SizeOf(typeof(DEVMODE));
        if (EnumDisplaySettings(null, ENUM_CURRENT_SETTINGS, ref dm)) {
            dm.dmDisplayOrientation = orientation;
            ChangeDisplaySettings(ref dm, 0);
        }
    }
}
"@

# Changer l'orientation
# 0 = Paysage, 1 = Portrait, 2 = Paysage inversé, 3 = Portrait inversé
[Display]::SetOrientation(1) # 1 pour Portrait
# Fonction pour changer l'orientation de l'écran
function Set-ScreenOrientation {
    param (
        [string]$Orientation
    )
    
    # Créez un objet de gestion de l'affichage
    $monitor = Get-WmiObject -Namespace root\wmi -Class WmiMonitorBasicDisplayParams
    
    # Choisissez l'orientation
    switch ($Orientation) {
        "Portrait" { $rotation = 1 }
        "PortraitInverted" { $rotation = 2 }
        "Landscape" { $rotation = 0 }
        "LandscapeInverted" { $rotation = 3 }
        default { Write-Host "Orientation non reconnue. Utilisez Portrait, PortraitInverted, Landscape, ou LandscapeInverted." }
    }

    # Appliquer la nouvelle orientation
    if ($rotation -ne $null) {
        $monitor | ForEach-Object {
            $_.WmiSetBrightness(0, $rotation)
        }
    }
}

# Exemple d'utilisation
Set-ScreenOrientation -Orientation "Portrait"
Function set-ScreenOrientation()
{
    param(
        [string]$Orientation
    )
}

#create a management object of diplay
$monitor = Get-WmiObject -Namespace  root \WmMonitorBasicDisplayParams

