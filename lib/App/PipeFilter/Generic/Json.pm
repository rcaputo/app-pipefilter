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

=pod

=head1 NAME

App::PipeFilter::Generic::Json - a generic JSON pipeline filter

=head1 SYNOPSIS

  package App::PipeFilter::JsonCat;

  use Moose;
  extends 'App::PipeFilter::Generic::Json';
  with 'App::PipeFilter::Role::Transform::None';

  1;

=head1 DESCRIPTION

App::PipeFilter::Generic::Json is a generic base class for pipeline
filters that read and write streams of JSON objects.

It subclasses L<App::PipeFilter::Generic> and customizes it with the
following roles: L<App::PipeFilter::Role::Reader::Sysread>,
L<App::PipeFilter::Role::Input::Json> and
L<App::PipeFilter::Role::Output::Json>.

Further customization is done by implementing a transform() method or
consuming a role that implements one.  L<App::PipeFilter::JsonCat>
consumes a role that does no transformation.
L<App::PipeFilter::JsonCut> implements a transform() method that
extracts certain fields.

Additional customization is possible by overriding or extending the
generic classes' methods in the usual ways.

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::Generic::Json

L<App::PipeFilter::Generic> documents all the methods provided by the
base class and roles.

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and utilities included in the project.

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
