ACLOCAL_AMFLAGS = -I m4

AM_CPPFLAGS = \
  -I $(abs_top_builddir) -I $(abs_top_builddir)/../ $(BOOST_CPPFLAGS)

augmentor_base_include_HEADERS = \
  augmentor_base.h

augmentor_base_includedir = $(includedir)/rtbkit/plugins/bid_request

lib_LTLIBRARIES = libaugmentor_base.la

libaugmentor_base_la_LDFLAGS = -avoid-version
libaugmentor_base_la_LIBADD = \
  $(ZMQ_LIB) \
  $(abs_top_builddir)/common/librtb.la

libaugmentor_base_la_SOURCES = \
  augmentor_base.cc

TEST_LIB = \
  $(ZMQ_LIB) \
  $(BOOST_SYSTEM_LIB) \
  $(BOOST_UNIT_TEST_FRAMEWORK_LIB) \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/soa/jsoncpp/libjsoncpp.la \
  $(abs_top_builddir)/soa/service/libservices.la \
  $(abs_top_builddir)/soa/types/libtypes.la \
  $(abs_top_builddir)/soa/types/libvalue_description.la \
  $(abs_top_builddir)/jml/db/libdb.la \
  $(abs_top_builddir)/common/.libs/libbid_request.la \
  libaugmentor_base.la

TESTS_ENVIRONMENT = $(abs_top_builddir)/test_driver.sh

CC_TESTS = \
  augmentor_testing

TESTS = $(CC_TESTS)

check_PROGRAMS = $(CC_TESTS)

augmentor_testing_SOURCES = testing/augmentor_stress_test.cc
augmentor_testing_CXXFLAGS = 
augmentor_testing_LDADD = $(TEST_LIB)

