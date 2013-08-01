AC_PREREQ([2.68])
AC_INIT([rtbkit], [1.0.0])

AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])

m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])

AC_C_INLINE
AC_TYPE_INT16_T
AC_TYPE_INT32_T
AC_TYPE_INT64_T
AC_TYPE_INT8_T
AC_TYPE_PID_T
AC_TYPE_SIZE_T
AC_TYPE_UINT16_T
AC_TYPE_UINT32_T
AC_TYPE_UINT64_T
AC_TYPE_UINT8_T
AC_CHECK_TYPES([ptrdiff_t])

AM_INIT_AUTOMAKE([foreign -Werror nostdinc subdir-objects color-tests])

LT_INIT

AC_PROG_F77
AC_PROG_CXX
AC_PROG_AWK

AC_LANG_PUSH([C++])
AC_COMPILE_IFELSE([AC_LANG_PROGRAM([],[])],[],[AC_MSG_ERROR([No C++ compiler found])])
AC_LANG_POP([C++])

AC_LANG([C++], [Fortran 77])

AX_CXX_COMPILE_STDCXX_11([noext])

AC_SEARCH_LIBS([dlopen], [dl])
AC_SEARCH_LIBS([shm_open], [rt])
AC_CHECK_LIB([amd], [main])
AC_CHECK_LIB([pthread], [pthread_create])

AX_TEST
AX_LIB_V8([2.0.5.2], [$HOME/local])
AX_BOOST([1.52], [$HOME/local])
AX_NODEJS([0.6.7.1], [$HOME/local])
AX_LIBCURL([7.27.0], [$HOME/local])
AX_LIBCURLPP([0.7.2], [$HOME/local])
AX_ZMQ([3.2.3], [$HOME/local])
AX_SNAPPY([$HOME/local])
AX_CITYHASH([$HOME/local])
AX_ACE([$HOME/local])
AX_URCU([$HOME/local])
AX_SSH2([$HOME/local])
AX_ZOOKEEPER([$HOME/local])
AX_HIREDIS([$HOME/local])
AX_MONGODB([$HOME/local])

PKG_CHECK_MODULES([LIBSIGC], [sigc++-2.0])
PKG_CHECK_MODULES([CAIROMM], [cairomm-1.0])

AX_CUDA

AX_ICU(4.8)
AX_LZMA
AX_CRYPTO
AX_LAPACK([], [AC_MSG_ERROR([Lapack library is required by algebra])])

AC_CONFIG_FILES([
  Makefile
  googleurl/Makefile
  tinyxml2/Makefile
  leveldb/Makefile
  jml/compiler/Makefile
  jml/math/Makefile
  jml/arch/Makefile
  jml/utils/Makefile
  jml/db/Makefile
  jml/algebra/Makefile
  jml/stats/Makefile
  jml/judy/Makefile
  jml/boosting/Makefile
  jml/neural/Makefile
  soa/jsoncpp/Makefile
  soa/types/Makefile
  soa/js/Makefile
  soa/sync/Makefile
  soa/sigslot/Makefile
  soa/gc/Makefile
  soa/service/Makefile
  soa/logger/Makefile
  soa/launcher/Makefile
  soa/utils/Makefile
  openrtb/Makefile
  core/monitor/Makefile
  core/banker/Makefile
  core/agent_configuration/Makefile
  core/post_auction/Makefile
  core/router/Makefile
  common/Makefile
  plugins/bid_request/Makefile
  plugins/augmentor/Makefile
  plugins/data_logger/Makefile
  plugins/bidding_agent/Makefile
  plugins/exchange/Makefile
  plugins/adserver/Makefile
  js/Makefile
  testing/Makefile
  examples/Makefile
])

blu='@<:@1;34m'
yel='@<:@1;33m'
cya='@<:@1;36m'
std='@<:@m'

am__v_CXX_0="@echo \"\${yel}  [[C++]]  \${std}\" \$@;"
am__v_F77_0="@echo \"\${yel}  [[F77]]  \${std}\" \$@;"
am__v_CXXLD_0="@if [[ \"\`echo \$@ | cut -d. -f1-1\`\" == \"\$@\" ]]; then echo \"\${blu}  [[BIN]]  \${std} \$@\"; else echo \"\${cya}  [[ SO]]  \${std} \$@\"; fi;"

AC_SUBST(blu)
AC_SUBST(yel)
AC_SUBST(cya)
AC_SUBST(std)
AC_SUBST(am__v_CXXLD_0)
AC_SUBST(am__v_CXX_0)
AC_SUBST(am__v_F77_0)

AC_DEFINE([LEVELDB_PLATFORM_POSIX], [1], [Set the levelDB framework to use posix])
AC_DEFINE_UNQUOTED(BASE_DIR, "`pwd`", [Helper to define where to find the correct file paths])
AC_DEFINE(BOOST_NO_CXX11_EXPLICIT_CONVERSION_OPERATORS,, [Hack to allow implicit conversions.])
AC_DEFINE_DIR([BOOST_TIMEZONES_DIR], [sysconfdir], [Set the path here the TIMEZONE csv file will be installed])


AM_CONDITIONAL([HAVE_MAKE_SILENT], [test "`make --help 2>&1 | grep  "\-\-silent"`" != ""])

AC_OUTPUT
