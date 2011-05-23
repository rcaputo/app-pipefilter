package App::PipeFilter::Role::Opener::GenericOutput;

use Moose::Role;

sub open_output {
	my ($self, $filename) = @_;

  if ($filename eq '-') {
		warn "writing to standard output\n" if $self->verbose();
    return \*STDOUT;
  }

	warn "writing to $filename\n" if $self->verbose();
	open my $fh, ">", $filename or die "can't write $filename: $!";
  return $fh;
}

1;

__END__

=head1 NAME

App::PipeFilter::Role::Opener::GenericOutput - generic method to open
output files, streams or standard output

=head1 SYNOPSIS

  package App::PipeFilter::Role::Opener::GenericIO;

  use Moose::Role;

  with qw(
    App::PipeFilter::Role::Opener::GenericInput
    App::PipeFilter::Role::Opener::GenericOutput
  );

  1;

=head1 DESCRIPTION

App::PipeFilter::Role::Opener::GenericOutput provides a generic
open_output() method to open named output files, devices or streams.
It opens STDIN in the case wehre the output file is named "-" (which
is often the default).

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::Role::Opener::GenericOutput

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and binaries included in the project.

=head1 BUGS

L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-PipeFilter>

=head1 REPOSITORY

L<https://github.com/rcaputo/app-pipefilter>

=head1 COPYRIGHT AND LICENSE

App::PipeFilter::Role::Opener::GenericOutput
is Copyright 2011 by Rocco Caputo.
All rights are reserved.
App::PipeFilter::JsonCat
is released under the same terms as Perl itself.

=cut

# vim: ts=2 sw=2 expandtab
