ACLOCAL_AMFLAGS = -I m4

AM_CPPFLAGS = \
  -I $(abs_top_builddir) -I $(abs_top_builddir)/.. $(BOOST_CPPFLAGS)

agent_configuration_include_HEADERS = \
  agent_config.h \
  agent_configuration_listener.h \
  agent_configuration_service.h \
  blacklist.h \
  include_exclude.h

agent_configuration_includedir = $(includedir)/rtbkit/core/agent_configuration

lib_LTLIBRARIES = libagent_configuration.la

libagent_configuration_la_LDFLAGS = -avoid-version
libagent_configuration_la_LIBADD = \
  $(BOOST_REGEX_LIB) \
  $(abs_top_builddir)/soa/service/libservices.la \
  $(abs_top_builddir)/soa/types/libtypes.la \
  $(abs_top_builddir)/core/monitor/libmonitor.la \
  $(abs_top_builddir)/common/libbid_request.la \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/soa/gc/libgc.la

libagent_configuration_la_SOURCES = \
  agent_config.cc \
  blacklist.cc \
  include_exclude.cc \
  agent_configuration_listener.cc \
  agent_configuration_service.cc

bin_PROGRAMS = agent_configuration_service_runner

agent_configuration_service_runner_SOURCES = agent_configuration_service_runner.cc
agent_configuration_service_runner_LDADD = \
  $(ZMQ_LIB) \
  $(BOOST_REGEX_LIB) \
  $(BOOST_SYSTEM_LIB) \
  $(BOOST_PROGRAM_OPTIONS_LIB) \
  $(abs_top_builddir)/core/monitor/libmonitor.la \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/soa/types/libtypes.la \
  $(abs_top_builddir)/soa/jsoncpp/libjsoncpp.la \
  $(abs_top_builddir)/soa/service/libservices.la \
  libagent_configuration.la
