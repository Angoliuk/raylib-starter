#define BOOST_TEST_MODULE native
#include <boost/test/included/unit_test.hpp>

int add(int a, int b) {
  return a + b;
}

BOOST_AUTO_TEST_CASE(test_addition) {
  BOOST_CHECK(add(2, 2) == 4);
  BOOST_CHECK(add(-1, 1) == 0);
}

BOOST_AUTO_TEST_CASE(test_failure) {
  BOOST_CHECK(add(2, 3) != 4);
}
