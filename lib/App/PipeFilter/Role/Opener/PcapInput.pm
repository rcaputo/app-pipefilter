package App::PipeFilter::Role::Opener::PcapInput;

use Moose::Role;
use Net::Pcap qw(pcap_open_offline);

sub open_input {
	my ($self, $filename) = @_;

	my $err = "";
	my $pcap = pcap_open_offline($filename, \$err);
  die "unable to open pcap $filename: $err" unless defined $pcap;

	return $pcap;
}

no Moose::Role;
1;

__END__

# vim: ts=2 sw=2 expandtab
