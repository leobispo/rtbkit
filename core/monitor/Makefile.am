ACLOCAL_AMFLAGS = -I m4

AM_CPPFLAGS = \
  -I $(abs_top_builddir) -I $(abs_top_builddir)/.. $(BOOST_CPPFLAGS)

monitor_include_HEADERS = \
  monitor_client.h \
  monitor_endpoint.h \
  monitor_indicator.h \
  monitor_provider.h

monitor_includedir = $(includedir)/rtbkit/core/monitor

lib_LTLIBRARIES = libmonitor.la libmonitor_service.la

libmonitor_la_LDFLAGS = -avoid-version
libmonitor_la_LIBADD = \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/soa/service/libservices.la
libmonitor_la_SOURCES = \
  monitor_client.cc \
  monitor_provider.cc

libmonitor_service_la_LDFLAGS = -avoid-version
libmonitor_service_la_LIBADD = \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/soa/service/libservices.la
libmonitor_service_la_SOURCES = \
  monitor_endpoint.cc

bin_PROGRAMS = monitor_service_runner

monitor_service_runner_SOURCES = monitor_service_runner.cc
monitor_service_runner_LDADD = \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/soa/service/libservices.la \
  libmonitor_service.la \
  $(BOOST_SYSTEM_LIB) \
  $(BOOST_PROGRAM_OPTIONS_LIB)

CC_TESTS = \
  monitor_endpoint_test \
  monitor_client_test \
  monitor_behaviour_test

TESTS = $(CC_TESTS)

TESTS_ENVIRONMENT = $(abs_top_builddir)/test_driver.sh

check_PROGRAMS = $(CC_TESTS)

TEST_LIB = \
  $(BOOST_THREAD_LIB) \
  $(BOOST_SYSTEM_LIB) \
  $(BOOST_UNIT_TEST_FRAMEWORK_LIB) \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/soa/service/libservices.la \
  $(abs_top_builddir)/soa/types/libtypes.la \
  $(abs_top_builddir)/soa/jsoncpp/libjsoncpp.la \
  libmonitor_service.la \
  libmonitor.la

monitor_endpoint_test_SOURCES = testing/monitor_endpoint_test.cc
monitor_endpoint_test_LDADD = $(TEST_LIB)

monitor_client_test_SOURCES = testing/monitor_client_test.cc
monitor_client_test_LDADD = $(TEST_LIB)

monitor_behaviour_test_LDADD = $(TEST_LIB)
monitor_behaviour_test_SOURCES = testing/monitor_behaviour_test.cc
