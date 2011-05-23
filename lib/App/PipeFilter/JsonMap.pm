package App::PipeFilter::JsonMap;

use Moose;
extends 'App::PipeFilter::Generic::Json';

has i => (
  is            => 'rw',
  isa           => 'ArrayRef',
  default       => sub { die "requires one or more -i flag" },
  lazy          => 1,
  documentation => 'input fields (a subset of the input)',
);

has o => (
  is            => 'rw',
  isa           => 'ArrayRef',
  default       => sub { die "requires one or more -o flag" },
  lazy          => 1,
  documentation => 'output fields (a subset of the input)',
);

sub BUILD {
  my $self = shift;
  die "must have same number of -i fields as -o fields" if (
    @{$self->i()} != @{$self->o()}
  );
}

sub transform {
  my $self = shift();

  my %field_map;
  @field_map{@{$self->i()}} = @{$self->o()};

  return map {
    # TODO - Can this be done without a temporary variable?
    my %x = %$_;
    $x{$field_map{$_}} = delete $x{$_} foreach keys %field_map;
    \%x;
  } @_;
}

1;

__END__

=head1 NAME

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::JsonMap

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and binaries included in the project.

=head1 BUGS

L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-PipeFilter>

=head1 REPOSITORY

L<https://github.com/rcaputo/app-pipefilter>

=head1 COPYRIGHT AND LICENSE

App::PipeFilter::JsonMap
is Copyright 2011 by Rocco Caputo.
All rights are reserved.
App::PipeFilter::JsonMap
is released under the same terms as Perl itself.

=cut

# vim: ts=2 sw=2 expandtab
