package App::PipeFilter::Role::Transform::IpToUdp;

use Moose::Role;
use NetPacket::UDP;

sub transform {
	return(
		map {
			my $udp = NetPacket::UDP->decode(pack "H*", delete $_->{ip_data});

			# Not sure why the + is required, but it makes all the difference.
			+{
				%$_,
				udp_cksum     => $udp->{cksum},
				udp_data      => unpack("H*", $udp->{data}),
				udp_dest_port => $udp->{dest_port},
				udp_len       => $udp->{len},
				udp_src_port  => $udp->{src_port},
			};
		}
		# Skips $self in $_[0].
		@_[1..$#_]
	);
}

1;

__END__

# vim: ts=2 sw=2 expandtab
