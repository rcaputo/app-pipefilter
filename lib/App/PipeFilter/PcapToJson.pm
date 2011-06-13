package App::PipeFilter::PcapToJson;

use Moose;
extends 'App::PipeFilter::Generic';

with (
  "App::PipeFilter::Role::Opener::PcapInput",
  "App::PipeFilter::Role::Reader::Pcap",
  "App::PipeFilter::Role::Writer::Print",
  "App::PipeFilter::Role::Input::ArrayBuffer",
  "App::PipeFilter::Role::Transform::None",
  "App::PipeFilter::Role::Output::Json",
);

1;

__END__

# vim: ts=2 sw=2 expandtab
