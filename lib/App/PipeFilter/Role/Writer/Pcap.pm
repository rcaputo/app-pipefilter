package App::PipeFilter::Role::Writer::Pcap;

use Moose::Role;
use Net::Pcap qw(pcap_dump pcap_dump_flush);

sub write_output {
	my $pcap_dumper = $_[1];

  pcap_dump($pcap_dumper, @$_) foreach @_[2..$#_];
  pcap_dump_flush($pcap_dumper);
}

no Moose::Role;
1;

__END__

# vim: ts=2 sw=2 expandtab
