AC_DEFUN_ONCE([AX_SSH2],
[
  link_ssh2="no"
  AC_CANONICAL_HOST
  for ac_ssh2 in $1 /usr /usr/local /opt /opt/local
  do
    old_LDFLAGS="$LDFLAGS"
    LDFLAGS="-L$ac_ssh2/lib"

    AC_CHECK_LIB([ssh2], [libssh2_sftp_tell64], [link_ssh2="yes"], [link_ssh2="no"])

    LDFLAGS=$old_LDFLAGS
    if test "$link_ssh2" = "yes"
    then
      SSH2_LIB="-L$ac_ssh2/lib -lssh2"
      AC_SUBST(SSH2_LIB)
      SSH2_FLAGS="-I$ac_ssh2/include"
      AC_SUBST(SSH2_FLAGS)

      break
    fi
  done

  if test "$link_ssh2" = "no"
  then
    AC_MSG_ERROR(SSH2 library not found)
  fi
])
