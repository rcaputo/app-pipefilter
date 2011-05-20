package App::PipeFilter::Role::Transform::None;

use Moose::Role;

sub transform {
  # Skips $self in $_[0].
  return @_[1..$#_];
}

1;

# vim: ts=2 sw=2 expandtab
