AC_DEFUN_ONCE([AX_URCU],
[
  link_urcu="no"
  AC_CANONICAL_HOST
  for ac_urcu in $1 /usr /usr/local /opt /opt/local
  do
    old_LDFLAGS="$LDFLAGS"
    LDFLAGS="-L$ac_urcu/lib"

    AC_CHECK_LIB([urcu], [rcu_read_lock_mb], [link_urcu="yes"], [link_urcu="no"])

    LDFLAGS=$old_LDFLAGS
    if test "$link_urcu" = "yes"
    then
      URCU_LIB="-L$ac_urcu/lib -lurcu"
      AC_SUBST(URCU_LIB)
      URCU_FLAGS="-I$ac_urcu/include"
      AC_SUBST(URCU_FLAGS)

      break
    fi
  done

  if test "$link_urcu" = "no"
  then
    AC_MSG_ERROR(URCU library not found)
  fi
])
