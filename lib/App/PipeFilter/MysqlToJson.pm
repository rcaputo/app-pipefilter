package App::PipeFilter::MysqlToJson;

use Moose;

extends 'App::PipeFilter::Generic';
with qw(
  App::PipeFilter::Role::Reader::LineByLine
  App::PipeFilter::Role::Output::Json
  App::PipeFilter::Role::Transform::None
);

use JSON::XS;

has _fields => (
  is  => 'rw',
  isa => 'ArrayRef',
);

before filter_file => sub {
  my ($self, $ifh, $ofh) = @_;

  # First line of MySQL bulk output (-B) is the field headers.
  $self->_fields( [ (scalar(<$ifh>) =~ m/(\S+)/g) ] );
};

sub decode_input {
  my ($self, $input_ref) = @_;
  chomp($$input_ref);

  my %row;
  @row{@{$self->_fields()}} = split /\t/, $$input_ref;
  return \%row;
}

1;

__END__

=head1 NAME

App::PipeFilter::MysqlToJson - translate mysql batch output to JSON

=head1 SYNOPSIS

Here is the mysql2json(1) pipeline filter.

  #!/usr/bin/perl
  use App::PipeFilter::MysqlToJson;
  exit App::PipeFilter::MysqlToJson->new_with_options()->run();

=head1 DESCRIPTION

App::PipeFilter::MysqlToJson implements the mysql2json(1) pipeline
filter.  Please see mysql2json(1) for usage instructions.

This module reads mysql(1) batch output (via the -B option) and
produces a single JSON object per MySQL row.

Mysql batch output is produced by the mysql(1) utility's -B flag.

  mysql -B -u user -password -h 10.0.0.5 database \
    -e 'select crontab_id, task_id from crontab' | \
		mysql2json | jsort -k task_id -rn | head -5

Output may look like this:

	{"crontab_id":"102","task_id":"701"}
	{"crontab_id":"101","task_id":"700"}
	{"crontab_id":"100","task_id":"650"}
	{"crontab_id":"8","task_id":"599"}
	{"crontab_id":"14","task_id":"38"}

=head1 PUBLIC METHODS

=head2 decode_input

App::PipeFilter::MysqlToJson's decode_input() method parses mysql(1)
tab-separated rows into Perl data structures.  Field names are
extracted from the first line of the mysql(1) batch output.

=head2 filter_file (before)

mysql(1) batch output is tab-separated values.  The first line of
output contains column names, which are read by code that runs before
filter_file().

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::MysqlToJson

App::PipeFilter::MysqlToJson subclasses L<App::PipeFilter::Generic>.
It consumes L<App::PipeFilter::Role::Reader::LineByLine>,
L<App::PipeFilter::Role::Output::Json> and
L<App::PipeFilter::Role::Transform::None>

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and utilities included in the project.

=head1 BUGS

L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-PipeFilter>

=head1 TODO

App::PipeFilter::MysqlToJson uses
L<App::PipeFilter::Role::Reader::LineByLine> for simplicity.  It could
use L<App::PipeFilter::Role::Reader::Sysread> to be significantly
faster.

=head1 REPOSITORY

L<https://github.com/rcaputo/app-pipefilter>

=head1 COPYRIGHT AND LICENSE

App::PipeFilter::MysqlToJson
is Copyright 2011 by Rocco Caputo.
All rights are reserved.
App::PipeFilter::MysqlToJson
is released under the same terms as Perl itself.

=cut

# vim: ts=2 sw=2 expandtab
