package App::PipeFilter::Role::Reader::LineByLine;

use Moose::Role;

sub read_input {
  my ($self, $ifh, $buffer_ref) = @_;
  $$buffer_ref = <$ifh>;
  return((defined($$buffer_ref) || 0) && length($$buffer_ref));
}

1;

__END__

=head1 NAME

App::PipeFilter::Role::Reader::LineByLine - read input streams one
line at a time

=head1 SYNOPSIS

This is not a complete module.

  package App::PipeFilter::MysqlToJson;

  use Moose;

  extends 'App::PipeFilter::Generic';
  with qw(
    App::PipeFilter::Role::Reader::LineByLine
    App::PipeFilter::Role::Output::Json
    App::PipeFilter::Role::Transform::None
  );

  ... implementation goes here ....

  1;

=head1 DESCRIPTION

App::PipeFilter::Role::Reader::LineByLine implements a read_input()
method that returns one line of input at a time.

L<App::PipeFilter::Generic> uses read_input() to consume data from its
current input filehandle.  Some input sources and file formats work
better with line-by-line input, although
L<App::PipeFitler::Role::Reader::Sysread> is generally faster when
it's available.

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::Role::Reader::LineByLine

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and binaries included in the project.

The json_xs(1) utility can reformat JSON vertically as well, if you
prefer JSON over YAML.

=head1 BUGS

L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-PipeFilter>

=head1 REPOSITORY

L<https://github.com/rcaputo/app-pipefilter>

=head1 COPYRIGHT AND LICENSE

App::PipeFilter::Role::Reader::LineByLine
is Copyright 2011 by Rocco Caputo.
All rights are reserved.
App::PipeFilter::Role::Reader::LineByLine
is released under the same terms as Perl itself.

=cut

# vim: ts=2 sw=2 expandtab
