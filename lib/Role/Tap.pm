package Role::Tap;

use Role::Tiny;

our $VERSION = '0.001';

sub tap {
  my ($self, $cb) = (shift, shift);
  $_->$cb(@_) for $self;
  return $self;
}

1;

=head1 NAME

Role::Tap - A tiny role for method chaining

=head1 SYNOPSIS

 package My::Object;
 use Role::Tiny::With;
 with 'Role::Tap';

 # Elsewhere
 my $object = My::Object->new->tap($method, @args);

 # Longer version
 $object = $object->tap(sub { $_->$method(@args) });

 # Inject side effects into a method chain
 $object->foo('A')->tap(sub { say $_->foo })->foo('B');

=head1 DESCRIPTION

L<Role::Tap> is a tiny role based on L<Mojo::Base/"tap"> which gives your
object a L</"tap"> method. This method runs a coderef or method on the object,
ignores the return value, and returns the object so you can chain more method
calls.

=head1 METHODS

=head2 tap

 $object = $object->tap(sub {...});
 $object = $object->tap($method);
 $object = $object->tap($method, @args);

K combinator, tap into a method chain to perform operations on an object within
the chain. The object will be the first argument passed to the callback and is
also available as C<$_>.

=head1 BUGS

Report any issues on the public bugtracker.

=head1 AUTHOR

Dan Book <dbook@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2015 by Dan Book.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=head1 SEE ALSO

L<Object::Tap>, L<MooX::ChainedAttributes>, L<MooseX::Attribute::Chained>
