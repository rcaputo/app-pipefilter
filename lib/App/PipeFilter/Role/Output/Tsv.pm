package App::PipeFilter::Role::Output::Tsv;

use Moose::Role;

requires qw( o );

sub encode_output {
  # Skips $self in $_[0].

  my @cols = @{ $_[0]->o() };
  return map {
    join("\t", map { s/\t/\\t/g; $_ } @{$_}{@cols}), "\n"
  } @_[1..$#_];
}

1;

__END__

=pod

=head1 NAME

App::PipeFilter::Role::Output::Tsv - serialize output objects one per TSV row

=head1 SYNOPSIS

  package App::PipeFilter::JsonToTsv;

  use Moose;

  extends 'App::PipeFilter::Generic';

  with qw(
    App::PipeFilter::Role::Reader::Sysread
    App::PipeFilter::Role::Input::Json
    App::PipeFilter::Role::Transform::None
    App::PipeFilter::Role::Output::Tsv
  );

  1;

=head1 DESCRIPTION

App::PipeFilter::Role::Output::Tsv provides an encode_output() method
that serializes data into tab-separated values for output.  It
requires the class to implement an o() attribute, which should hold an
array reference of columns to output.  Columns will be written in the
order they appear in o().

L<App::PipeFilter::Generic> uses encode_output() to determine the
format of the data it will write.

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::Role::Output::Tsv

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and utilities included in the project.

=head1 BUGS

L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-PipeFilter>

=head1 REPOSITORY

L<https://github.com/rcaputo/app-pipefilter>

=head1 COPYRIGHT AND LICENSE

App::PipeFilter::Role::Output::Tsv
is Copyright 2011 by Rocco Caputo.
All rights are reserved.
App::PipeFilter::Role::Output::Tsv
is released under the same terms as Perl itself.

=cut

# vim: ts=2 sw=2 expandtab
