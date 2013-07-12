AC_DEFUN([AX_LIBCURL],
[
  AH_TEMPLATE([LIBCURL_FEATURE_SSL],[Defined if libcurl supports SSL])
  AH_TEMPLATE([LIBCURL_FEATURE_KRB4],[Defined if libcurl supports KRB4])
  AH_TEMPLATE([LIBCURL_FEATURE_IPV6],[Defined if libcurl supports IPv6])
  AH_TEMPLATE([LIBCURL_FEATURE_LIBZ],[Defined if libcurl supports libz])
  AH_TEMPLATE([LIBCURL_FEATURE_ASYNCHDNS],[Defined if libcurl supports AsynchDNS])
  AH_TEMPLATE([LIBCURL_FEATURE_IDN],[Defined if libcurl supports IDN])
  AH_TEMPLATE([LIBCURL_FEATURE_SSPI],[Defined if libcurl supports SSPI])
  AH_TEMPLATE([LIBCURL_FEATURE_NTLM],[Defined if libcurl supports NTLM])
 
  AH_TEMPLATE([LIBCURL_PROTOCOL_HTTP],[Defined if libcurl supports HTTP])
  AH_TEMPLATE([LIBCURL_PROTOCOL_HTTPS],[Defined if libcurl supports HTTPS])
  AH_TEMPLATE([LIBCURL_PROTOCOL_FTP],[Defined if libcurl supports FTP])
  AH_TEMPLATE([LIBCURL_PROTOCOL_FTPS],[Defined if libcurl supports FTPS])
  AH_TEMPLATE([LIBCURL_PROTOCOL_FILE],[Defined if libcurl supports FILE])
  AH_TEMPLATE([LIBCURL_PROTOCOL_TELNET],[Defined if libcurl supports TELNET])
  AH_TEMPLATE([LIBCURL_PROTOCOL_LDAP],[Defined if libcurl supports LDAP])
  AH_TEMPLATE([LIBCURL_PROTOCOL_DICT],[Defined if libcurl supports DICT])
  AH_TEMPLATE([LIBCURL_PROTOCOL_TFTP],[Defined if libcurl supports TFTP])
  AH_TEMPLATE([LIBCURL_PROTOCOL_RTSP],[Defined if libcurl supports RTSP])
  AH_TEMPLATE([LIBCURL_PROTOCOL_POP3],[Defined if libcurl supports POP3])
  AH_TEMPLATE([LIBCURL_PROTOCOL_IMAP],[Defined if libcurl supports IMAP])
  AH_TEMPLATE([LIBCURL_PROTOCOL_SMTP],[Defined if libcurl supports SMTP])
 
  AC_PROG_AWK
 
  _libcurl_version_parse="eval $AWK '{split(\$NF,A,\".\"); X=256*256*A[[1]]+256*A[[2]]+A[[3]]; print X;}'"
 
  _libcurl_try_link=yes
 
  _libcurl_config="no"
  for ac_curl_lib_dir in $2
  do
    AC_PATH_PROG([_libcurl_config], [curl-config], [no], [$ac_curl_lib_dir/bin])
    if test "$_libcurl_config" != "no"
    then
      LIBCURL_CPPFLAGS="-I$ac_curl_lib_dir/include"
      _libcurl_ldflags="-L$ac_curl_lib_dir/lib"
      break
    fi
  done

  if test "$_libcurl_config" = "no"
  then
    AC_PATH_PROG([_libcurl_config], [curl-config])
  fi

  if test $_libcurl_config != "no" ; then
    AC_CACHE_CHECK([for the version of libcurl],
      [libcurl_cv_lib_curl_version],
      [libcurl_cv_lib_curl_version=`$_libcurl_config --version | $AWK '{print $[]2}'`]
    )
 
    _libcurl_version=`echo $libcurl_cv_lib_curl_version | $_libcurl_version_parse`
    _libcurl_wanted=`echo ifelse([$1],,[0],[$1]) | $_libcurl_version_parse`
 
    if test $_libcurl_wanted -gt 0 ; then
      AC_CACHE_CHECK([for libcurl >= version $1],
        [libcurl_cv_lib_version_ok],
        [
          if test $_libcurl_version -ge $_libcurl_wanted ; then
            libcurl_cv_lib_version_ok=yes
          else
            libcurl_cv_lib_version_ok=no
          fi
        ]
      )
    fi
 
    if test $_libcurl_wanted -eq 0 || test x$libcurl_cv_lib_version_ok = xyes ; then
      if test x"$LIBCURL_CPPFLAGS" = "x" ; then
        LIBCURL_CPPFLAGS=`$_libcurl_config --cflags`
      fi
      if test x"$LIBCURL" = "x" ; then
        LIBCURL=`$_libcurl_config --libs`
      fi
 
      _libcurl_features=`$_libcurl_config --feature`
 
      if test $_libcurl_version -ge 461828 ; then
        _libcurl_protocols=`$_libcurl_config --protocols`
      fi
    else
      _libcurl_try_link=no
    fi
 
    unset _libcurl_wanted
  fi
 
  if test $_libcurl_try_link = yes ; then
 
     # we didn't find curl-config, so let's see if the user-supplied
     # link line (or failing that, "-lcurl") is enough.
     LIBCURL=${LIBCURL-"$_libcurl_ldflags -lcurl"}
 
     AC_CACHE_CHECK([whether libcurl is usable],
        [libcurl_cv_lib_curl_usable],
        [
        _libcurl_save_cppflags=$CPPFLAGS
        CPPFLAGS="$LIBCURL_CPPFLAGS $CPPFLAGS"
        _libcurl_save_libs=$LIBS
        LIBS="$LIBCURL $LIBS"
 
        AC_LINK_IFELSE([AC_LANG_PROGRAM([#include <curl/curl.h>],[
/* Try and use a few common options to force a failure if we are
  missing symbols or can't link. */
int x;
curl_easy_setopt(NULL,CURLOPT_URL,NULL);
x=CURL_ERROR_SIZE;
x=CURLOPT_WRITEFUNCTION;
x=CURLOPT_FILE;
x=CURLOPT_ERRORBUFFER;
x=CURLOPT_STDERR;
x=CURLOPT_VERBOSE;
])],libcurl_cv_lib_curl_usable=yes,libcurl_cv_lib_curl_usable=no)
 
        CPPFLAGS=$_libcurl_save_cppflags
        LIBS=$_libcurl_save_libs
        unset _libcurl_save_cppflags
        unset _libcurl_save_libs
        ])
 
     if test $libcurl_cv_lib_curl_usable = yes ; then
 
        # Does curl_free() exist in this version of libcurl?
        # If not, fake it with free()
 
        _libcurl_save_cppflags=$CPPFLAGS
        CPPFLAGS="$CPPFLAGS $LIBCURL_CPPFLAGS"
        _libcurl_save_libs=$LIBS
        LIBS="$LIBS $LIBCURL"
 
        AC_CHECK_FUNC(curl_free,,
           AC_DEFINE(curl_free,free,
             [Define curl_free() as free() if our version of curl lacks curl_free.]))
 
        CPPFLAGS=$_libcurl_save_cppflags
        LIBS=$_libcurl_save_libs
        unset _libcurl_save_cppflags
        unset _libcurl_save_libs
 
        AC_DEFINE(HAVE_LIBCURL,1,
          [Define to 1 if you have a functional curl library.])
        AC_SUBST(LIBCURL_CPPFLAGS)
        AC_SUBST(LIBCURL)
 
        for _libcurl_feature in $_libcurl_features ; do
           AC_DEFINE_UNQUOTED(AS_TR_CPP(libcurl_feature_$_libcurl_feature),[1])
           eval AS_TR_SH(libcurl_feature_$_libcurl_feature)=yes
        done
 
        if test "x$_libcurl_protocols" = "x" ; then
 
           # We don't have --protocols, so just assume that all
           # protocols are available
           _libcurl_protocols="HTTP FTP FILE TELNET LDAP DICT TFTP"
 
           if test x$libcurl_feature_SSL = xyes ; then
              _libcurl_protocols="$_libcurl_protocols HTTPS"
 
              # FTPS wasn't standards-compliant until version
              # 7.11.0 (0x070b00 == 461568)
              if test $_libcurl_version -ge 461568; then
                 _libcurl_protocols="$_libcurl_protocols FTPS"
              fi
           fi
        fi
 
        for _libcurl_protocol in $_libcurl_protocols ; do
           AC_DEFINE_UNQUOTED(AS_TR_CPP(libcurl_protocol_$_libcurl_protocol),[1])
           eval AS_TR_SH(libcurl_protocol_$_libcurl_protocol)=yes
        done
     else
        unset LIBCURL
        unset LIBCURL_CPPFLAGS
     fi
  fi
 
  unset _libcurl_try_link
  unset _libcurl_version_parse
  unset _libcurl_config
  unset _libcurl_feature
  unset _libcurl_features
  unset _libcurl_protocol
  unset _libcurl_protocols
  unset _libcurl_version
  unset _libcurl_ldflags
 
  if test x$libcurl_cv_lib_curl_usable != xyes ; then
    AC_MSG_ERROR([libcurl cannot be found on the system.])
  fi
])
