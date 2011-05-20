package App::PipeFilter::Generic::Json;

use Moose;

extends 'App::PipeFilter::Generic';

with qw(
  App::PipeFilter::Role::Input::Json
  App::PipeFilter::Role::Output::Json
);

1;

# vim: ts=2 sw=2 expandtab
