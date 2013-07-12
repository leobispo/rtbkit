AC_DEFUN_ONCE([AX_HIREDIS],
[
  link_hiredis="no"
  AC_CANONICAL_HOST
  for ac_hiredis in $1 /usr /usr/local /opt /opt/local
  do
    old_LDFLAGS="$LDFLAGS"
    LDFLAGS="-L$ac_hiredis/lib"

    AC_CHECK_LIB([hiredis], [redisAsyncSetDisconnectCallback], [link_hiredis="yes"], [link_hiredis="no"])

    LDFLAGS=$old_LDFLAGS
    if test "$link_hiredis" = "yes"
    then
      HIREDIS_LIB="-L$ac_hiredis/lib -lhiredis"
      AC_SUBST(HIREDIS_LIB)
      HIREDIS_FLAGS="-I$ac_hiredis/include"
      AC_SUBST(HIREDIS_FLAGS)

      break
    fi
  done

  if test "$link_hiredis" = "no"
  then
    AC_MSG_ERROR(HIRedis library not found)
  else
    ac_redis_path=`echo "$1/bin" | sed "s/ /\/bin:/g"`

    AC_PATH_PROG([RSERVER], [redis-server], [no], [$PATH:$ac_redis_path])
    if test $RSERVER = "no"; then
      AC_MSG_ERROR([Could not find redis server.])
    else
      AC_DEFINE_UNQUOTED(REDIS_SERVER, "$RSERVER", [Helper to define where to find the correct redis server location])
    fi
  fi
])
