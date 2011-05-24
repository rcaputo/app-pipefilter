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

App::PipeFilter::JsonMap - map input fields to output fields by
renaming them

=head1 SYNOPSIS

  #!/usr/bin/perl
  use App::PipeFilter::JsonMap;
  exit App::PipeFilter::JsonMap->new_with_options()->run();

=head1 DESCRIPTION

App::PipeFilter::JsonMap implements the jmap(1) pipeline filter.  It
renames JSON object fields by mapping input field names to new ones on
output.

This class subclasses L<App::PipeFilter::Generic::Json>.

=head1 PUBLIC ATTRIBUTES

=head2 i

The i() attribute holds an arrayref of one or more input fields to be
renamed.  All other input fields will be present in the resulting
output without being renamed.  MooseX::Getopt sets i() to the values
of the -i options from the command line.

=head2 o

The o() attribute holds an arrayref of the new names of the fields
from i().  Both i() and o() must have the same number of field names.
MooseX::Getopt sets o() to the values of the -o options from the
command line.

=head1 PUBLIC METHODS

=head2 transform

The transform() method renames the fields named in the i() attribute
to the names found in the o() attribute.

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::JsonMap

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and utilities included in the project.

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
