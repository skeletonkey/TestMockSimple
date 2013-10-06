package Mock::TestModule;

use strict;
use warnings;

use Test::Mock::Simple;

my $mock = Test::Mock::Simple->new(module => 'TestModule');
$mock->it(one     => sub { return 'eins';     });
$mock->it(rooster => sub { return 'kikeriki'; });

1;
