package App::PipeFilter::Role::Transform::PcapToEthernet;

use Moose::Role;
use NetPacket::Ethernet;

sub transform {
	return(
		map {
			my $eth = NetPacket::Ethernet->decode(pack "H*", delete $_->{pcap_data});

			# Not sure why the + is required, but it makes all the difference.
			+{
				%$_,
				eth_data     => unpack("H*", $eth->{data}),
				eth_dest_mac => $eth->{dest_mac},
				eth_src_mac  => $eth->{src_mac},
				eth_type     => $eth->{type},
			};
		}
		# Skips $self in $_[0].
		@_[1..$#_]
	);
}

1;

__END__

# vim: ts=2 sw=2 expandtab
