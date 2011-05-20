package App::PipeFilter::Role::Output::Yaml;

use Moose::Role;

use YAML::Syck qw(Dump);

sub encode_output {
  # Skips $self in $_[0].
  return map { Dump($_) } @_[1..$#_];
}

1;

# vim: ts=2 sw=2 expandtab
