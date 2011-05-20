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

# vim: ts=2 sw=2 expandtab
