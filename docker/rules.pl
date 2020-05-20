# colorize docker output
ruleset {
  rule qr{ ---> ([a-f0-9]+)}, qw(
    hashtask hashid
  );

  rule qr{Step (\d+)/(\d+) : (\S+) (.*)}, qw(
    steptask stepnum stepden command arguments
  );

  rule qr{invalid .*}, qw( error );
}
