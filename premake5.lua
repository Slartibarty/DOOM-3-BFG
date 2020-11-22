-------------------------------------------------------------------------------
-- Premake5 build script for Doom 3 BFG
-------------------------------------------------------------------------------

-- Convenience locals
local conf_dbg = "Debug"
local conf_rel = "Release"
local conf_rtl = "Retail"

local plat_win32 = "x86"
local plat_win64 = "x64"

local build_dir = "build"

-- Workspace definition -------------------------------------------------------

workspace( "Neo" )
	configurations( { conf_dbg, conf_rel, conf_rtl } )
	platforms( { plat_win32, plat_win64 } )
	location( build_dir )
	preferredtoolarchitecture( "x86_64" )

-- Configuration --------------------------------------------------------------

-- Misc flags for all projects

flags( { "MultiProcessorCompile", "NoBufferSecurityCheck" } )
staticruntime( "On" )
cppdialect( "C++17" )
warnings( "Extra" )
floatingpoint( "Fast" )
characterset( "ASCII" )
rtti( "On" )

--defines( {  } )

-- Config for all 32-bit projects
filter( "platforms:" .. plat_win32 )
	vectorextensions( "SSE2" )
	largeaddressaware( "On" )
	architecture( "x86" )
filter( {} )

-- Config for all 64-bit projects
filter( "platforms:" .. plat_win64 )
	vectorextensions( "AVX2" )
	architecture( "x86_64" )
filter( {} )

-- Config for Windows
filter( "system:windows" )
	buildoptions( { "/permissive", "/Zc:__cplusplus" } )
	defines( { "WIN32", "_WINDOWS", "_CRT_SECURE_NO_WARNINGS", "_CRT_NONSTDC_NO_WARNINGS", "_HAS_AUTO_PTR_ETC" } )
filter( {} )
	
-- Config for Windows, release, clean this up!
filter( { "system:windows", "configurations:" .. conf_rel .. " or configurations:" .. conf_rtl } )
	buildoptions( { "/Gw" } )
filter( {} )

-- Config for all projects in debug
filter( "configurations:" .. conf_dbg )
	defines( { "_DEBUG" } )
	symbols( "FastLink" )
filter( {} )

-- Config for all projects in release AND retail
filter( "configurations:" .. conf_rel .. " or configurations:" .. conf_rtl )
	defines( { "NDEBUG" } )
	symbols( "Full" )
	optimize( "Speed" )
filter( {} )

-- Config for all projects in retail
filter( "configurations:" .. conf_rtl )
	defines( { "ID_RETAIL" } )
	symbols( "Off" )
	flags( { "LinkTimeOptimization" } )
filter( {} )

-- Config for shared library projects
filter( "kind:SharedLib" )
	-- We don't want manifests for DLLs
	flags( { "NoManifest" } )
filter( {} )

-- Thirdparty project definitions ---------------------------------------------

include( "premake5_thirdparty.lua" )

-- Project definitions --------------------------------------------------------

project( "idLib" )
	kind( "StaticLib" )
	language( "C++" )
	defines( { "__IDLIB__" } )
	
	pchsource( "neo/idlib/precompiled.cpp" )
	pchheader( "" )

	files( { "neo/idlib/**" } )
	
	-- Some files don't want to be in the PCH, filter them out here! (They're ported from idTech5)
	filter( "files:neo/idlib/geometry/RenderMatrix.cpp or files:neo/idlib/SoftwareCache.cpp" )
		flags( { "NoPCH" } )
	filter( {} )
	
project( "Game" )
	kind( "StaticLib" )
	language( "C++" )
	defines( { "__DOOM__", "_D3XP", "CTF" } )
	
	pchsource( "neo/d3xp/precompiled.cpp" )
	pchheader( "" )

	files( { "neo/d3xp/**" } )
	removefiles( { "neo/d3xp/EndLevel.*", "neo/d3xp/gamesys/Callbacks.cpp", "neo/d3xp/menus/MenuWidget_DevList.cpp" } )
	
project( "Doom3BFG" )
	kind( "WindowedApp" )
	language( "C++" )
	defines( { "__DOOM__" } )
	links( { "xaudio2", "xinput", "dinput8", "dxguid", "opengl32", "winmm", "dbghelp", "ws2_32" } )
	links( { "zlib", "libjpeg-turbo", "idLib", "Game" } )
	
	pchsource( "neo/framework/precompiled.cpp" )
	pchheader( "" )

	files( { "neo/aas/**", "neo/cm/**", "neo/framework/**", "neo/renderer/**", "neo/sound/**", "neo/swf/**", "neo/sys/**", "neo/ui/**" } )
	removefiles( { "neo/framework/Session.cpp", "neo/ui/GameWindow.cpp", "neo/sys/win32/win_stats.*", "neo/sys/win32/win_snd.cpp", "neo/sys/win32/win_gamma.cpp", "neo/renderer/BoundsTrack.cpp" } )
	
	-- Jobs don't use the PCH because they're funny
	filter( "files:neo/renderer/jobs/**.cpp" )
		flags( { "NoPCH" } )
	filter( {} )
