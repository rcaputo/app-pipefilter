package App::PipeFilter::JsonToYaml;

use Moose;

extends 'App::PipeFilter::Generic';

with qw(
  App::PipeFilter::Role::Reader::Sysread
  App::PipeFilter::Role::Input::Json
  App::PipeFilter::Role::Transform::None
  App::PipeFilter::Role::Output::Yaml
);

1;

__END__

=head1 NAME

App::PipeFilter::JsonToYaml - translate streams of JSON objects into
YAML

=head1 SYNOPSIS

Here is the json2yaml pipeline filter in its entirety:

  #!/usr/bin/perl
  use App::PipeFilter::JsonToYaml;
  exit App::PipeFilter::JsonToYaml->new_with_options()->run();

=head1 DESCRIPTION

App::PipeFilter::JsonToYaml implements a pipeline filter that converts
JSON objects into a stream of YAML structures.  Each YAML structure
represents a single JSON object.

The YAML stream is vertical, with one field per line, whereas most of
the JSON filters write entire objects per line.

This filter is often used as the equivalent of mysql(1)'s \G command:

  ego (\G) Send command to mysql server, display result vertically.

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::JsonToYaml

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and binaries included in the project.

The json_xs(1) utility can reformat JSON vertically as well, if you
prefer JSON over YAML.

=head1 BUGS

L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-PipeFilter>

=head1 REPOSITORY

L<https://github.com/rcaputo/app-pipefilter>

=head1 COPYRIGHT AND LICENSE

App::PipeFilter::JsonToYaml
is Copyright 2011 by Rocco Caputo.
All rights are reserved.
App::PipeFilter::JsonToYaml
is released under the same terms as Perl itself.

=cut

# vim: ts=2 sw=2 expandtab
