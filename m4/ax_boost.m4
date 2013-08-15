AC_DEFUN_ONCE([AX_BOOST],
[
  AX_BOOST_BASE($1, $2)

  AX_BOOST_SYSTEM
  AX_BOOST_THREAD
  AX_BOOST_IOSTREAMS
  AX_BOOST_REGEX
  AX_BOOST_PROGRAM_OPTIONS
  AX_BOOST_UNIT_TEST_FRAMEWORK
  AX_BOOST_DATE_TIME
  AX_BOOST_FILESYSTEM
])

AC_DEFUN([AX_BOOST_BASE],
[
  ac_boost_path="$2"

  boost_lib_version_req=ifelse([$1], ,1.20.0,$1)
  boost_lib_version_req_shorten=`expr $boost_lib_version_req : '\([[0-9]]*\.[[0-9]]*\)'`
  boost_lib_version_req_major=`expr $boost_lib_version_req : '\([[0-9]]*\)'`
  boost_lib_version_req_minor=`expr $boost_lib_version_req : '[[0-9]]*\.\([[0-9]]*\)'`
  boost_lib_version_req_sub_minor=`expr $boost_lib_version_req : '[[0-9]]*\.[[0-9]]*\.\([[0-9]]*\)'`
  if test "$boost_lib_version_req_sub_minor" = ""
  then
    boost_lib_version_req_sub_minor="0"
  fi
  WANT_BOOST_VERSION=`expr $boost_lib_version_req_major \* 100000 \+  $boost_lib_version_req_minor \* 100 \+ $boost_lib_version_req_sub_minor`
  AC_MSG_CHECKING(for boostlib >= $boost_lib_version_req)
  succeeded=no

  libsubdirs="lib"
  ax_arch=`uname -m`
  if test $ax_arch = x86_64 -o $ax_arch = ppc64 -o $ax_arch = s390x -o $ax_arch = sparc64
  then
    libsubdirs="lib64 lib lib64"
  fi

  if test "$ac_boost_path" != ""
  then
    BOOST_CPPFLAGS="-I$ac_boost_path/include"
    for ac_boost_path_tmp in $libsubdirs
    do
      if test -d "$ac_boost_path"/"$ac_boost_path_tmp"
      then
        BOOST_LDFLAGS="-L$ac_boost_path/$ac_boost_path_tmp"
        break
      fi
    done
  fi

  CPPFLAGS_SAVED="$CPPFLAGS"
  CPPFLAGS="$CPPFLAGS $BOOST_CPPFLAGS"
  export CPPFLAGS

  LDFLAGS_SAVED="$LDFLAGS"
  LDFLAGS="$LDFLAGS $BOOST_LDFLAGS"
  export LDFLAGS

  AC_REQUIRE([AC_PROG_CXX])
  AC_LANG_PUSH(C++)
    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
      @%:@include <boost/version.hpp>
    ]], [[
      #if BOOST_VERSION >= $WANT_BOOST_VERSION
      // Everything is okay
      #else
      #  error Boost version is too old
      #endif
    ]])],[AC_MSG_RESULT(yes)
      succeeded=yes
      found_system=yes
    ],[
    ])
  AC_LANG_POP([C++])

  if test "$succeeded" != "yes"
  then
    AC_MSG_ERROR([[Boost library not found on the system or too old.]])
  else
    AC_SUBST(BOOST_CPPFLAGS)
    AC_SUBST(BOOST_LDFLAGS)
    AC_DEFINE(HAVE_BOOST,,[define if the Boost library is available])
  fi

  CPPFLAGS="$CPPFLAGS_SAVED"
  LDFLAGS="$LDFLAGS_SAVED"
])

AC_DEFUN([AX_BOOST_THREAD],
[
  AC_REQUIRE([AC_PROG_CC])
  AC_REQUIRE([AC_CANONICAL_BUILD])
  CPPFLAGS_SAVED="$CPPFLAGS"
  CPPFLAGS="$CPPFLAGS $BOOST_CPPFLAGS"
  export CPPFLAGS

  LDFLAGS_SAVED="$LDFLAGS"
  LDFLAGS="$LDFLAGS $BOOST_LDFLAGS"
  export LDFLAGS

  AC_CACHE_CHECK(whether the Boost::Thread library is available, ax_cv_boost_thread,
  [
    AC_LANG_PUSH([C++])
    CXXFLAGS_SAVE=$CXXFLAGS

    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
      @%:@include <boost/thread/thread.hpp>
    ]], [[boost::thread_group thrds; return 0;]])],
      ax_cv_boost_thread=yes, ax_cv_boost_thread=no
    )
    CXXFLAGS=$CXXFLAGS_SAVE
    AC_LANG_POP([C++])
  ])

  link_thread=no
  if test "$ax_cv_boost_thread" = "yes"; then
    AC_SUBST(BOOST_CPPFLAGS)

    AC_DEFINE(HAVE_BOOST_THREAD, , [define if the Boost::Thread library is available])
    BOOSTLIBDIR=`echo $BOOST_LDFLAGS | sed -e 's/@<:@^\/@:>@*//'`

    AC_CHECK_LIB(boost_thread, exit,
      [BOOST_THREAD_LIB="$BOOST_LDFLAGS -lboost_thread"; AC_SUBST(BOOST_THREAD_LIB) link_thread="yes"; break],
      [link_thread="no"]
    )
  fi

  if test "$link_thread" = "no"
  then
    AC_MSG_ERROR(Boost::Thread library not found)
  fi

  CPPFLAGS="$CPPFLAGS_SAVED -DBOOST_THREAD_VERSION=2"
  LDFLAGS="$LDFLAGS_SAVED"
])

AC_DEFUN([AX_BOOST_SYSTEM],
[
  AC_REQUIRE([AC_PROG_CC])
  AC_REQUIRE([AC_CANONICAL_BUILD])
  CPPFLAGS_SAVED="$CPPFLAGS"
  CPPFLAGS="$CPPFLAGS $BOOST_CPPFLAGS"
  export CPPFLAGS

  LDFLAGS_SAVED="$LDFLAGS"
  LDFLAGS="$LDFLAGS $BOOST_LDFLAGS"
  export LDFLAGS

  AC_CACHE_CHECK(whether the Boost::System library is available, ax_cv_boost_system,
  [
    AC_LANG_PUSH([C++])
    CXXFLAGS_SAVE=$CXXFLAGS

    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
      @%:@include <boost/system/error_code.hpp>
    ]], [[boost::system::system_category]])],
      ax_cv_boost_system=yes, ax_cv_boost_system=no
    )
    CXXFLAGS=$CXXFLAGS_SAVE
    AC_LANG_POP([C++])
  ])

  link_system=no
  if test "$ax_cv_boost_system" = "yes"; then
    AC_SUBST(BOOST_CPPFLAGS)

    AC_DEFINE(HAVE_BOOST_SYSTEM, , [define if the Boost::System library is available])
    BOOSTLIBDIR=`echo $BOOST_LDFLAGS | sed -e 's/@<:@^\/@:>@*//'`

    AC_CHECK_LIB(boost_system, exit,
      [BOOST_SYSTEM_LIB="$BOOST_LDFLAGS -lboost_system"; AC_SUBST(BOOST_SYSTEM_LIB) link_system="yes"; break],
      [link_system="no"]
    )
  fi

  if test "$link_system" = "no"
  then
    AC_MSG_ERROR(Boost::System library not found)
  fi

  CPPFLAGS="$CPPFLAGS_SAVED"
  LDFLAGS="$LDFLAGS_SAVED"
])

AC_DEFUN([AX_BOOST_IOSTREAMS],
[
  AC_REQUIRE([AC_PROG_CC])
  AC_REQUIRE([AC_CANONICAL_BUILD])
  CPPFLAGS_SAVED="$CPPFLAGS"
  CPPFLAGS="$CPPFLAGS $BOOST_CPPFLAGS"
  export CPPFLAGS

  LDFLAGS_SAVED="$LDFLAGS"
  LDFLAGS="$LDFLAGS $BOOST_LDFLAGS"
  export LDFLAGS

  AC_CACHE_CHECK(whether the Boost::IOStreams library is available, ax_cv_boost_iostreams,
  [
    AC_LANG_PUSH([C++])
    CXXFLAGS_SAVE=$CXXFLAGS

    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
      @%:@include <boost/iostreams/filtering_stream.hpp>
      @%:@include <boost/range/iterator_range.hpp>
    ]],
    [[
      std::string  input = "Hello World!";
      namespace io = boost::iostreams;
      io::filtering_istream  in(boost::make_iterator_range(input));
      return 0;
    ]])],
      ax_cv_boost_iostreams=yes, ax_cv_boost_iostreams=no
    )

    CXXFLAGS=$CXXFLAGS_SAVE
    AC_LANG_POP([C++])
  ])

  link_iostreams=no
  if test "$ax_cv_boost_iostreams" = "yes"; then
    AC_SUBST(BOOST_CPPFLAGS)

    AC_DEFINE(HAVE_BOOST_IOSTREAMS, , [define if the Boost::IOStreams library is available])
    BOOSTLIBDIR=`echo $BOOST_LDFLAGS | sed -e 's/@<:@^\/@:>@*//'`

    AC_CHECK_LIB(boost_iostreams, exit,
      [BOOST_IOSTREAMS_LIB="$BOOST_LDFLAGS -lboost_iostreams"; AC_SUBST(BOOST_IOSTREAMS_LIB) link_iostreams="yes"; break],
      [link_iostreams="no"]
    )
  fi

  if test "$link_iostreams" = "no"
  then
    AC_MSG_ERROR(Boost::IOStreams library not found)
  fi

  CPPFLAGS="$CPPFLAGS_SAVED"
  LDFLAGS="$LDFLAGS_SAVED"
])

AC_DEFUN([AX_BOOST_REGEX],
[
  AC_REQUIRE([AC_PROG_CC])
  AC_REQUIRE([AC_CANONICAL_BUILD])
  CPPFLAGS_SAVED="$CPPFLAGS"
  CPPFLAGS="$CPPFLAGS $BOOST_CPPFLAGS"
  export CPPFLAGS

  LDFLAGS_SAVED="$LDFLAGS"
  LDFLAGS="$LDFLAGS $BOOST_LDFLAGS"
  export LDFLAGS

  AC_CACHE_CHECK(whether the Boost::Regex library is available, ax_cv_boost_regex,
  [
    AC_LANG_PUSH([C++])
    CXXFLAGS_SAVE=$CXXFLAGS

    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
      @%:@include <boost/regex.hpp>
    ]], [[boost::regex r(); return 0;]])],
      ax_cv_boost_regex=yes, ax_cv_boost_regex=no
    )
    CXXFLAGS=$CXXFLAGS_SAVE
    AC_LANG_POP([C++])
  ])

  link_regex=no
  if test "$ax_cv_boost_regex" = "yes"; then
    AC_SUBST(BOOST_CPPFLAGS)

    AC_DEFINE(HAVE_BOOST_REGEX, , [define if the Boost::Regex library is available])
    BOOSTLIBDIR=`echo $BOOST_LDFLAGS | sed -e 's/@<:@^\/@:>@*//'`

    AC_CHECK_LIB(boost_regex, exit,
      [BOOST_REGEX_LIB="$BOOST_LDFLAGS -lboost_regex"; AC_SUBST(BOOST_REGEX_LIB) link_regex="yes"; break],
      [link_regex="no"]
    )
  fi

  if test "$link_regex" = "no"
  then
    AC_MSG_ERROR(Boost::Regex library not found)
  fi

  CPPFLAGS="$CPPFLAGS_SAVED"
  LDFLAGS="$LDFLAGS_SAVED"
])

AC_DEFUN([AX_BOOST_PROGRAM_OPTIONS],
[
  AC_REQUIRE([AC_PROG_CC])
  AC_REQUIRE([AC_CANONICAL_BUILD])
  CPPFLAGS_SAVED="$CPPFLAGS"
  CPPFLAGS="$CPPFLAGS $BOOST_CPPFLAGS"
  export CPPFLAGS

  LDFLAGS_SAVED="$LDFLAGS"
  LDFLAGS="$LDFLAGS $BOOST_LDFLAGS"
  export LDFLAGS

  AC_CACHE_CHECK(whether the Boost::ProgramOptions library is available, ax_cv_boost_program_options,
  [
    AC_LANG_PUSH([C++])
    CXXFLAGS_SAVE=$CXXFLAGS

    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
      @%:@include <boost/program_options.hpp>
    ]], [[boost::program_options::options_description generic("Generic options"); return 0;]])],
      ax_cv_boost_program_options=yes, ax_cv_boost_program_options=no
    )
    CXXFLAGS=$CXXFLAGS_SAVE
    AC_LANG_POP([C++])
  ])

  link_program_options=no
  if test "$ax_cv_boost_program_options" = "yes"; then
    AC_SUBST(BOOST_CPPFLAGS)

    AC_DEFINE(HAVE_BOOST_PROGRAM_OPTIONS, , [define if the Boost::ProgramOptions library is available])
    BOOSTLIBDIR=`echo $BOOST_LDFLAGS | sed -e 's/@<:@^\/@:>@*//'`

    AC_CHECK_LIB(boost_program_options, exit,
      [BOOST_PROGRAM_OPTIONS_LIB="$BOOST_LDFLAGS -lboost_program_options"; AC_SUBST(BOOST_PROGRAM_OPTIONS_LIB) link_program_options="yes"; break],
      [link_program_options="no"]
    )
  fi

  if test "$link_program_options" = "no"
  then
    AC_MSG_ERROR(Boost::ProgramOptions library not found)
  fi

  CPPFLAGS="$CPPFLAGS_SAVED"
  LDFLAGS="$LDFLAGS_SAVED"
])

AC_DEFUN([AX_BOOST_UNIT_TEST_FRAMEWORK],
[
  AC_REQUIRE([AC_PROG_CC])
  AC_REQUIRE([AC_CANONICAL_BUILD])
  CPPFLAGS_SAVED="$CPPFLAGS"
  CPPFLAGS="$CPPFLAGS $BOOST_CPPFLAGS"
  export CPPFLAGS

  LDFLAGS_SAVED="$LDFLAGS"
  LDFLAGS="$LDFLAGS $BOOST_LDFLAGS"
  export LDFLAGS

  AC_CACHE_CHECK(whether the Boost::UnitTestFramework library is available, ax_cv_boost_unit_test_framework,
  [
    AC_LANG_PUSH([C++])
    CXXFLAGS_SAVE=$CXXFLAGS

    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
      @%:@include <boost/test/unit_test.hpp>
    ]], [[
      using boost::unit_test::test_suite;
      test_suite* test= BOOST_TEST_SUITE("Unit test example1"); return 0;
    ]])],
      ax_cv_boost_unit_test_framework=yes, ax_cv_boost_unit_test_framework=no
    )
    CXXFLAGS=$CXXFLAGS_SAVE
    AC_LANG_POP([C++])
  ])

  link_unit_test_framework=no
  if test "$ax_cv_boost_unit_test_framework" = "yes"; then
    AC_SUBST(BOOST_CPPFLAGS)

    AC_DEFINE(HAVE_BOOST_UNIT_TEST_FRAMEWORK, , [define if the Boost::UnitTestFramework library is available])
    BOOSTLIBDIR=`echo $BOOST_LDFLAGS | sed -e 's/@<:@^\/@:>@*//'`

    AC_CHECK_LIB(boost_unit_test_framework, exit,
      [BOOST_UNIT_TEST_FRAMEWORK_LIB="$BOOST_LDFLAGS -lboost_unit_test_framework"; AC_SUBST(BOOST_UNIT_TEST_FRAMEWORK_LIB) link_unit_test_framework="yes"; break],
      [link_unit_test_framework="no"]
    )
  fi

  if test "$link_unit_test_framework" = "no"
  then
    AC_MSG_ERROR(Boost::UnitTestFramework library not found)
  fi

  CPPFLAGS="$CPPFLAGS_SAVED"
  LDFLAGS="$LDFLAGS_SAVED"
])

AC_DEFUN([AX_BOOST_DATE_TIME],
[
  AC_REQUIRE([AC_PROG_CC])
  AC_REQUIRE([AC_CANONICAL_BUILD])
  CPPFLAGS_SAVED="$CPPFLAGS"
  CPPFLAGS="$CPPFLAGS $BOOST_CPPFLAGS"
  export CPPFLAGS

  LDFLAGS_SAVED="$LDFLAGS"
  LDFLAGS="$LDFLAGS $BOOST_LDFLAGS"
  export LDFLAGS

  AC_CACHE_CHECK(whether the Boost::DateTime library is available, ax_cv_boost_date_time,
  [
    AC_LANG_PUSH([C++])
    CXXFLAGS_SAVE=$CXXFLAGS

    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
      @%:@include <boost/date_time/gregorian/gregorian_types.hpp>
    ]], [[using namespace boost::gregorian; date d(2002,Jan,10); return 0;]])],
      ax_cv_boost_date_time=yes, ax_cv_boost_date_time=no
    )
    CXXFLAGS=$CXXFLAGS_SAVE
    AC_LANG_POP([C++])
  ])

  link_date_time=no
  if test "$ax_cv_boost_date_time" = "yes"; then
    AC_SUBST(BOOST_CPPFLAGS)

    AC_DEFINE(HAVE_BOOST_DATE_TIME, , [define if the Boost::DateTime library is available])
    BOOSTLIBDIR=`echo $BOOST_LDFLAGS | sed -e 's/@<:@^\/@:>@*//'`

    AC_CHECK_LIB(boost_date_time, exit,
      [BOOST_DATE_TIME_LIB="$BOOST_LDFLAGS -lboost_date_time"; AC_SUBST(BOOST_DATE_TIME_LIB) link_date_time="yes"; break],
      [link_date_time="no"]
    )
  fi

  if test "$link_date_time" = "no"
  then
    AC_MSG_ERROR(Boost::DateTime library not found)
  fi

  CPPFLAGS="$CPPFLAGS_SAVED"
  LDFLAGS="$LDFLAGS_SAVED"
])

AC_DEFUN([AX_BOOST_FILESYSTEM],
[
  AC_REQUIRE([AC_PROG_CC])
  AC_REQUIRE([AC_CANONICAL_BUILD])
  CPPFLAGS_SAVED="$CPPFLAGS"
  CPPFLAGS="$CPPFLAGS $BOOST_CPPFLAGS"
  export CPPFLAGS

  LDFLAGS_SAVED="$LDFLAGS"
  LDFLAGS="$LDFLAGS $BOOST_LDFLAGS"
  export LDFLAGS

  AC_CACHE_CHECK(whether the Boost::FileSystem library is available, ax_cv_boost_filesystem,
  [
    AC_LANG_PUSH([C++])
    CXXFLAGS_SAVE=$CXXFLAGS

    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
      @%:@include <boost/filesystem/path.hpp>
    ]], [[
      using namespace boost::filesystem;
      path my_path("foo/bar/data.txt");
      return 0;
    ]])],
      ax_cv_boost_filesystem=yes, ax_cv_boost_filesystem=no
    )
    CXXFLAGS=$CXXFLAGS_SAVE
    AC_LANG_POP([C++])
  ])

  link_filesystem=no
  if test "$ax_cv_boost_filesystem" = "yes"; then
    AC_SUBST(BOOST_CPPFLAGS)

    AC_DEFINE(HAVE_BOOST_FILESYSTEM, , [define if the Boost::FileSystem library is available])
    BOOSTLIBDIR=`echo $BOOST_LDFLAGS | sed -e 's/@<:@^\/@:>@*//'`

    AC_CHECK_LIB(boost_filesystem, exit,
      [BOOST_FILESYSTEM_LIB="$BOOST_LDFLAGS -lboost_filesystem"; AC_SUBST(BOOST_FILESYSTEM_LIB) link_filesystem="yes"; break],
      [link_filesystem="no"]
    )
  fi

  if test "$link_filesystem" = "no"
  then
    AC_MSG_ERROR(Boost::FileSystem library not found)
  fi

  CPPFLAGS="$CPPFLAGS_SAVED"
  LDFLAGS="$LDFLAGS_SAVED"
])


