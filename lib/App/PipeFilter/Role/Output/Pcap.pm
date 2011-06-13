package App::PipeFilter::Role::Output::Pcap;

use Moose::Role;

use Net::Pcap qw(pcap_dump);

sub encode_output {
  # Skips $self in $_[0].

  return(
    map {
      my $pcap_rec = $_;
      my $packet   = pack "H*", delete $pcap_rec->{pcap_data};

      +[
        {
          map { /^pcap_(\S+)/ ? ($1 => $pcap_rec->{$_}) : () }
          keys %$pcap_rec
        },
        $packet
      ];
    }
    @_[2..$#_]
  );
}

1;

__END__

# vim: ts=2 sw=2 expandtab
