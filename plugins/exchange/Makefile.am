ACLOCAL_AMFLAGS = -I m4

AM_CPPFLAGS = \
  -I $(abs_top_builddir) -I $(abs_top_builddir)/../ -I $(abs_top_builddir)/leveldb/include $(BOOST_CPPFLAGS)

exchange_include_HEADERS = \
  http_auction_handler.h \
  http_exchange_connector.h \
  openrtb_exchange_connector.h \
  rubicon_exchange_connector.h \
  gumgum_exchange_connector.h \
  appnexus_exchange_connector.h

exchange_includedir = $(includedir)/rtbkit/plugins/exchange

lib_LTLIBRARIES = libexchange.la librubicon_exchange.la libopenrtb_exchange.la libappnexus_exchange.la \
  libgumgum_exchange.la

libexchange_la_LDFLAGS = -avoid-version
libexchange_la_LIBADD = \
  $(BOOST_THREAD_LIB) \
  $(abs_top_builddir)/soa/service/libzeromq.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/common/librtb.la

libexchange_la_SOURCES = http_exchange_connector.cc http_auction_handler.cc

librubicon_exchange_la_LDFLAGS = -avoid-version
librubicon_exchange_la_LIBADD = \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/openrtb/libopenrtb.la \
  libexchange.la

librubicon_exchange_la_SOURCES = rubicon_exchange_connector.cc

libopenrtb_exchange_la_LDFLAGS = -avoid-version
libopenrtb_exchange_la_LIBADD = \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/openrtb/libopenrtb.la \
  libexchange.la

libopenrtb_exchange_la_SOURCES = openrtb_exchange_connector.cc

libappnexus_exchange_la_LDFLAGS = -avoid-version
libappnexus_exchange_la_LIBADD = \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/openrtb/libopenrtb.la \
  libexchange.la

libappnexus_exchange_la_SOURCES = appnexus_exchange_connector.cc

libgumgum_exchange_la_LDFLAGS = -avoid-version
libgumgum_exchange_la_LIBADD = \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/openrtb/libopenrtb.la \
  libexchange.la

libgumgum_exchange_la_SOURCES = gumgum_exchange_connector.cc


TESTS_ENVIRONMENT = $(abs_top_builddir)/test_driver.sh

TEST_LIB = \
  $(ZMQ_LIB) \
  $(BOOST_THREAD_LIB) \
  $(BOOST_SYSTEM_LIB) \
  $(BOOST_FILESYSTEM_LIB) \
  $(BOOST_UNIT_TEST_FRAMEWORK_LIB) \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/soa/jsoncpp/libjsoncpp.la \
  $(abs_top_builddir)/soa/service/libservices.la \
  $(abs_top_builddir)/soa/types/libvalue_description.la \
  $(abs_top_builddir)/soa/types/libtypes.la \
  $(abs_top_builddir)/common/libbid_request.la \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/common/libbid_test_utils.la \
  $(abs_top_builddir)/openrtb/libopenrtb.la \
  $(abs_top_builddir)/core/monitor/libmonitor.la \
  $(abs_top_builddir)/core/router/librtb_router.la \
  $(abs_top_builddir)/core/banker/libbanker.la \
  $(abs_top_builddir)/plugins/bidding_agent/libbidding_agent.la \
  $(abs_top_builddir)/core/agent_configuration/libagent_configuration.la \
  $(abs_top_builddir)/soa/gc/libgc.la \
  libexchange.la \
  libopenrtb_exchange.la \
  $(abs_top_builddir)/plugins/bid_request/libopenrtb_bid_request.la

CC_TESTS = \
  rubicon_exchange_connector_test \
  gumgum_exchange_connector_test

TESTS = $(CC_TESTS)

check_PROGRAMS = $(CC_TESTS)

rubicon_exchange_connector_test_SOURCES = testing/rubicon_exchange_connector_test.cc
rubicon_exchange_connector_test_CXXFLAGS = $(CAIROMM_CFLAGS)
rubicon_exchange_connector_test_LDADD = \
  $(TEST_LIB) \
  librubicon_exchange.la \
  $(CAIROMM_LIBS)

gumgum_exchange_connector_test_SOURCES = testing/gumgum_exchange_connector_test.cc
gumgum_exchange_connector_test_CXXFLAGS = $(CAIROMM_CFLAGS)
gumgum_exchange_connector_test_LDADD = \
  $(TEST_LIB) \
  libgumgum_exchange.la \
  $(abs_top_builddir)/plugins/bid_request/libopenrtb_bid_request.la \
  $(CAIROMM_LIBS)
