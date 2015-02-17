# colorize cpanm output
ruleset {
    rule qr{--> Working on (\S+)}, qw( 
        maintask module 
    );

    rule qr{(\S+) is up to date. \(([^)]+)\)}, qw( 
        uptodate module version 
    );

    rule qr{Fetching (\S+) \.\.\. (\S+)}, qw( 
        fetchtask url status 
    );

    rule qr{Configuring (\S+) \.\.\. (\S+)}, qw( 
        configtask release status 
    );

    rule qr{Building and testing (\S+) \.\.\. (\S+)}, qw( 
        buildtask release status 
    );
    
    rule qr{Successfully .*installed (\S+)(\s+\(upgraded from (.*)\))?}, qw( 
        success release success version
    );

    rule qr{==> Found dependencies: (.*)}, qw( 
        founddeps modulelist 
    );

    rule qr{(\d+) distributions? installed}, qw( 
        distsinstalled counter 
    );

    rule qr{!.*}, qw( error );
}
