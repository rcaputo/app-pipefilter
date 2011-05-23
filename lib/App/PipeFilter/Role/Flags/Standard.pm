package App::PipeFilter::Role::Flags::Standard;

use Moose::Role;

with 'MooseX::Getopt';

has input => (
  is            => 'rw',
  isa           => 'ArrayRef',
  default       => sub { [ '-' ] },
  traits        => ['Array'],
  documentation => 'input file names (zero or more, default is standard input)',
  handles       => {
    next_input_file => 'shift',
  },
);

has output => (
  is            => 'rw',
  isa           => 'Str',
  default       => '-',
  documentation => 'output file name (zero or one, default is standard output)',
);

has verbose => (
  is            => 'rw',
  isa           => 'Bool',
  default       => 0,
  documentation => 'boolean, enables default output',
);

1;

__END__

=head1 NAME

App::PipeFilter::Role::Flags::Standard - provide attributes and getopt
parsing for standard pipeline filter flags

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

=head1 ATTRIBUTES

=head2 input

The input attribute (set by the --input command line flag) specifies
zero or more file or device names from which input data will be read.
It defaults to '-', which causes L<App::PipeFilter::Generic> to read
from standard input.

=head2 output

The output attribute (set by the --output command line flag) specifies
zero or one file or device name into which output will be written.  It
defaults to '-', which causes L<App::PipeFilter::Generic> to write to
standard output.

=head2 verbose

The boolean verbose attribute (set by the --verbose command line flag)
optionally enables additional progress and status messages on standard
error.

Use with caution.  Some pipeline filters may use standard error for
their own purposes.

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
