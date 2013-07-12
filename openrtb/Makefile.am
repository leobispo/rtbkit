ACLOCAL_AMFLAGS = -I m4

AM_CPPFLAGS = \
  -I $(abs_top_builddir) $(CITY_FLAGS) $(BOOST_CPPFLAGS)

openrtb_include_HEADERS = \
  openrtb.h \
  openrtb_parsing.h

openrtb_includedir = $(includedir)/openrtb

lib_LTLIBRARIES = libopenrtb.la

libopenrtb_la_LDFLAGS = -avoid-version
libopenrtb_la_LIBADD = \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/soa/jsoncpp/libjsoncpp.la \
  $(abs_top_builddir)/soa/types/libvalue_description.la \
  $(abs_top_builddir)/soa/types/libtypes.la
libopenrtb_la_SOURCES = \
  openrtb_parsing.cc \
  openrtb.cc
