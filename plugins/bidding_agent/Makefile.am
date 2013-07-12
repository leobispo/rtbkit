ACLOCAL_AMFLAGS = -I m4

AM_CPPFLAGS = \
  -I $(abs_top_builddir) -I $(abs_top_builddir)/../ $(BOOST_CPPFLAGS)

bidding_agent_include_HEADERS = \
  bidding_agent.h

bidding_agent_includedir = $(includedir)/rtbkit/plugins/bidding_agent

lib_LTLIBRARIES = libbidding_agent.la

libbidding_agent_la_LDFLAGS = -avoid-version
libbidding_agent_la_LIBADD = \
  $(ZMQ_LIB) \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/core/router/librtb_router.la \
  $(abs_top_builddir)/openrtb/libopenrtb.la

libbidding_agent_la_SOURCES = \
  bidding_agent.cc
