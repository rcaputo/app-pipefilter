package App::PipeFilter::JsonPath;

use Moose;
extends 'App::PipeFilter::Generic::Json';

use JSON::Path;

has o => (
  is            => 'rw',
  isa           => 'ArrayRef',
  default       => sub { die "requires one or more -o flag" },
  lazy          => 1,
  documentation => 'output fields (a subset of the input)',
);

has _o => (
  is            => 'rw',
  isa           => 'ArrayRef[JSON::Path]',
  lazy          => 1,
  default       => sub {
		my $self = shift;
		return [ map { JSON::Path->new($_) } @{$self->o()} ];
	},
);

sub transform {
  my $self = shift();

  my @json_paths = @{$self->_o()};

  my @output;

  my $c = 0;
  foreach my $json_path (@json_paths) {
    my $r = 0;
    foreach my $json_value ($json_path->values($_[0])) {
      $output[$r++]{"col$c"} = $json_value;
    }
    ++$c;
  }

	return @output;
}

1;

__END__

=head1 NAME

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::JsonPath

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and binaries included in the project.

=head1 BUGS

L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-PipeFilter>

=head1 REPOSITORY

L<https://github.com/rcaputo/app-pipefilter>

=head1 COPYRIGHT AND LICENSE

App::PipeFilter::JsonPath
is Copyright 2011 by Rocco Caputo.
All rights are reserved.
App::PipeFilter::JsonPath
is released under the same terms as Perl itself.

=cut

# vim: ts=2 sw=2 expandtab
