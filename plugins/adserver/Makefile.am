ACLOCAL_AMFLAGS = -I m4

AM_CPPFLAGS = \
  -I $(abs_top_builddir) -I $(abs_top_builddir)/.. $(BOOST_CPPFLAGS)

adserver_include_HEADERS = \
  adserver_connector.h \
  http_adserver_connector.h \
  standard_adserver_connector.h

adserver_includedir = $(includedir)/rtbkit/plugins/adserver

lib_LTLIBRARIES = libadserver_connector.la libstandard_adserver_connector.la

libadserver_connector_la_LDFLAGS = -avoid-version
libadserver_connector_la_LIBADD = \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/common/librtb.la

libadserver_connector_la_SOURCES = \
  adserver_connector.cc \
  http_adserver_connector.cc

libstandard_adserver_connector_la_LDFLAGS = -avoid-version
libstandard_adserver_connector_la_LIBADD = \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/common/librtb.la

libstandard_adserver_connector_la_SOURCES = \
  standard_adserver_connector.cc

bin_PROGRAMS = standard_adserver_connector_runner

standard_adserver_connector_runner_SOURCES = standard_adserver_connector_runner.cc
standard_adserver_connector_runner_LDADD = \
  $(ZMQ_LIB) \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/common/librtb.la \
  $(BOOST_SYSTEM_LIB) \
  $(BOOST_PROGRAM_OPTIONS_LIB) \
  $(abs_top_builddir)/soa/service/libservices.la \
  $(abs_top_builddir)/soa/types/libvalue_description.la \
  $(abs_top_builddir)/common/libbid_request.la \
  libstandard_adserver_connector.la \
  libadserver_connector.la 
