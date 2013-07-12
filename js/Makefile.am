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


noinst_LTLIBRARIES = config_validator.la bid_request.la rtb.la

config_validator_la_LIBADD = \
  $(NODE_LIB) \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/soa/jsoncpp/libjsoncpp.la \
  $(abs_top_builddir)/soa/service/libservices.la \
  $(abs_top_builddir)/core/banker/libbanker.la \
  $(abs_top_builddir)/common/libbid_request.la \
  $(abs_top_builddir)/soa/types/libvalue_description.la \
  $(abs_top_builddir)/soa/js/libjs.la \
  $(abs_top_builddir)/core/router/librtb_router.la \
  $(abs_top_builddir)/core/agent_configuration/libagent_configuration.la

config_validator_la_LDFLAGS = $(PLUGIN_LIBTOOL_FLAGS)
config_validator_la_CXXFLAGS = $(NODE_FLAGS)
config_validator_la_SOURCES = \
  config_validator_js.cc

bid_request_la_LIBADD = \
  $(NODE_LIB) \
  $(abs_top_builddir)/soa/js/libjs.la \
  $(abs_top_builddir)/common/libbid_request.la


bid_request_la_LDFLAGS = $(PLUGIN_LIBTOOL_FLAGS)
bid_request_la_CXXFLAGS = $(NODE_FLAGS)
bid_request_la_SOURCES = \
  bid_request_js.cc \
  currency_js.cc

rtb_la_LIBADD = \
  $(NODE_LIB) \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/soa/jsoncpp/libjsoncpp.la \
  $(abs_top_builddir)/soa/service/libservices.la \
  $(abs_top_builddir)/core/banker/libbanker.la \
  $(abs_top_builddir)/common/libbid_request.la \
  $(abs_top_builddir)/soa/types/libvalue_description.la \
  $(abs_top_builddir)/soa/js/libjs.la \
  $(abs_top_builddir)/core/router/librtb_router.la \
  $(abs_top_builddir)/common/libbid_request.la

rtb_la_LDFLAGS = $(PLUGIN_LIBTOOL_FLAGS)
rtb_la_CXXFLAGS = $(NODE_FLAGS)
rtb_la_SOURCES = \
  rtb_js.cc \
  rtb_router_js.cc \
  auction_js.cc \
  bidding_agent_js.cc \
  banker_js.cc \
  bids_js.cc \
  win_cost_model_js.cc

