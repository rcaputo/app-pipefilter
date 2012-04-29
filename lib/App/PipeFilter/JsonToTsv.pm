package App::PipeFilter::JsonToTsv;

use Moose;
extends 'App::PipeFilter::Generic';

# TODO - Refactor into a common role?  Duplicated in JsonCut.pm.

has o => (
  is            => 'rw',
  isa           => 'ArrayRef',
  default       => sub { die "requires one or more -o flag" },
  lazy          => 1,
  documentation => 'output fields (a subset of the input)',
);

with (
  "App::PipeFilter::Role::Reader::Sysread",
  "App::PipeFilter::Role::Writer::Print",
  "App::PipeFilter::Role::Input::Json",
  "App::PipeFilter::Role::Transform::None",
  "App::PipeFilter::Role::Output::Tsv",
);

1;

__END__

=pod

=head1 NAME

App::PipeFilter::JsonToTsv - translate streams of JSON objects into tab-separated columns

=head1 SYNOPSIS

Here is the json2tsv(1) pipeline filter.

  #!/usr/bin/perl
  use App::PipeFilter::JsonToTsv;
  exit App::PipeFilter::JsonToTsv->new_with_options()->run();

=head1 DESCRIPTION

App::PipeFilter::JsonToTsv implements the json2tsv(1) pipeline filter.
It's modeled after cut(1), except that it reads JSON objects and
writes a stream of tab-separated rows.

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::JsonToTsv

This module doesn't implement anything of its own.  It customizes
L<App::PipeFilter::Generic> with the following roles:
L<App::PipeFilter::Role::Reader::Sysread>,
L<App::PipeFilter::Role::Input::Json>,
L<App::PipeFilter::Role::Transform::None> and
L<App::PipeFilter::Role::Output::Tsv>.

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and utilities included in the project.

=head1 BUGS

L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-PipeFilter>

=head1 REPOSITORY

L<https://github.com/rcaputo/app-pipefilter>

=head1 COPYRIGHT AND LICENSE

App::PipeFilter::JsonToTsv
is Copyright 2011 by Rocco Caputo.
All rights are reserved.
App::PipeFilter::JsonToTsv
is released under the same terms as Perl itself.

=cut

# vim: ts=2 sw=2 expandtab
