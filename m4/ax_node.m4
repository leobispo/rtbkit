# SYNOPSIS
#
# AX_NODE([NODE_VERSION], [POSSIBLE_PATHS]
#
# DESCRIPTION
#
# Test for NODEJS libraries and binaries for a particular version.
#
# It will run under under /usr, /usr/local, /opt and /opt/local and evaluates the POSSIBLE_PATHS as well.
#
#
#
AC_DEFUN([AX_NODEJS], [
  node_version_req=ifelse([$1], , [0.6.19.1], [$1])

  node_version_req_shorten=`expr $node_version_req : '\([[0-9]]*\.[[0-9]]*\)'`
  node_version_req_major=`expr $node_version_req : '\([[0-9]]*\)'`
  node_version_req_minor=`expr $node_version_req : '[[0-9]]*\.\([[0-9]]*\)'`
  node_version_req_micro=`expr $node_version_req : '[[0-9]]*\.[[0-9]]*\.\([[0-9]]*\)'`
  node_version_req_nano=`expr $node_version_req : '[[0-9]]*\.[[0-9]]*\.[[0-9]]*\.\([[0-9]]*\)'`

  if test "$node_version_req_nano" = ""
  then
    node_version_req_nano="0"
  fi

  node_version_req_number=`expr $node_version_req_major \* 1000000000 \
                             \+ $node_version_req_minor \* 1000000 \
                             \+ $node_version_req_micro \* 1000 \
                             \+ $node_version_req_nano`

  ac_node_path=`echo "$2/bin" | sed "s/ /\/bin:/g"`

  AC_PATH_PROG([COFFEE], [coffee], [no], [$PATH:$ac_node_path:$ac_pwd/node_modules/coffee-script/bin:$HOME/node_modules/coffee-script/bin])
  AC_PATH_PROGS([NODEJS], [node nodejs], [no], [$PATH:$ac_node_path])
  AC_PATH_PROGS([VOWS], [vows], [no], [$PATH:$ac_node_path:$ac_pwd/node_modules/vows/bin:$HOME/node_modules/vows/bin])

  if [ test "$COFFEE" = "no" ] || [ test "$NODEJS" = "no" ] || [ test "$VOWS" = "no" ]
  then
    AC_MSG_ERROR([Node js is required])
  fi

  AC_MSG_CHECKING(for nodejs >= $node_version_req)
  success=no

  arg_list=`echo $2/include | sed "s/ /\/include /g"`
  arg_list_node=`echo $2/include/node | sed "s/ /\/include\/node /g"`
  arg_list="$arg_list $arg_list_node /usr/include /usr/local/include /opt/include /opt/local/include"
  for ac_node_include_path in $arg_list
  do
    if test "$success" = "yes"
    then
      break
    fi
    for ac_node_include_n_path in node nodejs
    do
      old_CXXFLAGS=$CXXFLAGS
      CXXFLAGS="$CXX_FLAGS -I $ac_node_include_path/$ac_node_include_n_path"
      AC_LANG_SAVE
      AC_LANG_CPLUSPLUS
      AC_TRY_RUN([#include <node_version.h>
        #include <stdint.h>
        int main () {
          uint64_t version = (NODE_MAJOR_VERSION * 1000000000) + (NODE_MINOR_VERSION * 1000000)
            + (NODE_PATCH_VERSION * 1000) + NODE_VERSION_IS_RELEASE;

          if (version >= $node_version_req_number)
            return 0;

          return 1;
        }], [success=yes], [success=no], [success=no]
      )

      AC_LANG_RESTORE
      CXXFLAGS=$old_CXXFLAGS

      if test "$success" = "yes"
      then
        NODE_FLAGS="-I $ac_node_include_path/$ac_node_include_n_path"
        break
      fi
    done
  done

  if test "$success" = "yes"
  then
    AC_MSG_RESULT(yes)
    AC_SUBST(NODE_FLAGS)
    AC_DEFINE([HAVE_NODEJS], [], [Have the Nodejs Installed])
    AC_SUBST(NODE_LIB)
  else
    AC_MSG_RESULT(no)
    AC_MSG_ERROR([Node js is required])
  fi
])
