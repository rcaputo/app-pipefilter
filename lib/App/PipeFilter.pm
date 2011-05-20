=head1 NAME

App::PipeFilter

=head1 DESCRIPTION

App::PipeFilter is a distribution of shell pipeline filters that mimic
some of the standard UNIX tools but process structured data.

For example, jcut is a simple version of cut(1) that understands JSON
objects rather than whitespace separated fields.

  % head -1 sample.json
  {"network":"freenode","channel":"#perl","nick":"dngor","karma":"120"}

  % jcut -o network -o channel < eg/sample.json | sort | uniq
  {"network":"efnet","channel":"#perl"}
  {"network":"efnet","channel":"#poe"}
  {"network":"efnet","channel":"#reflex"}
  {"network":"freenode","channel":"#perl"}
  {"network":"freenode","channel":"#poe"}
  {"network":"freenode","channel":"#reflex"}
  {"network":"magnet","channel":"#perl"}
  {"network":"magnet","channel":"#poe"}
  {"network":"magnet","channel":"#reflex"}

=head1 DESIGN GOAL

Follow the UNIX convention of one record per line of text.  This
ensures App::PipeFilter tools are compatible with many standard UNIX
filters.  In the example above, jcut output is piped through sort(1)
and uniq(1) as one might expect.

=head1 SEE ALSO

jcut - Extract one or more named fields from JSON input.

jmap - Rename one or more named fields from JSON input.

json2yaml - Convert JSON input records to YAML output records.  Some
people may find YAML output to be more readable.

jsort - Sort JSON input on one or more key fields.

myswl2json - Convert mysql(1) batch output (-B) into JSON records.

=head1 COPYRIGHT and LICENSE

App::PipeFilter is Copyright 2011 by Rocco Caputo.  All rights are
reserved.  App::PipeFilter is released under the same terms as Perl
itself.

=cut

# vim: ts=2 sw=2 expandtab
