-- premake5.lua
workspace "Cubed"
   architecture "x64"
   configurations { "Debug", "Release", "Dist" }
   startproject "Cubed"

   -- Workspace-wide build options for MSVC
   filter "system:windows"
      buildoptions { "/EHsc", "/Zc:preprocessor", "/Zc:__cplusplus" }

-- Directories
outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"
WalnutNetworkingBinDir = "Walnut/Walnut-Modules/Walnut-Networking/vendor/GameNetworkingSockets/bin/%{cfg.system}/%{cfg.buildcfg}/"

include "Walnut/Build-Walnut-External.lua"

group "App"
    include "Cubed/Build.lua"
    include "Cubed-Common/Build.lua"
group ""