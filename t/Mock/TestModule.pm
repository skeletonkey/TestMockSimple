package Mock::TestModule;

use strict;
use warnings;

use Test::Mock::Simple;

my $mock = Test::Mock::Simple->new(module => 'TestModule');
$mock->add(one     => sub { return 'eins';                   });
$mock->add(rooster => sub { return 'kikeriki';               });
$mock->add(add     => sub { return 'No namespace conflicts'; });

1;
