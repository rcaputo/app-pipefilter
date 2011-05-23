package App::PipeFilter::Role::Reader::Sysread;

use Moose::Role;

sub read_input {
  my ($self, $ifh, $buffer_ref) = @_;
  sysread($ifh, $$buffer_ref, 65536, length($$buffer_ref));
}

1;

__END__

=head1 NAME

App::PipeFilter::Role::Reader::Sysread - read input streams in large
chunks for speed

=head1 SYNOPSIS

  package App::PipeFilter::Generic::Json;

  use Moose;

  extends 'App::PipeFilter::Generic';

  with qw(
    App::PipeFilter::Role::Reader::Sysread
    App::PipeFilter::Role::Input::Json
    App::PipeFilter::Role::Output::Json
  );

  1;

=head1 DESCRIPTION

App::PipeFilter::Role::Reader::Sysread implements a read_input()
method that returns large chunks of input at a time.  This role is
recommended whenever the input data source and stream format allow.

L<App::PipeFilter::Generic> uses read_input() to consume data from its
current input filehandle.

Some input sources and file formats work better with
L<App::PipeFilter::Role::Reader::LineByLine>, although line-based
input is usually slower.

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::Role::Reader::Sysread

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and binaries included in the project.

The json_xs(1) utility can reformat JSON vertically as well, if you
prefer JSON over YAML.

=head1 BUGS

L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-PipeFilter>

=head1 REPOSITORY

L<https://github.com/rcaputo/app-pipefilter>

=head1 COPYRIGHT AND LICENSE

App::PipeFilter::Role::Reader::Sysread
is Copyright 2011 by Rocco Caputo.
All rights are reserved.
App::PipeFilter::Role::Reader::Sysread
is released under the same terms as Perl itself.

=cut

# vim: ts=2 sw=2 expandtab
