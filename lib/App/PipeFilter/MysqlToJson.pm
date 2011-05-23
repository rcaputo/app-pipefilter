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
  return( [ split /\t/, $$input_ref ] );
}

sub encode_output {
  my $self = shift();

  my @fields = @{$self->_fields()};

  return map {
    my %sortable;
    @sortable{@fields} = @$_;
    encode_json(\%sortable) . "\n";
  } @_;
}

1;

__END__

=head1 NAME

App::PipeFilter::MysqlToJson - translate mysql batch output to JSON

=head1 SYNOPSIS

Here is the mysql2json pipeline filter in its entirety:

  #!/usr/bin/perl
  use App::PipeFilter::MysqlToJson;
  exit App::PipeFilter::MysqlToJson->new_with_options()->run();

=head1 DESCRIPTION

App::PipeFilter::MysqlToJson implements a pipeline filter that
converts mysql batch output into a stream of JSON objects, one per
output line.  Each JSON object represents a single MySQL row.

Mysql batch output is produced by the mysql(1) utility's -B flag.

  mysql -B -e '
    select inet_b2a(exporter_id) as exporter,
    unix_timestamp(modified_ts) as ts
    from plixer.exporters
  ' | ./bin/mysql2json

Produces output like this:

  {"ts":"1305915274","exporter":"10.0.0.2"}

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::MysqlToJson

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and binaries included in the project.

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
