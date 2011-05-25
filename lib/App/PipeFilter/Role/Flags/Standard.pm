package App::PipeFilter::Role::Flags::Standard;

use Moose::Role;

with 'MooseX::Getopt';

has _input_files => (
  is      => 'rw',
  isa     => 'ArrayRef',
  lazy    => 1,
  traits  => ['Array'],
  default => sub {
    my $self = shift();
    my @leftovers = @{$self->extra_argv()};
    @leftovers = ("-") unless @leftovers;
    return \@leftovers;
  },
  handles => {
    next_input_file => 'shift'
  },
);

has verbose => (
  is            => 'rw',
  isa           => 'Bool',
  default       => 0,
  documentation => 'boolean, enables default output',
);

1;

__END__

=pod

=head1 NAME

App::PipeFilter::Role::Flags::Standard - standard flag attributes and getopt

=head1 SYNOPSIS

This isn't a complete module because App::PipeFilter::Generic is one
of the largest modules, weighing in at some 40-ish lines.

  package App::PipeFilter::Generic;

  use Moose;
  with 'App::PipeFilter::Role::Flags::Standard';

  ... implementation goes here ....

  1;

=head1 DESCRIPTION

App::PipeFilter::Role::Flags::Standard provides standard pipeline
filter attributes and consumes MooseX::Getopt to populate them from
command line arguments.

=head1 PUBLIC ATTRIBUTES

=head2 verbose

The boolean verbose attribute (set by the --verbose command line flag)
optionally enables additional progress and status messages on standard
error.

Use with caution.  Some pipeline filters may use standard error for
their own purposes.

=head1 PUBLIC METHODS

=head2 next_input_file

next_input_file() returns the next input file name from the command
line.  If no file was named, it returns "-" representing STDIN.

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::Role::Flags::Standard

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and binaries included in the project.

=head1 BUGS

L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-PipeFilter>

=head1 REPOSITORY

L<https://github.com/rcaputo/app-pipefilter>

=head1 COPYRIGHT AND LICENSE

App::PipeFilter::Role::Flags::Standard
is Copyright 2011 by Rocco Caputo.
All rights are reserved.
App::PipeFilter::Role::Flags::Standard
is released under the same terms as Perl itself.

=cut

# vim: ts=2 sw=2 expandtab
