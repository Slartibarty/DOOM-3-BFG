
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
	
-- Jpeg

local jpeg_hdrs = {
	"neo/thirdparty/libjpeg-turbo/jpeglib.h"
}

local jpeg_srcs = {
	"neo/thirdparty/libjpeg-turbo/jcapimin.c",
	"neo/thirdparty/libjpeg-turbo/jcapistd.c",
	"neo/thirdparty/libjpeg-turbo/jccoefct.c",
	"neo/thirdparty/libjpeg-turbo/jccolor.c",
	"neo/thirdparty/libjpeg-turbo/jcdctmgr.c",
	"neo/thirdparty/libjpeg-turbo/jchuff.c",
	"neo/thirdparty/libjpeg-turbo/jcicc.c",
	"neo/thirdparty/libjpeg-turbo/jcinit.c",
	"neo/thirdparty/libjpeg-turbo/jcmainct.c",
	"neo/thirdparty/libjpeg-turbo/jcmarker.c",
	"neo/thirdparty/libjpeg-turbo/jcmaster.c",
	"neo/thirdparty/libjpeg-turbo/jcomapi.c",
	"neo/thirdparty/libjpeg-turbo/jcparam.c",
	"neo/thirdparty/libjpeg-turbo/jcphuff.c",
	"neo/thirdparty/libjpeg-turbo/jcprepct.c",
	"neo/thirdparty/libjpeg-turbo/jcsample.c",
	"neo/thirdparty/libjpeg-turbo/jctrans.c",
	"neo/thirdparty/libjpeg-turbo/jdapimin.c",
	"neo/thirdparty/libjpeg-turbo/jdapistd.c",
	"neo/thirdparty/libjpeg-turbo/jdatadst.c",
	"neo/thirdparty/libjpeg-turbo/jdatasrc.c",
	"neo/thirdparty/libjpeg-turbo/jdcoefct.c",
	"neo/thirdparty/libjpeg-turbo/jdcolor.c",
	"neo/thirdparty/libjpeg-turbo/jddctmgr.c",
	"neo/thirdparty/libjpeg-turbo/jdhuff.c",
	"neo/thirdparty/libjpeg-turbo/jdicc.c",
	"neo/thirdparty/libjpeg-turbo/jdinput.c",
	"neo/thirdparty/libjpeg-turbo/jdmainct.c",
	"neo/thirdparty/libjpeg-turbo/jdmarker.c",
	"neo/thirdparty/libjpeg-turbo/jdmaster.c",
	"neo/thirdparty/libjpeg-turbo/jdmerge.c",
	"neo/thirdparty/libjpeg-turbo/jdphuff.c",
	"neo/thirdparty/libjpeg-turbo/jdpostct.c",
	"neo/thirdparty/libjpeg-turbo/jdsample.c",
	"neo/thirdparty/libjpeg-turbo/jdtrans.c",
	"neo/thirdparty/libjpeg-turbo/jerror.c",
	"neo/thirdparty/libjpeg-turbo/jfdctflt.c",
	"neo/thirdparty/libjpeg-turbo/jfdctfst.c",
	"neo/thirdparty/libjpeg-turbo/jfdctint.c",
	"neo/thirdparty/libjpeg-turbo/jidctflt.c",
	"neo/thirdparty/libjpeg-turbo/jidctfst.c",
	"neo/thirdparty/libjpeg-turbo/jidctint.c",
	"neo/thirdparty/libjpeg-turbo/jidctred.c",
	"neo/thirdparty/libjpeg-turbo/jquant1.c",
	"neo/thirdparty/libjpeg-turbo/jquant2.c",
	"neo/thirdparty/libjpeg-turbo/jutils.c",
	"neo/thirdparty/libjpeg-turbo/jmemmgr.c",
	"neo/thirdparty/libjpeg-turbo/jmemnobs.c",
	"neo/thirdparty/libjpeg-turbo/jaricom.c",
	"neo/thirdparty/libjpeg-turbo/jcarith.c",
	"neo/thirdparty/libjpeg-turbo/jdarith.c",
	"neo/thirdparty/libjpeg-turbo/jsimd_none.c"
}

project( "libjpeg-turbo" )
	kind( "StaticLib" )
	language( "C" )
	warnings( "Off" )
	includedirs( { "neo/thirdparty/libjpeg-turbo-custom" } )
	
	files( { jpeg_hdrs, jpeg_srcs } )
	
group( "" )
