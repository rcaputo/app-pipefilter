package App::PipeFilter::Generic;

use Moose;
with qw(
  App::PipeFilter::Role::Flags::Standard
  App::PipeFilter::Role::Opener::GenericIO
);

sub run {
  my $self = shift();

  my $ofh = $self->open_output($self->output());

  while (defined (my $input_filename = $self->next_input_file())) {
    my $ifh = $self->open_input($input_filename);
    $self->filter_file($ifh, $ofh);
  }

  # Exit value.
  0;
}

sub filter_file {
  my ($self, $ifh, $ofh) = @_;

  my $buffer = "";

  while ($self->read_input($ifh, \$buffer)) {
    next unless my (@input) = $self->decode_input(\$buffer);
    next unless my (@output) = $self->transform(@input);
    print $ofh $_ foreach $self->encode_output(@output);
  }
}

1;

__END__

=head1 NAME

App::PipeFilter::Generic - a generic pipeline filter

=head1 SYNOPSIS

Here is a class that translates JSON input streams to YAML output.  It
extends the generic pipeline filter with roles to read input in large
chunks, parse JSON objects from those chunks, and serialize the
resulting data as YAML for output.

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

App::PipeFilter::Generic is a generic shell pipeline filter.  It's
designed to be subclassed and combined with roles for particular
purposes.  For example, L<App::PipeFilter::JsonToYaml> extends
App::PipeFilter::Generic with a role to parse JSON input and another
to serialize the output as YAML.  It performs no transformation since
it's only translating and possibly catenating its input.

L<App::PipeFilter::Role::Flags::Standard> provides some standard
command line flags, such as naming input and output files.

At the time of this writing, App::PipeFilter::Generic is fewer than 40
lines of code.

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::Generic

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and binaries included in the project.

=head1 BUGS

L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-PipeFilter>

=head1 REPOSITORY

L<https://github.com/rcaputo/app-pipefilter>

=head1 COPYRIGHT AND LICENSE

App::PipeFilter::Generic
is Copyright 2011 by Rocco Caputo.
All rights are reserved.
App::PipeFilter::Generic
is released under the same terms as Perl itself.

=cut

# vim: ts=2 sw=2 expandtab

=cut

# vim: ts=2 sw=2 expandtab
