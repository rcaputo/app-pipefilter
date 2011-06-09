package App::PipeFilter::Role::Reader::Pcap;

use Moose::Role;
use Net::Pcap qw(pcap_next);

sub read_input {
  my ($self, $ifh, $buffer_ref) = @_;

	my %header;
	my $packet = pcap_next($ifh, \%header);

	return unless defined $packet;

	$$buffer_ref = [
    {
      ( map { ("pcap_$_", $header{$_}) } keys %header ),
      # Binary data saved as hex to avoid UTF-8-ification.
      pcap_data => unpack("H*", $packet),
    }
	];

	return 1;
}

no Moose::Role;
1;

__END__

# vim: ts=2 sw=2 expandtab
