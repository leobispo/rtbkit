AC_DEFUN([AX_ZMQ], [
  ZMQ_LIB=""
  for ac_zmq in $2 /usr /usr/local /opt /opt/local
  do
    old_LDFLAGS="$LDFLAGS"
    LDFLAGS="-L$ac_zmq/lib"

    AC_CHECK_LIB([zmq], [zmq_poll], [link_zmq="yes"], [link_zmq="no"])

    LDFLAGS=$old_LDFLAGS
    if test "$link_zmq" = "yes"
    then
      ZMQ_LIB="-L$ac_zmq/lib -lzmq"
      AC_SUBST(ZMQ_LIB)
      ZMQ_FLAGS="-I$ac_zmq/include"
      AC_SUBST(ZMQ_FLAGS)
      break
    fi
  done

  success=no
  if test $link_zmq = "yes"
  then
    zmq_version_req=ifelse([$1], , [3.2.3], [$1])
 
    zmq_version_req_shorten=`expr $zmq_version_req : '\([[0-9]]*\.[[0-9]]*\)'`
    zmq_version_req_major=`expr $zmq_version_req : '\([[0-9]]*\)'`
    zmq_version_req_minor=`expr $zmq_version_req : '[[0-9]]*\.\([[0-9]]*\)'`
    zmq_version_req_micro=`expr $zmq_version_req : '[[0-9]]*\.[[0-9]]*\.\([[0-9]]*\)'`
   
    zmq_version_req_number=`expr $zmq_version_req_major \* 10000 \
                              \+ $zmq_version_req_minor \* 100 \
                              \+ $zmq_version_req_micro`
  
    AC_MSG_CHECKING(for zmq = $zmq_version_req)
    
    old_CXXFLAGS=$CXXFLAGS
    old_LIBS="$LIBS"
    CXXFLAGS="$CXXFLAGS $ZMQ_FLAGS"
    LIBS="$LIBS $ZMQ_LIB"
    AC_LANG_SAVE
    AC_LANG_CPLUSPLUS

    AC_TRY_RUN([#include <zmq.h>
      #include <stdint.h>
      int main () {
        uint64_t version = ZMQ_VERSION;

        if (version == $zmq_version_req_number)
          return 0;

        return 1;
      }], [success=yes], [success=no], [success=no]
    )
    AC_LANG_RESTORE
    CXXFLAGS=$old_CXXFLAGS
    LIBS="$old_LIBS"

    if test "$success" = "yes"
    then
      AC_MSG_RESULT(yes)
      AC_DEFINE([HAVE_ZMQ], [], [Have the ZMQ Installed])
    else
      AC_MSG_RESULT(no)
    fi
  fi
 
  if test "$success" = "no"
  then
    AC_MSG_ERROR([ZMQ not found on the system.])
  fi
])
