ACLOCAL_AMFLAGS = -I m4

AM_CPPFLAGS = \
  -I $(abs_top_builddir) -I $(abs_top_builddir)/../ $(BOOST_CPPFLAGS)

openrtb_bid_request_include_HEADERS = \
  openrtb_bid_request.h

openrtb_bid_request_includedir = $(includedir)/rtbkit/plugins/bid_request

lib_LTLIBRARIES = libopenrtb_bid_request.la

libopenrtb_bid_request_la_LDFLAGS = -avoid-version
libopenrtb_bid_request_la_LIBADD = \
  $(ZMQ_LIB) \
  $(abs_top_builddir)/common/libbid_request.la \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/core/router/librtb_router.la \
  $(abs_top_builddir)/openrtb/libopenrtb.la

libopenrtb_bid_request_la_SOURCES = \
  openrtb_bid_request.cc

TEST_LIB = \
  $(BOOST_UNIT_TEST_FRAMEWORK_LIB) \
  $(abs_top_builddir)/soa/jsoncpp/libjsoncpp.la \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/common/libbid_request.la \
  $(abs_top_builddir)/openrtb/libopenrtb.la \
  $(abs_top_builddir)/soa/types/libtypes.la \
  $(abs_top_builddir)/soa/types/libvalue_description.la \
  libopenrtb_bid_request.la

TESTS_ENVIRONMENT = $(abs_top_builddir)/test_driver.sh

CC_TESTS = \
  openrtb_bid_request_test

TESTS = $(CC_TESTS)

check_PROGRAMS = $(CC_TESTS)

openrtb_bid_request_test_SOURCES = testing/openrtb_bid_request_test.cc
openrtb_bid_request_test_CXXFLAGS = 
openrtb_bid_request_test_LDADD = $(TEST_LIB)

