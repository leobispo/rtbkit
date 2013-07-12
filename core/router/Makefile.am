ACLOCAL_AMFLAGS = -I m4

AM_CPPFLAGS = \
  -I $(abs_top_builddir) -I $(abs_top_builddir)/.. -I $(abs_top_builddir)/leveldb/include $(BOOST_CPPFLAGS)

rtb_router_include_HEADERS = \
  augmentation_loop.h \
  profiler.h \
  router.h \
  router_rest_api.h \
  router_runner.h \
  router_stack.h \
  router_types.h

rtb_router_includedir = $(includedir)/rtbkit/core/router

lib_LTLIBRARIES = librtb_router.la librouter_runner.la

librtb_router_la_LDFLAGS = -avoid-version
librtb_router_la_LIBADD = \
  $(abs_top_builddir)/leveldb/libleveldb.la \
  $(abs_top_builddir)/soa/service/libservices.la \
  $(abs_top_builddir)/core/monitor/libmonitor.la \
  $(abs_top_builddir)/core/monitor/libmonitor_service.la \
  $(abs_top_builddir)/core/banker/libbanker.la \
  $(abs_top_builddir)/core/post_auction/libpost_auction.la \
  $(abs_top_builddir)/soa/gc/libgc.la \
  $(abs_top_builddir)/core/agent_configuration/libagent_configuration.la

librtb_router_la_SOURCES = \
  augmentation_loop.cc \
  router.cc \
  router_types.cc \
  router_stack.cc

librouter_runner_la_LDFLAGS = -avoid-version
librouter_runner_la_SOURCES = router_runner.cc
librouter_runner_la_LIBADD = \
  $(BOOST_THREAD_LIB) \
  $(BOOST_SYSTEM_LIB) \
  $(BOOST_PROGRAM_OPTIONS_LIB) \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/soa/jsoncpp/libjsoncpp.la \
  $(abs_top_builddir)/soa/service/libservices.la \
  $(abs_top_builddir)/core/banker/libbanker.la \
  $(abs_top_builddir)/common/libbid_request.la \
  $(abs_top_builddir)/soa/types/libvalue_description.la \
  librtb_router.la
