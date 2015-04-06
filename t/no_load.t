# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Test-Mock-Simple.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;
use lib 't/';

use Test::More tests => 6;

BEGIN {
  use_ok('Test::Mock::Simple');
}

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $mock = Test::Mock::Simple->new( module => 'TestModule', no_load => 1 );
$mock->add(one => sub { return '1 ring to rule them all'; });
$mock->add(new => sub { my $class = shift; my %self = @_; return bless(\%self, $class); });

my $test = TestModule->new();

ok($test->can('one'), 'Module is able to call method one');
is($test->one, '1 ring to rule them all', 'Got Mocked One');

foreach my $method (qw(two three rooster)) {
    ok(!$test->can($method), "Module is NOT able to call method $method");
}
