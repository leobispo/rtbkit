ACLOCAL_AMFLAGS = -I m4

AM_CPPFLAGS = \
  -I $(abs_top_builddir) -I $(abs_top_builddir)/.. -I $(abs_top_builddir)/leveldb/include $(CITY_FLAGS) $(BOOST_CPPFLAGS)

post_auction_include_HEADERS = \
  post_auction_loop.h

post_auction_includedir = $(includedir)/rtbkit/core/post_auction

lib_LTLIBRARIES = libpost_auction.la

libpost_auction_la_LDFLAGS = -avoid-version

libpost_auction_la_LIBADD = \
  $(abs_top_builddir)/leveldb/libleveldb.la \
  $(abs_top_builddir)/soa/service/libservices.la \
  $(abs_top_builddir)/core/agent_configuration/libagent_configuration.la

libpost_auction_la_SOURCES = \
  post_auction_loop.cc

bin_PROGRAMS = post_auction_runner

post_auction_runner_SOURCES = post_auction_runner.cc
post_auction_runner_LDADD = \
  $(ZMQ_LIB) \
  $(BOOST_THREAD_LIB) \
  $(BOOST_SYSTEM_LIB) \
  $(BOOST_PROGRAM_OPTIONS_LIB) \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/soa/types/libtypes.la \
  $(abs_top_builddir)/soa/types/libvalue_description.la \
  $(abs_top_builddir)/soa/jsoncpp/libjsoncpp.la \
  $(abs_top_builddir)/soa/service/libservices.la \
  $(abs_top_builddir)/core/monitor/libmonitor.la \
  $(abs_top_builddir)/common/libbid_request.la \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/soa/gc/libgc.la \
  $(abs_top_builddir)/core/banker/libbanker.la \
  libpost_auction.la
