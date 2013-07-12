AC_DEFUN([AX_LIBCURLPP],
[
  AC_PROG_AWK

  _curlpp_version_parse="eval $AWK '{split(\$NF,A,\".\"); X=256*256*A[[1]]+256*A[[2]]+A[[3]]; print X;}'"

  _curlpp_try_link=yes


  ac_node_path=`echo "$2/bin" | sed "s/ /\/bin:/g"`

  AC_PATH_PROG([_curlpp_config], [curlpp-config], [no], [$PATH:$ac_node_path])

  if test x$_curlpp_config != "x" ; then
    AC_CACHE_CHECK([for the version of curlpp],
      [curlpp_cv_lib_curlpp_version],
      [curlpp_cv_lib_curlpp_version=`$_curlpp_config --version | $AWK '{print $[]2}'`])

    _curlpp_version=`echo $curlpp_cv_lib_curlpp_version | $_curlpp_version_parse`
    _curlpp_wanted=`echo ifelse([$1],,[0],[$1]) | $_curlpp_version_parse`

    if test $_curlpp_wanted -gt 0 ; then
      AC_CACHE_CHECK([for curlpp >= version $1],
        [curlpp_cv_lib_version_ok],
        [
          if test $_curlpp_version -ge $_curlpp_wanted ; then
            curlpp_cv_lib_version_ok=yes
          else
            curlpp_cv_lib_version_ok=no
          fi
        ]
      )
    fi

    if test $_curlpp_wanted -eq 0 || test x$curlpp_cv_lib_version_ok = xyes ; then
      if test x"$CURLPP_CPPFLAGS" = "x" ; then
        CURLPP_CPPFLAGS=`$_curlpp_config --cflags`
      fi
      if test x"$CURLPP" = "x" ; then
        CURLPP=`$_curlpp_config --libs`
      fi
    else
      _curlpp_try_link=no
    fi
    unset _curlpp_wanted
  fi

  success=no
  if test $_curlpp_try_link = yes ; then
    AC_MSG_CHECKING([wether curlpp is usable])

    old_CXXFLAGS=$CXXFLAGS
    CXXFLAGS="$CXXFLAGS $CURLPP_CPPFLAGS"
    old_LIBS="$LIBS"
    LIBS="$LIBS $CURLPP"
    AC_LANG_SAVE
    AC_LANG_CPLUSPLUS

    AC_TRY_RUN([
      #include <curlpp/cURLpp.hpp>
      #include <stdint.h>
      int main () {
        curlpp::initialize();
        return 0;
      }
    ], [success=yes], [success=no], [success=no])
    AC_LANG_RESTORE
    CXXFLAGS=$old_CXXFLAGS
    LIBS=$old_LIBS
    if test "$success" = "yes"
    then
      AC_DEFINE(HAVE_CURLPP,1,
        [Define to 1 if you have a functional curlpp library.])
      AC_SUBST(CURLPP_CPPFLAGS)
      AC_SUBST(CURLPP)
    fi

    AC_MSG_RESULT($success)
  fi

  unset _curlpp_try_link
  unset _curlpp_version_parse
  unset _curlpp_config
  unset _curlpp_feature
  unset _curlpp_features
  unset _curlpp_protocol
  unset _curlpp_protocols
  unset _curlpp_version

  if test x$success != xyes ; then
    AC_MSG_ERROR([libcurl++ cannot be found on the system.])
  fi
])
