ACLOCAL_AMFLAGS = -I m4

AM_CPPFLAGS = \
  -I $(abs_top_builddir) -I $(abs_top_builddir)/.. $(BOOST_CPPFLAGS)

banker_include_HEADERS = \
  account.h \
  banker.h \
  master_banker.h \
  null_banker.h \
  slave_banker.h

banker_includedir = $(includedir)/rtbkit/core/banker

banker_migration_include_HEADERS = \
  migration/redis_migration.h \
  migration/redis_old_types.h \
  migration/redis_rollback.h \
  migration/redis_utils.h

banker_migration_includedir = $(includedir)/rtbkit/core/banker/migration

lib_LTLIBRARIES = libbanker.la libredis_migration.la

libbanker_la_LDFLAGS = -avoid-version
libbanker_la_LIBADD = \
  $(REDIS_LIB) \
  $(abs_top_builddir)/common/libbid_request.la \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/soa/jsoncpp/libjsoncpp.la \
  $(abs_top_builddir)/soa/service/libredis.la \
  $(abs_top_builddir)/core/monitor/libmonitor.la

libbanker_la_SOURCES = \
  account.cc \
  banker.cc \
  null_banker.cc \
  slave_banker.cc \
  master_banker.cc

libredis_migration_la_LDFLAGS = -avoid-version
libredis_migration_la_LIBADD = \
  $(abs_top_builddir)/soa/service/libredis.la \
  libbanker.la

libredis_migration_la_SOURCES = \
  migration/redis_migration.cc \
  migration/redis_old_types.cc \
  migration/redis_rollback.cc \
  migration/redis_utils.cc

bin_PROGRAMS = banker_service_runner redis_migrate

banker_service_runner_SOURCES = banker_service_runner.cc
banker_service_runner_LDADD = \
  $(HIREDIS_LIB) \
  $(BOOST_PROGRAM_OPTIONS_LIB) \
  $(BOOST_SYSTEM_LIB) \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/soa/types/libtypes.la \
  $(abs_top_builddir)/soa/service/libredis.la \
  $(abs_top_builddir)/soa/service/libservices.la \
  libbanker.la

redis_migrate_SOURCES = migration/redis_migrate.cc
redis_migrate_LDADD = \
  $(BOOST_PROGRAM_OPTIONS_LIB) \
  $(BOOST_SYSTEM_LIB) \
  $(abs_top_builddir)/soa/service/libredis.la \
  libredis_migration.la

CC_TESTS = \
  master_banker_test \
  slave_banker_test \
  banker_account_test \
  banker_behaviour_test \
  redis_persistence_test

TESTS = $(CC_TESTS)

TESTS_ENVIRONMENT = $(abs_top_builddir)/test_driver.sh

check_PROGRAMS = $(CC_TESTS)

TEST_LIB = \
  $(CITYHASH_LIB) \
  $(BOOST_UNIT_TEST_FRAMEWORK_LIB) \
  $(BOOST_SYSTEM_LIB) \
  $(BOOST_THREAD_LIB) \
  $(abs_top_builddir)/jml/arch/libarch.la \
  $(abs_top_builddir)/jml/utils/libutils.la \
  $(abs_top_builddir)/common/librtb.la \
  $(abs_top_builddir)/soa/service/libredis.la \
  $(abs_top_builddir)/soa/types/libtypes.la \
  $(abs_top_builddir)/common/libbid_request.la \
  $(abs_top_builddir)/soa/jsoncpp/libjsoncpp.la \
  $(abs_top_builddir)/soa/service/libservices.la \
  $(HIREDIS_LIB) \
  libbanker.la

master_banker_test_SOURCES = testing/master_banker_test.cc
master_banker_test_LDADD = $(TEST_LIB)

slave_banker_test_SOURCES = testing/slave_banker_test.cc
slave_banker_test_LDADD = $(TEST_LIB)

banker_account_test_SOURCES = testing/banker_account_test.cc
banker_account_test_LDADD = $(TEST_LIB)

banker_behaviour_test_SOURCES = testing/banker_behaviour_test.cc testing/banker_temporary_server.cc
banker_behaviour_test_LDADD = $(TEST_LIB)

redis_persistence_test_SOURCES = testing/redis_persistence_test.cc
redis_persistence_test_LDADD = $(TEST_LIB)
