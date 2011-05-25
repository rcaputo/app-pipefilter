package App::PipeFilter::Role::Output::Yaml;

use Moose::Role;

use YAML::Syck qw(Dump);

sub encode_output {
  # Skips $self in $_[0].
  return map { Dump($_) } @_[1..$#_];
}

1;

__END__

=pod

=head1 NAME

App::PipeFilter::Role::Output::Yaml - serialize output as YAML

=head1 SYNOPSIS

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

=head1 DESCRIPTION

App::PipeFilter::Role::Output::Yaml provides an encode_output() method
that serializes data into YAML for output.

L<App::PipeFilter::Generic> uses encode_output() to determine the
format of the data it will write.

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::Role::Output::Yaml

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and utilities included in the project.

=head1 BUGS

L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-PipeFilter>

=head1 REPOSITORY

L<https://github.com/rcaputo/app-pipefilter>

=head1 COPYRIGHT AND LICENSE

App::PipeFilter::Role::Output::Yaml
is Copyright 2011 by Rocco Caputo.
All rights are reserved.
App::PipeFilter::Role::Output::Yaml
is released under the same terms as Perl itself.

=cut

# vim: ts=2 sw=2 expandtab
