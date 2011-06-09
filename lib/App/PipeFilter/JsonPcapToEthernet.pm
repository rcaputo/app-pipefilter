package App::PipeFilter::JsonPcapToEthernet;

use Moose;
extends 'App::PipeFilter::Generic::Json';
with 'App::PipeFilter::Role::Transform::PcapToEthernet';

1;

__END__

# vim: ts=2 sw=2 expandtab
