project "Cubed"
   kind "ConsoleApp"
   language "C++"
   cppdialect "C++20"
   targetdir "bin/%{cfg.buildcfg}"
   staticruntime "off"

   files { "src/**.h", "src/**.cpp" }

   includedirs
   {
      "../Cubed-Common/src",
      "../Walnut/vendor/imgui",
      "../Walnut/vendor/glfw/include",
      "../Walnut/vendor/glm",

      "../Walnut/Walnut/Source",
      "../Walnut/Walnut/Platform/GUI",

      "%{IncludeDir.VulkanSDK}",
      "../Walnut/vendor/spdlog/include",
      "../Walnut/vendor/yaml-cpp/include",
      
      "../Walnut/Walnut-Modules/Walnut-Networking/Source",
      "../Walnut/Walnut-Modules/Walnut-Networking/vendor/GameNetworkingSockets/include"
   }

   links
   {
       "Cubed-Common",
       "Walnut",
       "Walnut-Networking",
   }

   targetdir ("../bin/" .. outputdir .. "/%{prj.name}")
   objdir ("../bin-int/" .. outputdir .. "/%{prj.name}")

   filter "system:windows"
      systemversion "latest"
      defines { "WL_PLATFORM_WINDOWS" }

      postbuildcommands 
	  {
	    '{COPY} "../%{WalnutNetworkingBinDir}/GameNetworkingSockets.dll" "%{cfg.targetdir}"',
	    '{COPY} "../%{WalnutNetworkingBinDir}/libcrypto-3-x64.dll" "%{cfg.targetdir}"',
	    '{COPY} "../%{WalnutNetworkingBinDir}/libprotobufd.dll" "%{cfg.targetdir}"',
	  }

   filter "configurations:Debug"
      defines { "WL_DEBUG" }
      runtime "Debug"
      symbols "On"

   filter "configurations:Release"
      defines { "WL_RELEASE" }
      runtime "Release"
      optimize "On"
      symbols "On"

   filter "configurations:Dist"
      kind "WindowedApp"
      defines { "WL_DIST" }
      runtime "Release"
      optimize "On"
      symbols "Off"