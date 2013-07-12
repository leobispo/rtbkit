ACLOCAL_AMFLAGS = -I m4

AM_CPPFLAGS = \
  -I $(abs_top_builddir) -I $(abs_top_builddir)/.. -I $(abs_top_builddir)/leveldb/include $(BOOST_CPPFLAGS)

noinst_LTLIBRARIES = libaugmentor_ex.la

libaugmentor_ex_la_SOURCES = \
  augmentor_ex.cc

libaugmentor_ex_la_LIBADD = \
  $(abs_top_builddir)/common/libbid_request.la \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/plugins/augmentor/libaugmentor_base.la \
  $(abs_top_builddir)/core/agent_configuration/libagent_configuration.la

noinst_PROGRAMS = \
  augmentor_ex_runner \
  data_logger_ex \
  bidding_agent_console \
  bidding_agent_ex \
  ad_server_connector_ex \
  router_ex \
  bid_request_endpoint \
  adserver_endpoint \
  integration_endpoints \
  standalone_bidder_ex

PROGRAMS_LIB = \
  $(BOOST_SYSTEM_LIB) \
  $(BOOST_THREAD_LIB) \
  $(BOOST_REGEX_LIB) \
  $(BOOST_PROGRAM_OPTIONS_LIB) \
  $(abs_top_builddir)/plugins/data_logger/libdata_logger.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/soa/service/libservices.la \
  $(abs_top_builddir)/soa/logger/liblogger.la \
  $(abs_top_builddir)/soa/jsoncpp/libjsoncpp.la \
  $(abs_top_builddir)/soa/types/libtypes.la \
  $(abs_top_builddir)/core/monitor/libmonitor.la

augmentor_ex_runner_SOURCES = augmentor_ex_runner.cc
augmentor_ex_runner_LDADD = $(PROGRAMS_LIB) libaugmentor_ex.la 

data_logger_ex_SOURCES = data_logger_ex.cc
data_logger_ex_LDADD = $(PROGRAMS_LIB)

bidding_agent_console_SOURCES = bidding_agent_console.cc
bidding_agent_console_LDADD = \
  $(PROGRAMS_LIB) \
  $(abs_top_builddir)/core/agent_configuration/libagent_configuration.la \
  $(abs_top_builddir)/soa/types/libvalue_description.la \
  $(abs_top_builddir)/common/libbid_request.la \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/plugins/bidding_agent/libbidding_agent.la

bidding_agent_ex_SOURCES = bidding_agent_ex.cc
bidding_agent_ex_LDADD = \
  $(PROGRAMS_LIB) \
  $(abs_top_builddir)/core/agent_configuration/libagent_configuration.la \
  $(abs_top_builddir)/core/router/librtb_router.la \
  $(abs_top_builddir)/core/banker/libbanker.la \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/common/libbid_request.la \
  $(abs_top_builddir)/soa/types/libvalue_description.la \
  $(abs_top_builddir)/plugins/bidding_agent/libbidding_agent.la

ad_server_connector_ex_SOURCES = ad_server_connector_ex.cc
ad_server_connector_ex_LDADD = \
  $(PROGRAMS_LIB) \
  $(ZMQ_LIB) \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/common/libbid_request.la \
  $(abs_top_builddir)/soa/types/libvalue_description.la \
  $(abs_top_builddir)/plugins/adserver/libadserver_connector.la

router_ex_SOURCES = router_ex.cc
router_ex_LDADD = \
  $(PROGRAMS_LIB) \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/soa/types/libvalue_description.la \
  $(abs_top_builddir)/core/router/librtb_router.la \
  $(abs_top_builddir)/core/router/librouter_runner.la \
  $(abs_top_builddir)/openrtb/libopenrtb.la \
  $(abs_top_builddir)/plugins/exchange/libexchange.la \
  $(abs_top_builddir)/plugins/exchange/libopenrtb_exchange.la \
  $(abs_top_builddir)/plugins/exchange/librubicon_exchange.la \
  $(abs_top_builddir)/plugins/bid_request/libopenrtb_bid_request.la \
  $(abs_top_builddir)/common/libbid_test_utils.la \
  $(abs_top_builddir)/common/libbid_request.la

bid_request_endpoint_SOURCES = bid_request_endpoint.cc
bid_request_endpoint_LDADD = \
  $(PROGRAMS_LIB) \
  $(ZMQ_LIB) \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/common/libbid_request.la \
  $(abs_top_builddir)/soa/types/libvalue_description.la \
  $(abs_top_builddir)/openrtb/libopenrtb.la \
  $(abs_top_builddir)/core/agent_configuration/libagent_configuration.la \
  $(abs_top_builddir)/plugins/bidding_agent/libbidding_agent.la \
  $(abs_top_builddir)/plugins/exchange/libopenrtb_exchange.la \
  $(abs_top_builddir)/plugins/exchange/librubicon_exchange.la \
  $(abs_top_builddir)/plugins/bid_request/libopenrtb_bid_request.la \
  $(abs_top_builddir)/core/router/librtb_router.la \
  $(abs_top_builddir)/core/banker/libbanker.la \
  $(abs_top_builddir)/common/libbid_test_utils.la \
  $(abs_top_builddir)/plugins/exchange/libexchange.la

adserver_endpoint_SOURCES = adserver_endpoint.cc
adserver_endpoint_LDADD = \
  $(PROGRAMS_LIB) \
  $(ZMQ_LIB) \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/common/libbid_request.la \
  $(abs_top_builddir)/soa/types/libvalue_description.la \
  $(abs_top_builddir)/plugins/adserver/libstandard_adserver_connector.la \
  $(abs_top_builddir)/plugins/adserver/libadserver_connector.la

integration_endpoints_SOURCES = integration_endpoints.cc
integration_endpoints_LDADD = \
  $(PROGRAMS_LIB) \
  $(ZMQ_LIB) \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/common/libbid_request.la \
  $(abs_top_builddir)/soa/types/libvalue_description.la \
  $(abs_top_builddir)/core/agent_configuration/libagent_configuration.la \
  $(abs_top_builddir)/openrtb/libopenrtb.la \
  $(abs_top_builddir)/plugins/bidding_agent/libbidding_agent.la \
  $(abs_top_builddir)/plugins/adserver/libstandard_adserver_connector.la \
  $(abs_top_builddir)/core/router/librtb_router.la \
  $(abs_top_builddir)/plugins/adserver/libadserver_connector.la \
  $(abs_top_builddir)/core/banker/libbanker.la \
  $(abs_top_builddir)/plugins/exchange/libopenrtb_exchange.la \
  $(abs_top_builddir)/plugins/exchange/librubicon_exchange.la \
  $(abs_top_builddir)/plugins/bid_request/libopenrtb_bid_request.la \
  $(abs_top_builddir)/common/libbid_test_utils.la \
  $(abs_top_builddir)/plugins/exchange/libexchange.la

standalone_bidder_ex_SOURCES = standalone_bidder_ex.cc
standalone_bidder_ex_LDADD = \
  $(PROGRAMS_LIB) \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/common/libbid_request.la \
  $(abs_top_builddir)/soa/types/libvalue_description.la \
  $(abs_top_builddir)/openrtb/libopenrtb.la \
  $(abs_top_builddir)/plugins/exchange/libexchange.la

TESTS_ENVIRONMENT = $(abs_top_builddir)/test_driver.sh

CC_TESTS = rtbkit_integration_test

TESTS = $(CC_TESTS)

check_PROGRAMS = $(CC_TESTS)

rtbkit_integration_test_SOURCES = rtbkit_integration_test.cc
rtbkit_integration_test_LDADD = \
  $(BOOST_SYSTEM_LIB) \
  $(BOOST_THREAD_LIB) \
  $(BOOST_UNIT_TEST_FRAMEWORK_LIB) \
  $(ZMQ_LIB) \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/common/libbid_request.la \
  $(abs_top_builddir)/openrtb/libopenrtb.la \
  $(abs_top_builddir)/soa/jsoncpp/libjsoncpp.la \
  $(abs_top_builddir)/soa/service/libservices.la \
  $(abs_top_builddir)/soa/types/libtypes.la \
  $(abs_top_builddir)/soa/types/libvalue_description.la \
  $(abs_top_builddir)/core/router/librtb_router.la \
  $(abs_top_builddir)/core/banker/libbanker.la \
  $(abs_top_builddir)/core/monitor/libmonitor.la \
  $(abs_top_builddir)/core/monitor/libmonitor_service.la \
  $(abs_top_builddir)/core/post_auction/libpost_auction.la \
  $(abs_top_builddir)/soa/gc/libgc.la \
  $(abs_top_builddir)/core/agent_configuration/libagent_configuration.la \
  $(abs_top_builddir)/soa/service/libredis.la \
  $(abs_top_builddir)/plugins/adserver/libadserver_connector.la \
  $(abs_top_builddir)/plugins/bidding_agent/libbidding_agent.la \
  $(abs_top_builddir)/testing/libintegration_test_utils.la \
  $(abs_top_builddir)/plugins/exchange/libexchange.la \
  libaugmentor_ex.la
