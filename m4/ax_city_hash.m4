AC_DEFUN_ONCE([AX_CITYHASH],
[
  link_cityhash="no"
  AC_CANONICAL_HOST
  for ac_cityhash in $1 /usr /usr/local /opt /opt/local
  do
    old_LDFLAGS="$LDFLAGS"
    LDFLAGS="-L$ac_cityhash/lib"
    AC_CHECK_LIB([cityhash], [main], [link_cityhash="yes"], [link_cityhash="no"])

    LDFLAGS=$old_LDFLAGS
    if test "$link_cityhash" = "yes"
    then
      old_CXXFLAGS="$CXXFLAGS"
      CXXFLAGS="-I $ac_cityhash/include"
      AC_CHECK_HEADERS([city.h],, [AC_MSG_ERROR([missing city.h header])])
      CXXFLAGS="$old_CXXFLAGS"
      CITYHASH_LIB="-L$ac_cityhash/lib -lcityhash"
      AC_SUBST(CITYHASH_LIB)
      CITYHASH_FLAGS="-I$ac_cityhash/include"
      AC_SUBST(CITYHASH_FLAGS)
      break
    fi
  done

  if test "$link_cityhash" = "no"
  then
    AC_MSG_ERROR(CityHash library not found)
  fi
])
