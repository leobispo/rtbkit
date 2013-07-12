AC_DEFUN([AX_LIB_V8],
[
  ac_v8_path="$2"
  V8_CPPFLAGS=""
  V8_LDFLAGS=""

  ac_v8_header="v8.h"

  v8_version_req=ifelse([$1], [], [2.0.5.2], [$1])
  v8_version_req_shorten=`expr $v8_version_req : '\([[0-9]]*\.[[0-9]]*\)'`
  v8_version_req_major=`expr $v8_version_req : '\([[0-9]]*\)'`
  v8_version_req_minor=`expr $v8_version_req : '[[0-9]]*\.\([[0-9]]*\)'`
  v8_version_req_micro=`expr $v8_version_req : '[[0-9]]*\.[[0-9]]*\.\([[0-9]]*\)'`
  v8_version_req_nano=`expr $v8_version_req : '[[0-9]]*\.[[0-9]]*\.[[0-9]]*\.\([[0-9]]*\)'`
  if test "$v8_version_req_nano" = ""
  then
    v8_version_req_nano="0"
  fi

  v8_version_req_number=`expr $v8_version_req_major \* 1000000000 \
                           \+ $v8_version_req_minor \* 1000000 \
                           \+ $v8_version_req_micro \* 1000 \
                           \+ $v8_version_req_nano`

  for ac_v8_path_tmp in /usr /usr/local /opt $ac_v8_path
  do
    if test -f "$ac_v8_path_tmp/include/$ac_v8_header" && test -r "$ac_v8_path_tmp/include/$ac_v8_header"
    then
      ac_v8_path=$ac_v8_path_tmp
      ac_v8_cppflags="-I$ac_v8_path_tmp/include"
      ac_v8_ldflags="-L$ac_v8_path_tmp/lib"
      break;
    elif test -f "$ac_v8_path_tmp/include/v8/$ac_v8_header" && test -r "$ac_v8_path_tmp/include/v8/$ac_v8_header"
    then
      ac_v8_path=$ac_v8_path_tmp
      ac_v8_cppflags="-I$ac_v8_path_tmp/include/v8"
      ac_v8_ldflags="-L$ac_v8_path_tmp/lib"
      break;
    fi
  done

  ac_v8_ldflags="$ac_v8_ldflags -lv8"

  saved_CPPFLAGS="$CPPFLAGS"
  CPPFLAGS="$CPPFLAGS $ac_v8_cppflags"

  saved_LDFLAGS="$LDFLAGS"
  LDFLAGS="$LDFLAGS $ac_v8_ldflags"

  saved_LIBS="$LIBS"
  LIBS="$LIBS $ac_v8_ldflags"

  AC_MSG_CHECKING(for V8 library >= $v8_version_req)
  AC_LANG_SAVE
  AC_LANG_CPLUSPLUS
  AC_TRY_RUN([
    #include <v8.h>
    #include <stdint.h>
    #include <stdio.h>

    int main () {
      int major, minor, micro, nano;
      sscanf(v8::V8::GetVersion(), "%d.%d.%d.%d", &major, &minor, &micro, &nano);
      uint64_t version = (major * 1000000000) + (minor * 1000000) + (micro * 1000) + nano;

      if (version >= $v8_version_req_number)
        return 0;

      return 1;
    }], [success=yes], [success=no], [success=no]
  )
  AC_LANG_RESTORE
  AC_MSG_RESULT([$success])

  CPPFLAGS="$saved_CPPFLAGS"
  LDFLAGS="$saved_LDFLAGS"
  LIBS="$saved_LIBS"

  if test "$success" = "yes"
  then
    V8_CPPFLAGS="$ac_v8_cppflags"
    V8_LDFLAGS="$ac_v8_ldflags"
    V8_LIBS="$ac_v8_ldflags"

    AC_SUBST(V8_CPPFLAGS)
    AC_SUBST(V8_LIBS)
    AC_SUBST(V8_LDFLAGS)
    AC_DEFINE([HAVE_V8], [], [Have the V8 library])
  else
    AC_MSG_ERROR([V8 library not found])
  fi
])
