package App::PipeFilter::JsonIpToUdp;

use Moose;
extends 'App::PipeFilter::Generic::Json';
with 'App::PipeFilter::Role::Transform::IpToUdp';

1;

__END__

# vim: ts=2 sw=2 expandtab
