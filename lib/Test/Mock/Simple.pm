package Test::Mock::Simple;

use 5.014002;
use strict;
use warnings;

our $VERSION = '0.01';

sub new {
  my $package = shift;
  my $class = ref($package) || $package;

  my $self = {@_};
  bless($self, $class);

  $self->initialize;

  return $self;
}

sub initialize {
  my $self = shift;

  if (!$self->{module}) {
    requrie Carp;
    Carp::croak("No module name provice to mock");
  }

  my $module = $self->{module} . '.pm';
  $module =~ s/::/\//g;
  require $module;
}

sub it {
  my $self = shift;
  my $name = shift;
  my $sub = shift;

  if (!$name || $sub) {
    require Carp;
    Carp::croak("No method name provided to mock") unless $name;
    Carp::croak("No subroutine name provided to mock") unless $sub;
  }

  {
    no strict;
    no warnings;

    *{$self->{module} . '::' . $name} = $sub;
  }
}

1;
__END__

=head1 NAME

Test::Mock::Simple - A simple way to mock out parts of or a whole module.

=head1 SYNOPSIS

  use Test::Mock::Simple;

  my $mock = Test::Mock::Simple->new(module => 'Module::To::Be::Mocked');

  $mock->it(add => sub { return mocked_add_method(@_); });

=head1 DESCRIPTION

This is a simple method of overriding any number of methods for a give
object/class.

Can be used directly in test (or any) files, but best practice (IMHO) is to
create a 'Mock' module and using it instead of directly using the module in your
tests.

Why another Mock module?  I needed something simple with no bells or whistles
that only overrode certain methods of a given module. It's more work, but there
aren't any conflicts.

=head3 Methods

=over 4

=item new

Create a new mock simple object.

=over 4

=item module

The name of the module that is being mocked.  The module will be loaded first
so that when you get around to mocking things they will override the module.

=back

=item it

This allows you to specify a new method (subroutine) that will override the
existing one.

The reason for the strange naming convention is because I like the way that
'$mock->it(...)' reads.

=back

=head1 AUTHOR

Erik Tank, E<lt>tank@jundy.com<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2013 by Erik Tank

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.14.2 or,
at your option, any later version of Perl 5 you may have available.


=cut