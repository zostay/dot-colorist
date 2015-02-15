ruleset {
    rule qr{diff .*}, qw( message );
    rule qr{index .*}, qw( message );
    rule qr{deleted .*}, qw( message );
    rule qr{--- .*}, qw( message );
    rule qr{\+\+\+ .*}, qw( message );

    rule qr{@@ .*}, qw( position );

    rule qr{-.*}, qw( delete );
    rule qr{\+.*}, qw( add );
}
