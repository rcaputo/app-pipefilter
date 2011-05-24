package App::PipeFilter::Role::Transform::None;

use Moose::Role;

sub transform {
  # Skips $self in $_[0].
  return @_[1..$#_];
}

1;

__END__

=head1 NAME

App::PipeFilter::Role::Transform::None - don't transform data at all

=head1 SYNOPSIS

Here is the class that makes up the jcat(1) utility.  It reads JSON,
does no transformations on the deserialized data, and writes new JSON
one object per line.

  package App::PipeFilter::JsonCat;

  use Moose;
  extends 'App::PipeFilter::Generic::Json';
  with 'App::PipeFilter::Role::Transform::None';

  1;

=head1 DESCRIPTION

App::PipeFilter::Role::Transform::None provides a transform() method
that returns its parameters without altering them.

L<App::PipeFilter::Generic> uses transform() to modify the contents of
streams being filtered.

The "None" transform is commonly used in filters that translate data
from one file or stream format to another without changing it.

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::Role::Transform::None

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and utilities included in the project.

=head1 BUGS

L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-PipeFilter>

=head1 REPOSITORY

L<https://github.com/rcaputo/app-pipefilter>

=head1 COPYRIGHT AND LICENSE

App::PipeFilter::Role::Transform::None
is Copyright 2011 by Rocco Caputo.
All rights are reserved.
App::PipeFilter::Role::Transform::None
is released under the same terms as Perl itself.

=cut

# vim: ts=2 sw=2 expandtab
