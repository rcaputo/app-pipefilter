package App::PipeFilter::Generic::Json;

use Moose;

extends 'App::PipeFilter::Generic';

with qw(
  App::PipeFilter::Role::Reader::Sysread
  App::PipeFilter::Role::Input::Json
  App::PipeFilter::Role::Output::Json
);

1;

__END__

=head1 NAME

App::PipeFilter::Generic::Json - a generic JSON pipe filter

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

App::PipeFilter::Generic::Json is a generic JSON pipe filter.  It
extends L<App::PipeFilter::Generic> which does most of the work.  It
consumes L<App::PipeFilter::Role::Reader::Sysread> to read input in
large chunks.  It consumes L<App::PipeFilter::Role::Input::Json> to
parse the input as JSON and L<App::PipeFilter::Role::Output::Json> to
write output as JSON.

Subclasses usually implement a transform() sub or consume a role that
does.  L<App::PipeFilter::JsonCat> consumes a role that does no
transformation.

Additional customization is possible by overriding or extending the
generic classes' methods in the usual ways.

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::Generic::Json

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and binaries included in the project.

=head1 BUGS

L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-PipeFilter>

=head1 REPOSITORY

L<https://github.com/rcaputo/app-pipefilter>

=head1 COPYRIGHT AND LICENSE

App::PipeFilter::Generic::Json
is Copyright 2011 by Rocco Caputo.
All rights are reserved.
App::PipeFilter::Generic::Json
is released under the same terms as Perl itself.

=cut

# vim: ts=2 sw=2 expandtab
