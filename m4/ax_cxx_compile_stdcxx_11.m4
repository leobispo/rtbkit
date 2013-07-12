# ============================================================================
#  http://www.gnu.org/software/autoconf-archive/ax_cxx_compile_stdcxx_11.html
# ============================================================================
#
# SYNOPSIS
#
#   AX_CXX_COMPILE_STDCXX_11([ext|noext],[mandatory|optional])
#
# DESCRIPTION
#
#   Check for baseline language coverage in the compiler for the C++11
#   standard; if necessary, add switches to CXXFLAGS to enable support.
#
#   The first argument, if specified, indicates whether you insist on an
#   extended mode (e.g. -std=gnu++11) or a strict conformance mode (e.g.
#   -std=c++11).  If neither is specified, you get whatever works, with
#   preference for an extended mode.
#
#   The second argument, if specified 'mandatory' or if left unspecified,
#   indicates that baseline C++11 support is required and that the macro
#   should error out if no mode with that support is found.  If specified
#   'optional', then configuration proceeds regardless, after defining
#   HAVE_CXX11 if and only if a supporting mode is found.
#
# LICENSE
#
#   Copyright (c) 2008 Benjamin Kosnik <bkoz@redhat.com>
#   Copyright (c) 2012 Zack Weinberg <zackw@panix.com>
#   Copyright (c) 2013 Roy Stogner <roystgnr@ices.utexas.edu>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 3

m4_define([_AX_CXX_COMPILE_STDCXX_11_testbody], [
  template <typename T>
    struct check
    {
      static_assert(sizeof(int) <= sizeof(T), "not big enough");
    };

    typedef check<check<bool>> right_angle_brackets;

    int a;
    decltype(a) b;

    typedef check<int> check_type;
    check_type c;
    check_type&& cr = static_cast<check_type&&>(c);

    auto d = a;
])

AC_DEFUN([AX_CXX_COMPILE_STDCXX_11], [dnl
  m4_if([$1], [], [],
        [$1], [ext], [],
        [$1], [noext], [],
        [m4_fatal([invalid argument `$1' to AX_CXX_COMPILE_STDCXX_11])])dnl
  m4_if([$2], [], [ax_cxx_compile_cxx11_required=true],
        [$2], [mandatory], [ax_cxx_compile_cxx11_required=true],
        [$2], [optional], [ax_cxx_compile_cxx11_required=false],
        [m4_fatal([invalid second argument `$2' to AX_CXX_COMPILE_STDCXX_11])])dnl
  AC_LANG_PUSH([C++])dnl
  ac_success=no
  AC_CACHE_CHECK(whether $CXX supports C++11 features by default,
  ax_cv_cxx_compile_cxx11,
  [AC_COMPILE_IFELSE([AC_LANG_SOURCE([_AX_CXX_COMPILE_STDCXX_11_testbody])],
    [ax_cv_cxx_compile_cxx11=yes],
    [ax_cv_cxx_compile_cxx11=no])])
  if test x$ax_cv_cxx_compile_cxx11 = xyes; then
    ac_success=yes
  fi

  m4_if([$1], [noext], [], [dnl
  if test x$ac_success = xno; then
    for switch in -std=gnu++11 -std=gnu++0x; do
      cachevar=AS_TR_SH([ax_cv_cxx_compile_cxx11_$switch])
      AC_CACHE_CHECK(whether $CXX supports C++11 features with $switch,
                     $cachevar,
        [ac_save_CXXFLAGS="$CXXFLAGS"
         CXXFLAGS="$CXXFLAGS $switch"
         AC_COMPILE_IFELSE([AC_LANG_SOURCE([_AX_CXX_COMPILE_STDCXX_11_testbody])],
          [eval $cachevar=yes],
          [eval $cachevar=no])
         CXXFLAGS="$ac_save_CXXFLAGS"])
      if eval test x\$$cachevar = xyes; then
        CXXFLAGS="$CXXFLAGS $switch"
        ac_success=yes
        break
      fi
    done
  fi])

  m4_if([$1], [ext], [], [dnl
  if test x$ac_success = xno; then
    for switch in -std=c++11 -std=c++0x; do
      cachevar=AS_TR_SH([ax_cv_cxx_compile_cxx11_$switch])
      AC_CACHE_CHECK(whether $CXX supports C++11 features with $switch,
                     $cachevar,
        [ac_save_CXXFLAGS="$CXXFLAGS"
         CXXFLAGS="$CXXFLAGS $switch"
         AC_COMPILE_IFELSE([AC_LANG_SOURCE([_AX_CXX_COMPILE_STDCXX_11_testbody])],
          [eval $cachevar=yes],
          [eval $cachevar=no])
         CXXFLAGS="$ac_save_CXXFLAGS"])
      if eval test x\$$cachevar = xyes; then
        CXXFLAGS="$CXXFLAGS $switch"
        ac_success=yes
        break
      fi
    done
  fi])
  AC_LANG_POP([C++])
  if test x$ax_cxx_compile_cxx11_required = xtrue; then
    if test x$ac_success = xno; then
      AC_MSG_ERROR([*** A compiler with support for C++11 language features is required.])
    fi
  else
    if test x$ac_success = xno; then
      HAVE_CXX11=0
      AC_MSG_NOTICE([No compiler with C++11 support was found])
    else
      HAVE_CXX11=1
      AC_DEFINE(HAVE_CXX11,1,
                [define if the compiler supports basic C++11 syntax])
    fi

    AC_SUBST(HAVE_CXX11)

    CXXFLAGS=" $CXXFLAGS -Wno-deprecated -Winit-self -fno-omit-frame-pointer -fno-strict-overflow -msse4.2 -msse3 -Wno-unused-but-set-variable"
    if test "`$CXX -v 2>&1 | grep -c 'clang version'`" != "0"
    then
      AM_CONDITIONAL([HAVE_CLANG], [test 1 -eq 1])
      CXXFLAGS=" $CXXFLAGS -Wno-empty-body -Wno-unknown-warning-option"
      AC_DEFINE([__GCC_HAVE_SYNC_COMPARE_AND_SWAP_1], , [Solve Thread issue clang++])
      AC_DEFINE([__GCC_HAVE_SYNC_COMPARE_AND_SWAP_2], , [Solve Thread issue clang++])
      AC_DEFINE([__GCC_HAVE_SYNC_COMPARE_AND_SWAP_4], , [Solve Thread issue clang++])
      AC_DEFINE([__GCC_HAVE_SYNC_COMPARE_AND_SWAP_8], , [Solve Thread issue clang++])
    else
      AM_CONDITIONAL([HAVE_CLANG], [test 1 -eq 0])
      CXXFLAGS=" $CXXFLAGS -fno-deduce-init-list"
    fi
  fi
])
