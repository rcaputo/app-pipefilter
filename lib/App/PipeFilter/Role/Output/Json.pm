package App::PipeFilter::Role::Output::Json;

use Moose::Role;

use JSON::XS;

sub encode_output {
  # Skips $self in $_[0].
  return map { encode_json($_) . "\n" } @_[1..$#_];
}

1;

# vim: ts=2 sw=2 expandtab
