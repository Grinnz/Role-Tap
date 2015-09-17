use strict;
use warnings;

package Object::TapTester;
use Role::Tiny::With;
with 'Role::Tap';

sub new { bless {}, shift }

sub name {
  my $self = shift;
  return $self->{name} unless @_;
  $self->{name} = shift;
}

sub tests {
  my $self = shift;
  return $self->{tests} ||= 1 unless @_;
  $self->{tests} = shift;
}

sub more_tests { shift->{tests} += shift // 1 }

package main;
use Test::More;

# Tap into chain
my $object = Object::TapTester->new;
is $object->tap(sub { $_->name('foo') })->name, 'foo', 'right attribute value';
is $object->tap(sub { shift->name('bar') })->name, 'bar', 'right attribute value';
is $object->tap('tests')->tests, 1, 'right attribute value';
is $object->more_tests, 2, 'right attribute value';
is $object->tap('more_tests')->tests, 3, 'right attribute value';
is $object->tap(more_tests => 3)->tests, 6, 'right attribute value';

done_testing;
