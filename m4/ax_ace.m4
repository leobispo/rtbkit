AC_DEFUN_ONCE([AX_ACE],
[
  link_ACE="no"
  AC_CANONICAL_HOST
  for ac_ACE in $1 /usr /usr/local /opt /opt/local
  do
    old_LDFLAGS="$LDFLAGS"
    LDFLAGS="-L$ac_ACE/lib"

    AC_CHECK_LIB([ACE], [main], [link_ACE="yes"], [link_ACE="no"])
    AC_CHECK_LIB([pthread], [pthread_create], [pt="yes"], [pt="no"])

    LDFLAGS=$old_LDFLAGS
    if test "$link_ACE" = "yes"
    then
      ACE_LIB="-L$ac_ACE/lib -lACE"
      ACE_FLAGS="-I$ac_ACE/include"

      if test $pt = "yes"
      then
        ACE_LIB="$ACE_LIB -lpthread"
      fi

      AC_SUBST(ACE_LIB)
      AC_SUBST(ACE_FLAGS)

      break
    fi
  done

  if test "$link_ACE" = "no"
  then
    AC_MSG_ERROR(ACE library not found)
  fi
])
