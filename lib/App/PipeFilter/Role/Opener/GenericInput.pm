package App::PipeFilter::Role::Opener::GenericInput;

use Moose::Role;

sub open_input {
  my ($self, $filename) = @_;

  if ($filename eq '-') {
    warn "reading from standard input\n" if $self->verbose();
    return \*STDIN;
  }

  warn "reading from $filename\n" if $self->verbose();
  open my $fh, "<", $filename or die "can't open $filename: $!";
  return $fh;
}

1;

__END__

=pod

=head1 NAME

App::PipeFilter::Role::Opener::GenericInput - common method to open input files

=head1 SYNOPSIS

  package App::PipeFilter::Role::Opener::GenericIO;

  use Moose::Role;

  with qw(
    App::PipeFilter::Role::Opener::GenericInput
    App::PipeFilter::Role::Opener::GenericOutput
  );

  1;

=head1 DESCRIPTION

App::PipeFilter::Role::Opener::GenericInput provides a generic
open_input() method to open named input files, devices or streams.  It
opens STDIN when the input file is named "-" (which is often the
default).

L<App::PipeFilter::Generic> uses open_input() to open the input files
specified on the command line.  Opening files is done in a dedicated
method so it may be augmented or overridden in subclasses.

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::Role::Opener::GenericInput

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and utilities included in the project.

=head1 BUGS

L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-PipeFilter>

=head1 REPOSITORY

L<https://github.com/rcaputo/app-pipefilter>

=head1 COPYRIGHT AND LICENSE

App::PipeFilter::Role::Opener::GenericInput
is Copyright 2011 by Rocco Caputo.
All rights are reserved.
App::PipeFilter::Role::Opener::GenericInput
is released under the same terms as Perl itself.

=cut

# vim: ts=2 sw=2 expandtab
