AC_DEFUN_ONCE([AX_SNAPPY],
[
  link_snappy="no"
  AC_CANONICAL_HOST
  for ac_snappy in $1 /usr /usr/local /opt /opt/local
  do
    old_LDFLAGS="$LDFLAGS"
    LDFLAGS="-L$ac_snappy/lib"

    AC_CHECK_LIB([snappy], [snappy_compress], [link_snappy="yes"], [link_snappy="no"])

    LDFLAGS=$old_LDFLAGS
    if test "$link_snappy" = "yes"
    then
      SNAPPY_LIB="-L$ac_snappy/lib -lsnappy"
      AC_SUBST(SNAPPY_LIB)
      SNAPPY_FLAGS="-I$ac_snappy/include"
      AC_SUBST(SNAPPY_FLAGS)

      AS_CASE(["$host_os"],
        [linux*], [
          SNAPPY_FLAGS="$SNAPPY_FLAGS -DOS_LINUX -DPLATFORM=OS_LINUX -DSNAPPY=1 -DLEVELDB_PLATFORM_POSIX"
        ],
        [
          SNAPPY_FLAGS="$SNAPPY_FLAGS -D_REENTRANT -DOS_FREEBSD -DSNAPPY=1 -DLEVELDB_PLATFORM_POSIX"
        ]
      )

      break
    fi
  done

  if test "$link_snappy" = "no"
  then
    AC_MSG_ERROR(Snappy library not found)
  fi
])
