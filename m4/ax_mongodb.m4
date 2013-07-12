AC_DEFUN_ONCE([AX_MONGODB],
[
  link_mongodb="no"
  AC_CANONICAL_HOST
  for ac_mongodb in $1 /usr /usr/local /opt /opt/local
  do
    old_LDFLAGS="$LDFLAGS"
    LDFLAGS="-L$ac_mongodb/lib"

    AC_CHECK_LIB([mongoclient], [main], [link_mongodb="yes"], [link_mongodb="no"])

    LDFLAGS=$old_LDFLAGS
    if test "$link_mongodb" = "yes"
    then
      MONGODB_LIB="-L$ac_mongodb/lib -lmongoclient"
      AC_SUBST(MONGODB_LIB)
      MONGODB_FLAGS="-I$ac_mongodb/include"
      AC_SUBST(MONGODB_FLAGS)

      break
    fi
  done

  if test "$link_mongodb" = "no"
  then
    AC_MSG_ERROR(MongoDB library not found)
  fi
])
