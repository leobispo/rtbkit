AC_DEFUN_ONCE([AX_ZOOKEEPER],
[
  link_zookeeper="no"
  AC_CANONICAL_HOST
  for ac_zookeeper in $1 /usr /usr/local /opt /opt/local
  do
    old_LDFLAGS="$LDFLAGS"
    LDFLAGS="-L$ac_zookeeper/lib"

    AC_CHECK_LIB([zookeeper_mt], [zoo_async], [link_zookeeper="yes"], [link_zookeeper="no"])

    LDFLAGS=$old_LDFLAGS
    if test "$link_zookeeper" = "yes"
    then
      ZOOKEEPER_LIB="-L$ac_zookeeper/lib -lzookeeper_mt"
      AC_SUBST(ZOOKEEPER_LIB)
      ZOOKEEPER_FLAGS="-I$ac_zookeeper/include"
      AC_SUBST(ZOOKEEPER_FLAGS)

      break
    fi
  done

  if test "$link_zookeeper" = "no"
  then
    AC_MSG_ERROR(ZooKeeper library not found)
  else
    ac_zookeeper_path=`echo "$1/bin/zookeeper/bin" | sed "s/ /\/bin\/zookeeper\/bin:/g"`

    AC_PATH_PROG([ZSERVER], [zkServer.sh], [no], [$PATH:/usr/share/zookeeper/bin:$ac_zookeeper_path])
    if test $ZSERVER = "no"; then
      AC_MSG_ERROR([Could not find zookeeper server.])
    else
      AC_DEFINE_UNQUOTED(ZOO_SERVER, "$ZSERVER", [Helper to define where to find the correct zookeeper server location])
    fi
  fi
])
