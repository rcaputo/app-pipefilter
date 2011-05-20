package App::PipeFilter::MysqlToJson;

use Moose;

extends 'App::PipeFilter::Generic';
with qw(
  App::PipeFilter::Role::Output::Json
  App::PipeFilter::Role::Transform::None
);

use JSON::XS;

has _fields => (
  is  => 'rw',
  isa => 'ArrayRef',
);

sub file_start {
  my ($self, $ifh, $ofh) = @_;

  # First line of MySQL bulk output (-B) is the field headers.
  $self->_fields( [ (scalar(<$ifh>) =~ m/(\S+)/g) ] );
}

sub decode_input {
  my ($self, $input) = @_;
  chomp($input);
  return( [ split /\t/, $input ] );
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

# vim: ts=2 sw=2 expandtab
