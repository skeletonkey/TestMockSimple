# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Test-Mock-Simple.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;
use lib 't/';

use Test::More tests => 6;

BEGIN {
  $ENV{TEST_MOCK_SIMPLE_DISABLE} = 1;
  use_ok('Test::Mock::Simple');
  use_ok('Mock::TestModule');
}

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $test = TestModule->new();

is($test->one, 1, 'Got Real One');
is($test->two, 2, 'Got Real Two');
is($test->three, 3, 'Got Real Three');
is($test->rooster, 'cock-a-doodle-doo', 'Got Real Rooster');
