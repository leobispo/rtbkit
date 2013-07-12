ACLOCAL_AMFLAGS = -I m4

AM_CPPFLAGS = \
  -I $(abs_top_builddir) -I $(abs_top_builddir)/.. $(BOOST_CPPFLAGS)

data_logger_include_HEADERS = \
  data_logger.h

data_logger_includedir = $(includedir)/rtbkit/plugins/data_logger

lib_LTLIBRARIES = libdata_logger.la

libdata_logger_la_LDFLAGS = -avoid-version
libdata_logger_la_LIBADD = \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/common/librtb.la

libdata_logger_la_SOURCES = \
  data_logger.cc
