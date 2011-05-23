package App::PipeFilter::JsonCat;

use Moose;
extends 'App::PipeFilter::Generic::Json';
with 'App::PipeFilter::Role::Transform::None';

1;

__END__

=head1 NAME

App::PipeFilter::JsonCat - useless use of cat(1) for JSON input and output.

=head1 SYNOPSIS

Here is the implementation of the jcat(1) pipe filter.

  #!/usr/bin/perl
  use App::PipeFilter::JsonCat;
  exit App::PipeFilter::JsonCat->new_with_options()->run();

=head1 DESCRIPTION

App::PipeFilter::JsonCat may be used to transform one stream of
multiline JSON objects into another stream of JSON objects.  The
output stream will contain only one JSON object per line regardless of
the input stream's format.

It extends L<App::PipeFilter::Generic::Json> with a do-nothing
transform() method from L<App::PipeFilter::Role::Transform::None>.
The implementation is literally five lines of code.

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::JsonCat

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and binaries included in the project.

=head1 BUGS

L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-PipeFilter>

=head1 REPOSITORY

L<https://github.com/rcaputo/app-pipefilter>

=head1 COPYRIGHT AND LICENSE

App::PipeFilter::JsonCat
is Copyright 2011 by Rocco Caputo.
All rights are reserved.
App::PipeFilter::JsonCat
is released under the same terms as Perl itself.

=cut

# vim: ts=2 sw=2 expandtab
