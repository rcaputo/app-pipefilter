package App::PipeFilter::Role::Input::ArrayBuffer;

use Moose::Role;

sub decode_input {
  my ($self, $buffer_ref) = @_;

	my @return = @$$buffer_ref;
	$$buffer_ref = "";

	return @return;
}

no Moose::Role;
1;

__END__

# vim: ts=2 sw=2 expandtab
