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

The jpath filter supports more complex expressions using JSON::Path's
variant of JSONPath.

  % curl -s 'http://api.duckduckgo.com/?q=poe&o=json' |
  jpath -o '$..Topics.*.FirstURL' -o '$..Topics.*.Text' |
  grep -i perl |
  jmap -i col0 -o url -i col1 -o title |
  json2yaml
  --- 
  title: Perl Object Environment, a library for event driven multitasking for the Perl programming language
  url: http://duckduckgo.com/Perl_Object_Environment

=head1 DESIGN GOAL

Follow the UNIX convention of one record per line of text.  This
ensures App::PipeFilter tools are compatible with many standard UNIX
filters.  In the examples above, jcut and jpath output is piped
through sort(1), uniq(1) and grep(1).

=head1 PRO TIPS

JSON isn't particularly concise, so put grep(1) and other filters that
eliminate objects as early as possible in pipelines.

=head1 SEE ALSO

jcut - Extract one or more named fields from JSON input.

jmap - Rename one or more named fields from JSON input.

jpath - Like jcut, but fields are described using JSON::Path's
variant of JSONPath.

json2yaml - Convert JSON input records to YAML output records.  Some
people may find YAML output to be more readable.

jsort - Sort JSON input on one or more key fields.

myswl2json - Convert mysql(1) batch output (-B) into JSON records.

http://json.org/

http://search.cpan.org/perldoc?JSON::Path

http://goessner.net/articles/JsonPath/

=head1 COPYRIGHT and LICENSE

App::PipeFilter is Copyright 2011 by Rocco Caputo.  All rights are
reserved.  App::PipeFilter is released under the same terms as Perl
itself.

=cut

# vim: ts=2 sw=2 expandtab
