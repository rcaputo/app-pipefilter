package App::PipeFilter::JsonEthernetToIp;

use Moose;
extends 'App::PipeFilter::Generic::Json';
with 'App::PipeFilter::Role::Transform::EthernetToIp';

1;

__END__

# vim: ts=2 sw=2 expandtab
