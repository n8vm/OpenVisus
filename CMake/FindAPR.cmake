# - Find Apache Portable Runtime
# Find the APR includes and libraries
# This module defines
#  APR_INCLUDE_DIR and APRUTIL_INCLUDE_DIR, where to find apr.h, etc.
#  APR_LIBRARIES and APRUTIL_LIBRARIES, the libraries needed to use APR.
#  APR_FOUND and APRUTIL_FOUND, If false, do not try to use APR.
# also defined, but not for general use are
#  APR_LIBRARY and APRUTIL_LIBRARY, where to find the APR library.
#
# Set APR_DIR to search an additional location for the library.

# APR first.

FIND_PATH(APR_INCLUDE_DIR apr.h
${APR_DIR}/include
/usr/local/apr/include/apr-1
/usr/local/apache2/include
/usr/local/include/apr-1
/usr/local/include/apr-1.0
/usr/include/apr-1
/usr/include/apr-1.0
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include/apr-1/
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.13.sdk/usr/include/apr-1/
)

FIND_PATH(HTTPD_INCLUDE_DIR httpd.h
${APR_DIR}/include
/usr/local/apache2/include
/usr/local/include/apr-1
/usr/local/include/apr-1.0
/usr/include/apr-1
/usr/include/apr-1.0
/usr/include/apache2/
/usr/include/httpd/
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include/apache2/
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.13.sdk/usr/include/apache2/
)

SET(APR_NAMES ${APR_NAMES} apr-1)
FIND_LIBRARY(APR_LIBRARY
  NAMES ${APR_NAMES}
  PATHS ${APR_DIR}/lib /usr/local/apr/lib /usr/lib /usr/local/lib /usr/local/apache2/lib 
  )

IF (APR_LIBRARY AND APR_INCLUDE_DIR AND HTTPD_INCLUDE_DIR)
    SET(APR_LIBRARIES ${APR_LIBRARY})
    SET(APR_FOUND "YES")
ELSE (APR_LIBRARY AND APR_INCLUDE_DIR AND HTTPD_INCLUDE_DIR)
  SET(APR_FOUND "NO")
ENDIF (APR_LIBRARY AND APR_INCLUDE_DIR AND HTTPD_INCLUDE_DIR)


IF (APR_FOUND)
   IF (NOT APR_FIND_QUIETLY)
      MESSAGE(STATUS "Found APR: ${APR_LIBRARIES}")
   ENDIF (NOT APR_FIND_QUIETLY)
ELSE (APR_FOUND)
   IF (APR_FIND_REQUIRED)
      MESSAGE(FATAL_ERROR "Could not find APR library")
   ENDIF (APR_FIND_REQUIRED)
ENDIF (APR_FOUND)

# Deprecated declarations.
SET (NATIVE_APR_INCLUDE_PATH ${APR_INCLUDE_DIR} )
GET_FILENAME_COMPONENT (NATIVE_APR_LIB_PATH ${APR_LIBRARY} PATH)

MARK_AS_ADVANCED(
  APR_LIBRARY
  APR_INCLUDE_DIR
  )

# Next, APRUTIL.

FIND_PATH(APRUTIL_INCLUDE_DIR apu.h
${APR_DIR}/include
/usr/local/apr/include/apr-1
/usr/local/apache2/include
/usr/local/include/apr-1
/usr/local/include/apr-1.0
/usr/include/apr-1
/usr/include/apr-1.0
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include/apr-1/
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.13.sdk/usr/include/apr-1/
)

SET(APRUTIL_NAMES ${APRUTIL_NAMES} aprutil-1)
FIND_LIBRARY(APRUTIL_LIBRARY
  NAMES ${APRUTIL_NAMES}
  PATHS ${APR_DIR}/lib /usr/local/apr/lib /usr/lib /usr/local/lib /usr/local/apache2/lib 
  )

IF (APRUTIL_LIBRARY AND APRUTIL_INCLUDE_DIR)
    SET(APRUTIL_LIBRARIES ${APRUTIL_LIBRARY})
    SET(APRUTIL_FOUND "YES")
ELSE (APRUTIL_LIBRARY AND APRUTIL_INCLUDE_DIR)
  SET(APRUTIL_FOUND "NO")
ENDIF (APRUTIL_LIBRARY AND APRUTIL_INCLUDE_DIR)


IF (APRUTIL_FOUND)
   IF (NOT APRUTIL_FIND_QUIETLY)
      MESSAGE(STATUS "Found APRUTIL: ${APRUTIL_LIBRARIES}")
   ENDIF (NOT APRUTIL_FIND_QUIETLY)
ELSE (APRUTIL_FOUND)
   IF (APRUTIL_FIND_REQUIRED)
      MESSAGE(FATAL_ERROR "Could not find APRUTIL library")
   ENDIF (APRUTIL_FIND_REQUIRED)
ENDIF (APRUTIL_FOUND)

# Deprecated declarations.
SET (NATIVE_APRUTIL_INCLUDE_PATH ${APRUTIL_INCLUDE_DIR} )
GET_FILENAME_COMPONENT (NATIVE_APRUTIL_LIB_PATH ${APRUTIL_LIBRARY} PATH)

MARK_AS_ADVANCED(
  APRUTIL_LIBRARY
  APRUTIL_INCLUDE_DIR
  )
  
