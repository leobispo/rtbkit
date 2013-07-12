ACLOCAL_AMFLAGS = -I m4

AM_CPPFLAGS = \
  -I $(abs_top_builddir) -I $(abs_top_builddir)/.. -I $(abs_top_builddir)/leveldb/include $(BOOST_CPPFLAGS)

PLUGIN_LIBTOOL_FLAGS = \
    -shrext .node \
    -module \
    -shared \
    -avoid-version \
    -rpath $(abs_builddir) \
    -fPIC \
    -Wall \
    -m64 \
    -fdata-sections \
    -ffunction-sections \
    -fno-strict-aliasing \
    -fno-rtti \
    -fno-exceptions

noinst_LTLIBRARIES = libintegration_test_utils.la

libintegration_test_utils_la_SOURCES = \
  generic_exchange_connector.cc \
  mock_exchange.cc

libintegration_test_utils_la_LIBADD = \
  $(abs_top_builddir)/common/libbid_test_utils.la \
  $(abs_top_builddir)/soa/types/libtypes.la \
  $(abs_top_builddir)/soa/jsoncpp/libjsoncpp.la \
  $(abs_top_builddir)/plugins/exchange/libexchange.la \
  $(abs_top_builddir)/jml/utils/libutils.la

noinst_PROGRAMS = mock_exchange_runner json_feeder json_listener

PROGRAMS_LIB = \
  $(BOOST_SYSTEM_LIB) \
  $(BOOST_PROGRAM_OPTIONS_LIB) \
  $(abs_top_builddir)/common/libbid_request.la \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/openrtb/libopenrtb.la \
  $(abs_top_builddir)/soa/types/libvalue_description.la \
  libintegration_test_utils.la

mock_exchange_runner_SOURCES = mock_exchange_runner.cc
mock_exchange_runner_LDADD = $(PROGRAMS_LIB)

json_feeder_SOURCES = json_feeder.cc
json_feeder_LDADD = $(PROGRAMS_LIB)

json_listener_SOURCES = json_listener.cc
json_listener_LDADD = $(PROGRAMS_LIB)

TESTS_ENVIRONMENT = $(abs_top_builddir)/test_driver.sh NODE=$(NODEJS) VOWS=$(VOWS) NODE_LIBS="$(noinst_LTLIBRARIES)"

CC_TESTS = \
  agent_configuration_test \
  augmentation_list_test \
  historical_bid_request_test \
  static_filtering_test \
  win_cost_model_test

TESTS = $(CC_TESTS) $(abs_top_builddir)/runjstest.sh

check_PROGRAMS = $(CC_TESTS)

agent_configuration_test_SOURCES = agent_configuration_test.cc
agent_configuration_test_LDADD = \
  $(ZMQ_LIB) \
  $(BOOST_PROGRAM_OPTIONS_LIB) \
  $(BOOST_SYSTEM_LIB) \
  $(BOOST_THREAD_LIB) \
  $(BOOST_UNIT_TEST_FRAMEWORK_LIB) \
  $(abs_top_builddir)/common/libbid_test_utils.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/soa/service/libzeromq.la \
  $(abs_top_builddir)/core/agent_configuration/libagent_configuration.la \
  $(abs_top_builddir)/soa/gc/libgc.la \
  $(abs_top_builddir)/plugins/bidding_agent/libbidding_agent.la \
  $(abs_top_builddir)/soa/service/libservices.la \
  $(abs_top_builddir)/soa/types/libtypes.la \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/soa/jsoncpp/libjsoncpp.la \
  $(abs_top_builddir)/common/.libs/libbid_request.la \
  $(abs_top_builddir)/soa/types/libvalue_description.la \
  $(abs_top_builddir)/core/monitor/libmonitor.la

augmentation_list_test_SOURCES = augmentation_list_test.cc
augmentation_list_test_LDADD = \
  $(BOOST_UNIT_TEST_FRAMEWORK_LIB) \
  $(BOOST_SYSTEM_LIB) \
  $(BOOST_THREAD_LIB) \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/soa/jsoncpp/libjsoncpp.la
 

historical_bid_request_test_SOURCES = historical_bid_request_test.cc
historical_bid_request_test_LDADD = \
  $(BOOST_UNIT_TEST_FRAMEWORK_LIB) \
  $(BOOST_SYSTEM_LIB) \
  $(BOOST_THREAD_LIB) \
  $(abs_top_builddir)/common/libbid_test_utils.la \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/soa/jsoncpp/libjsoncpp.la \
  $(abs_top_builddir)/soa/types/libvalue_description.la \
  $(abs_top_builddir)/soa/types/libtypes.la \
  $(abs_top_builddir)/common/libbid_request.la \
  $(abs_top_builddir)/openrtb/libopenrtb.la

static_filtering_test_SOURCES = static_filtering_test.cc
static_filtering_test_LDADD = \
  $(BOOST_UNIT_TEST_FRAMEWORK_LIB) \
  $(BOOST_SYSTEM_LIB) \
  $(BOOST_THREAD_LIB) \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/soa/jsoncpp/libjsoncpp.la \
  $(abs_top_builddir)/core/agent_configuration/libagent_configuration.la \
  $(abs_top_builddir)/soa/types/libtypes.la \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/soa/types/libvalue_description.la \
  $(abs_top_builddir)/openrtb/libopenrtb.la \
  $(abs_top_builddir)/common/libbid_request.la \
  $(abs_top_builddir)/core/router/librtb_router.la \
  libintegration_test_utils.la

win_cost_model_test_SOURCES = win_cost_model_test.cc 
win_cost_model_test_LDADD = \
  $(ZMQ_LIB) \
  $(BOOST_UNIT_TEST_FRAMEWORK_LIB) \
  $(BOOST_SYSTEM_LIB) \
  $(BOOST_THREAD_LIB) \
  $(abs_top_builddir)/soa/jsoncpp/libjsoncpp.la \
  $(abs_top_builddir)/soa/service/libservices.la \
  $(abs_top_builddir)/soa/types/libvalue_description.la \
  $(abs_top_builddir)/core/agent_configuration/libagent_configuration.la \
  $(abs_top_builddir)/core/monitor/libmonitor.la \
  $(abs_top_builddir)/plugins/exchange/libopenrtb_exchange.la \
  $(abs_top_builddir)/common/libbid_test_utils.la \
  $(abs_top_builddir)/plugins/exchange/libexchange.la \
  $(abs_top_builddir)/plugins/bid_request/libopenrtb_bid_request.la \
  $(abs_top_builddir)/core/router/librtb_router.la \
  $(abs_top_builddir)/core/banker/libbanker.la \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/soa/types/libtypes.la \
  $(abs_top_builddir)/common/libbid_request.la \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/openrtb/libopenrtb.la \
  $(abs_top_builddir)/plugins/bidding_agent/libbidding_agent.la
