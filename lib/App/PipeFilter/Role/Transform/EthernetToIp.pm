package App::PipeFilter::Role::Transform::EthernetToIp;

use Moose::Role;
use NetPacket::IP;

sub transform {
	return(
		map {
			my $ip = NetPacket::IP->decode(pack "H*", delete $_->{eth_data});

			# Not sure why the + is required, but it makes all the difference.
			+{
				%$_,
				ip_len     => $ip->{len},
				ip_dest_ip => $ip->{dest_ip},
				ip_options => $ip->{options},
				ip_ttl     => $ip->{ttl},
				ip_src_ip  => $ip->{src_ip},
				ip_tos     => $ip->{tos},
				ip_id      => $ip->{id},
				ip_hlen    => $ip->{hlen},
				ip_proto   => $ip->{proto},
				ip_foffset => $ip->{foffset},
				ip_flags   => $ip->{flags},
				ip_ver     => $ip->{ver},
				ip_cksum   => $ip->{cksum},
				ip_data    => unpack("H*", $ip->{data}),
			};
		}
		# Skips $self in $_[0].
		@_[1..$#_]
	);
}

1;

__END__

# vim: ts=2 sw=2 expandtab
