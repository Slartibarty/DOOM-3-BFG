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
	platforms( { plat_win32 } )
	location( build_dir )
	preferredtoolarchitecture( "x86_64" )

-- Configuration --------------------------------------------------------------

-- Misc flags for all projects

includedirs( { "src/public" } )

flags( { "MultiProcessorCompile", "NoBufferSecurityCheck" } )
staticruntime( "On" )
cppdialect( "C++17" )
compileas( "C++" )
warnings( "Extra" )
vectorextensions( "SSE2" )
floatingpoint( "Fast" )
largeaddressaware( "On" )
characterset( "ASCII" )
rtti( "On" )

--defines( {  } )

-- Config for all 32-bit projects
filter( "platforms:" .. plat_win32 )
	architecture( "x86" )
filter( {} )

-- Config for all 64-bit projects
filter( "platforms:" .. plat_win64 )
	architecture( "x86_64" )
filter( {} )

-- Config for Windows
filter( "system:windows" )
	buildoptions( { "/permissive" } )
	defines( { "WIN32", "_WINDOWS", "_CRT_SECURE_NO_WARNINGS", "_CRT_NONSTDC_NO_WARNINGS", "_USE_32BIT_TIME_T", "_HAS_AUTO_PTR_ETC" } )
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

local zlib_public_hdrs = {
	"neo/thirdparty/zlib/zconf.h",
	"neo/thirdparty/zlib/zlib.h"
}

local zlib_private_hdrs = {
	"neo/thirdparty/zlib/crc32.h",
	"neo/thirdparty/zlib/deflate.h",
	"neo/thirdparty/zlib/gzguts.h",
	"neo/thirdparty/zlib/inffast.h",
	"neo/thirdparty/zlib/inffixed.h",
	"neo/thirdparty/zlib/inflate.h",
	"neo/thirdparty/zlib/inftrees.h",
	"neo/thirdparty/zlib/trees.h",
	"neo/thirdparty/zlib/zutil.h"
}

local zlib_srcs = {
	"neo/thirdparty/zlib/adler32.c",
	"neo/thirdparty/zlib/compress.c",
	"neo/thirdparty/zlib/crc32.c",
	"neo/thirdparty/zlib/deflate.c",
	"neo/thirdparty/zlib/gzclose.c",
	"neo/thirdparty/zlib/gzlib.c",
	"neo/thirdparty/zlib/gzread.c",
	"neo/thirdparty/zlib/gzwrite.c",
	"neo/thirdparty/zlib/inflate.c",
	"neo/thirdparty/zlib/infback.c",
	"neo/thirdparty/zlib/inftrees.c",
	"neo/thirdparty/zlib/inffast.c",
	"neo/thirdparty/zlib/trees.c",
	"neo/thirdparty/zlib/uncompr.c",
	"neo/thirdparty/zlib/zutil.c"
}

project( "zlib" )
	kind( "StaticLib" )
	language( "C++" )
	
	files( { zlib_public_hdrs, zlib_private_hdrs, zlib_srcs } )

-- Project definitions --------------------------------------------------------

project( "idLib" )
	kind( "StaticLib" )
	language( "C++" )
	defines( { "__IDLIB__" } )

	files( { "neo/idlib/**" } )
	
project( "Game" )
	kind( "StaticLib" )
	language( "C++" )
	defines( { "__DOOM__", "_D3XP", "CTF" } )
	
	--pchsource( "precompiled.cpp" )
	--pchheader( "../idlib/precompiled.h" )

	files( { "neo/d3xp/**" } )
	removefiles( { "neo/d3xp/EndLevel.*", "neo/d3xp/gamesys/Callbacks.cpp", "neo/d3xp/menus/MenuWidget_DevList.cpp" } )

project( "Doom3BFG" )
	kind( "WindowedApp" )
	language( "C++" )
	defines( { "__DOOM__" } )
	links( { "zlib", "idLib", "Game" } )

	files( { "neo/aas/**", "neo/cm/**", "neo/framework/**", "neo/renderer/**", "neo/sound/**", "neo/swf/**", "neo/sys/**", "neo/ui/**" } )
	removefiles( { "neo/framework/Session.cpp" } )