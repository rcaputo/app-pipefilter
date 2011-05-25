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

=pod

=head1 NAME

App::PipeFilter::JsonToYaml - translate streams of JSON objects into YAML

=head1 SYNOPSIS

Here is the json2yaml(1) pipeline filter.

  #!/usr/bin/perl
  use App::PipeFilter::JsonToYaml;
  exit App::PipeFilter::JsonToYaml->new_with_options()->run();

=head1 DESCRIPTION

App::PipeFilter::JsonToYaml implements the json2yaml(1) pipeline
filter.  It's modeled after cat(1), except that the output file format
differs from the input format.  The data's semantics remain identical,
formats permitting.

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::JsonToYaml

This module doesn't implement anything of its own.  It customizes
L<App::PipeFilter::Generic> with the following roles:
L<App::PipeFilter::Role::Reader::Sysread>,
L<App::PipeFilter::Role::Input::Json>,
L<App::PipeFilter::Role::Transform::None> and
L<App::PipeFilter::Role::Output::Yaml>.

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and utilities included in the project.

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
