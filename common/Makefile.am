ACLOCAL_AMFLAGS = -I m4

AM_CPPFLAGS = \
  -I $(abs_top_builddir)/../ -I $(abs_top_builddir)/ -I $(abs_top_builddir)/leveldb/include $(BOOST_CPPFLAGS)

common_include_HEADERS = \
  account_key.h \
  auction_events.h \
  auction.h \
  augmentation.h \
  bid_request.h \
  bids.h \
  currency.h \
  exchange_connector.h \
  json_holder.h \
  messages.h \
  segments.h \
  tags.h \
  win_cost_model.h

common_includedir = $(includedir)/rtbkit/common

lib_LTLIBRARIES = libbid_request.la librtb.la

libbid_request_la_LDFLAGS = -avoid-version
libbid_request_la_LIBADD = \
  $(abs_top_builddir)/openrtb/libopenrtb.la \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/soa/jsoncpp/libjsoncpp.la

libbid_request_la_SOURCES = \
  bid_request.cc \
  segments.cc \
  json_holder.cc \
  currency.cc

librtb_la_LDFLAGS = -avoid-version
librtb_la_LIBADD = \
  libbid_request.la \
  $(ACE_LIB) \
  $(ZMQ_LIB) \
  $(abs_top_builddir)/openrtb/libopenrtb.la \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/soa/jsoncpp/libjsoncpp.la \
  $(abs_top_builddir)/soa/service/libopstats.la \
  $(abs_top_builddir)/soa/service/libservices.la \
  $(abs_top_builddir)/soa/types/libvalue_description.la \
  $(abs_top_builddir)/soa/types/libtypes.la

librtb_la_SOURCES = \
  auction.cc \
  augmentation.cc \
  account_key.cc \
  bids.cc \
  auction_events.cc \
  exchange_connector.cc \
  win_cost_model.cc

noinst_LTLIBRARIES = libbid_test_utils.la

libbid_test_utils_la_LDFLAGS = -avoid-version
libbid_test_utils_la_SOURCES = testing/exchange_source.cc

CC_TESTS = \
  bid_request_synth_test \
  currency_test

TESTS = $(CC_TESTS)

TESTS_ENVIRONMENT = $(abs_top_builddir)/test_driver.sh

check_PROGRAMS = $(CC_TESTS)

TEST_LIB = \
  $(BOOST_UNIT_TEST_FRAMEWORK_LIB) \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/soa/jsoncpp/libjsoncpp.la \
  librtb.la \
  libbid_request.la

bid_request_synth_test_SOURCES = testing/bid_request_synth_test.cc testing/bid_request_synth.cc
bid_request_synth_test_LDADD = $(TEST_LIB)

currency_test_SOURCES = testing/currency_test.cc
currency_test_LDADD = $(TEST_LIB)
