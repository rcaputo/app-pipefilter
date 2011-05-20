package App::PipeFilter::Generic;

use Moose;
with 'App::PipeFilter::Role::Flags::Standard';

sub run {
  my $self = shift();

  my $ofh;
  if ($self->output() eq '-') {
    $ofh = \*STDOUT;
  }
  else {
    open $ofh, ">", $self->output() or die(
      "can't write ", $self->output(), ": $!"
    );
  }

  # TODO - Pass input and output around in chunks to reduce method
  # call overhead.

  while (defined (my $input_filename = $self->next_input_file())) {
    my $ifh;
    if ($input_filename eq '-') {
      warn "reading from standard input\n" if $self->verbose();
      $ifh = \*STDIN;
    }
    else {
      open $ifh, "<", $input_filename or die "can't open $input_filename: $!";
      warn "reading from $input_filename\n" if $self->verbose();
    }

    $self->file_start($ifh, $ofh);

    while (<$ifh>) {
      next unless defined(my $input = $self->decode_input($_));
      next unless my (@output) = $self->transform($input);
      print $ofh $_ foreach $self->encode_output(@output);
    }

    $self->file_end($ofh);
  }

  # Exit value.
  0;
}

# Do nothing in particular before and after each file.
#
# TODO - Refactor the code to process a single file into its own
# method.  Replace file_start() with "before", and file_end() with
# "after".

sub file_start { undef }

sub file_end { undef }

1;

# vim: ts=2 sw=2 expandtab
