
group( "Thirdparty" )

-- ZLib

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
	language( "C" )
	warnings( "Off" )
	
	files( { zlib_public_hdrs, zlib_private_hdrs, zlib_srcs } )

group( "" )
