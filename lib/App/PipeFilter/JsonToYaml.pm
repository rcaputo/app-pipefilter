package App::PipeFilter::JsonToYaml;

use Moose;

extends 'App::PipeFilter::Generic';

with qw(
  App::PipeFilter::Role::Input::Json
  App::PipeFilter::Role::Transform::None
  App::PipeFilter::Role::Output::Yaml
);

1;

# vim: ts=2 sw=2 expandtab
