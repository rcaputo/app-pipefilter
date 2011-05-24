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
method that returns large chunks of input at a time.  Input chunks are
arbitrary; they do not honor the structure of the files being read.

L<App::PipeFilter::Generic> uses read_input() to consume data from its
current input filehandle.

This role is faster than L<App::PipeFilter::Role::Reader::LineByLine>,
but it may not work with all devices.  Some data formats may be easier
to work with on a line-by-line basis.

=head1 PUBLIC METHODS

=head2 read_input FILEHANDLE, SCALAR_REF

read_input() reads the next chunk of data from a FILEHANDLE using
Perl's built-in sysread() function.  It appends this chunk of data to
the buffer pointed at by a SCALAR_REF.  It returns sysread()'s result.

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::Role::Reader::Sysread

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and utilities included in the project.

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
