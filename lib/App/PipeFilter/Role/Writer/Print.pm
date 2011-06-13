package App::PipeFilter::Role::Writer::Print;

use Moose::Role;

sub write_output {
  print { $_[1] } @_[2..$#_];
}

1;

__END__

# vim: ts=2 sw=2 expandtab
