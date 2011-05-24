package App::PipeFilter::Role::Output::Json;

use Moose::Role;

use JSON::XS;

sub encode_output {
  # Skips $self in $_[0].
  return map { encode_json($_) . "\n" } @_[1..$#_];
}

1;

__END__

=head1 NAME

App::PipeFilter::Role::Output::Json - serialize output as one JSON
object per line

=head1 SYNOPSIS

  package App::PipeFilter::JsonToYaml;

  use Moose;

  extends 'App::PipeFilter::Generic';

  with qw(
    App::PipeFilter::Role::Reader::Sysread
    App::PipeFilter::Role::Input::Json
    App::PipeFilter::Role::Transform::None
    App::PipeFilter::Role::Output::Yaml
  );

  1;

=head1 DESCRIPTION

App::PipeFilter::Role::Output::Json provides an encode_output() method
that serializes data into JSON records for output.  Each line of
output will contain one JSON record.

L<App::PipeFilter::Generic> uses encode_output() to determine the
format of the data it will write.

L<App::PipeFilter::Generic::Json> is a generic filter that reads and
writes JSON streams.  It extends App::PipeFilter::Generic with both
L<App::PipeFilter::Role::Input::Json> and
App::PipeFilter::Role::Output::Json.

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::Role::Output::Json

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and utilities included in the project.

=head1 BUGS

L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-PipeFilter>

=head1 REPOSITORY

L<https://github.com/rcaputo/app-pipefilter>

=head1 COPYRIGHT AND LICENSE

App::PipeFilter::Role::Output::Json
is Copyright 2011 by Rocco Caputo.
All rights are reserved.
App::PipeFilter::Role::Output::Json
is released under the same terms as Perl itself.

=cut

# vim: ts=2 sw=2 expandtab
