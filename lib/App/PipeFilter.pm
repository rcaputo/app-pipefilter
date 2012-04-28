package App::PipeFilter;

1;

=pod

=head1 NAME

App::PipeFilter

=head1 DESCRIPTION

App::PipeFilter is a distribution of shell pipeline filters designed
to work with structured data like JSON rather than whitespace
separated fields.

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

The jsonpath filter supports more complex expressions using
JSON::Path's variant of JSONPath.

  curl -s 'http://api.duckduckgo.com/?q=poe&o=json' |
  jsonpath -o '$..Topics.*.FirstURL' -o '$..Topics.*.Text' |
  grep -i perl |
  jmap -i col0 -o url -i col1 -o title |
  json2yaml
  --- 
  title: Perl Object Environment, a library for event driven multitasking for the Perl programming language
  url: http://duckduckgo.com/Perl_Object_Environment

=head1 DESIGN GOAL

App::PipeFilter utilities generally follow the UNIX convention of
printing one record per line of text.  This maximizes compatibility
with UNIX utilities like sort(1), uniq(1) and grep(1).

=head1 PRO TIPS

JSON isn't particularly concise, so put grep(1), jcut(1) and other
filters that eliminate data as early as possible in pipelines.

=head1 SEE ALSO

L<jcat> - concatenate and print JSON files

L<jcut> - cut out selected portions of each JSON object in a file

L<jmap> - map input JSON fields to output JSON fields by renaming them

L<json2yaml> - convert files of JSON objects into a stream of YAML objects

L<jsonpath> - use JSON::Path to cut out selected portions of JSON objects

L<jsort> - sort input files of JSON objects on key fields

L<mysql2json> - convert mysql -B output to JSON object streams

L<http://json.org/>

L<http://search.cpan.org/perldoc?JSON::Path>

L<http://goessner.net/articles/JsonPath/>

=head1 BUGS

L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-PipeFilter>

=head1 REPOSITORY

L<https://github.com/rcaputo/app-pipefilter>

=head1 COPYRIGHT and LICENSE

App::PipeFilter
is Copyright 2011 by Rocco Caputo.
All rights are reserved.
App::PipeFilter
is released under the same terms as Perl itself.

=cut

# vim: ts=2 sw=2 expandtab
