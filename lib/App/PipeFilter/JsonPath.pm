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

# vim: ts=2 sw=2 expandtab
