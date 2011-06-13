package App::PipeFilter::Role::Opener::PcapOutput;

use Moose::Role;

use Net::Pcap qw(DLT_EN10MB pcap_open_dead pcap_dump_open);

sub open_output {
  my ($self, $filename) = @_;

	my $pcap;
	unless ($pcap = pcap_open_dead(DLT_EN10MB, 65536)) {
		die "couldn't pcap_open_dead: $!";
	}

	my $dumper;
	unless ($dumper = pcap_dump_open($pcap, $filename)) {
		die "couldn't open $filename for writing: " . pcap_geterr($pcap);
	}

	return $dumper;
}

1;

__END__

# vim: ts=2 sw=2 expandtab
