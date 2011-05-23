package App::PipeFilter::Role::Input::Json;

use Moose::Role;

use JSON::XS;

has _json => (
  is      => 'rw',
  isa     => 'JSON::XS',
  lazy    => 1,
  default => sub { JSON::XS->new() },
);

sub decode_input {
  my ($self, $buffer_ref) = @_;
  my (@return) = $self->_json()->incr_parse($$buffer_ref);
  $$buffer_ref = "";
  return @return;
}

1;

__END__

=head1 NAME

App::PipeFilter::Role::Input::Json - parse JSON records from an input
file or stream

=head1 SYNOPSIS

  package App::PipeFilter::Generic::Json;

  use Moose;

  extends 'App::PipeFilter::Generic';

  with qw(
    App::PipeFilter::Role::Input::Json
    App::PipeFilter::Role::Output::Json
  );

  1;

=head1 DESCRIPTION

App::PipeFilter::Role::Input::Json provides a decode_input() method that
parses JSON.

L<App::PipeFilter::Generic> uses this method to determine the format
of the data it will write.

L<App::PipeFilter::Generic::Json> is a generic filter that reads and
writes JSON.  It extends App::PipeFilter::Generic with both
App::PipeFilter::Role::Input::Json and
L<App::PipeFilter::Role::Output::Json>.

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::Role::Input::Json

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and binaries included in the project.

=head1 BUGS

L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-PipeFilter>

=head1 REPOSITORY

L<https://github.com/rcaputo/app-pipefilter>

=head1 COPYRIGHT AND LICENSE

App::PipeFilter::Role::Input::Json
is Copyright 2011 by Rocco Caputo.
All rights are reserved.
App::PipeFilter::Role::Input::Json
is released under the same terms as Perl itself.

=cut

# vim: ts=2 sw=2 expandtab
