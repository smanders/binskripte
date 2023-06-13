#!/bin/bash
lcov --directory . --zerocounters
lcov --capture --initial --directory . --output-file coverage-base.info
ctest -R codec
lcov --directory . --capture --output-file coverage-test.info
lcov -a ./coverage-base.info -a ./coverage-test.info -o ./coverage.info
lcov --remove coverage.info '*/palam/utils/*' 'test/*' 'tool/*' '/opt/extern/*' '/home/smanders/extern/*' '/usr/*' --output-file coverage-cleaned.info
genhtml -o report coverage-cleaned.info
rm -f coverage*.info
tar -cJf coverage.tar.xz report/
