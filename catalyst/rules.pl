# colorize mr output
ruleset {
    my $Head = qr{[A-Z][a-z]+(?: [A-Z][a-z])*};

    rule qr{Watching (.*?) for file updates..*}, qw(
        message file
    );

    # Two columns
    rule qr{\|\s+($Head)\s+\|\s+($Head)\s+\|}, qw(
        border head head
    );

    # Three columns
    rule qr{\|\s+($Head)\s+\|\s+($Head)\s+\|\s+($Head)\s+\|}, qw(
        border head head head
    );

    # Action execution
    rule qr{\|\s+(->\s+)?(\S*)\s+\|\s+(\d\S+)\s+\|}, qw(
        border arrow url duration
    );

    # Action Map
    rule qr{\|\s+(/\S*)?\s+\|\s+([\w:-]+)\s+\|\s+(\S+)\s+\|}, qw(
        border url module_name method
    );

    # Action Map (continuation)
    rule qr{\|\s+(\S*)?\s+\|\s+([\w:-]+)\s+\|\s+\|}, qw(
        border url module_name method
    );

    # Path Spec
    rule qr{\|\s+(/\S*)?\s+\|\s+([-=]> )?(\S+)( \(\d+\))?\s+\|}, qw(
        border url arrow url args
    );

    # Parameters lists
    rule qr{\|\s+(\S*)\s+\|\s+(\S+)\s+\|}, qw(
        border arrow url duration
    );

    # Borders
    rule qr{[.+']-+(?:\+-+)+[.+']}, qw(
        border
    );

    my $cat_date = qr{\d{4}/\d{2}/\d{2} \d{2}:\d{2}:\d{2}};

    # Catalyst info log
    rule qr{\[($cat_date)\] \[(\w+)\] \[([\w.]+)\] \[(INFO)\] .*}, qw(
        message date app_name module_name log_info
    );
    rule qr{\[(info)\] .*}, qw(
        message log_info
    );

    # Catalyst debug log
    rule qr{\[($cat_date)\] \[(\w+)\] \[([\w.]+)\] \[(DEBUG)\] .*}, qw(
        message date app_name module_name log_debug
    );
    rule qr{\[(debug)\] .*}, qw(
        message log_debug
    );

    # Catalyst warning log
    rule qr{\[($cat_date)\] \[(\w+)\] \[([\w.]+)\] \[(WARN)\] .*}, qw(
        error_message date app_name module_name log_warn
    );
    rule qr{\[(warn)\] .*}, qw(
        error_message log_warn
    );

    # Catalyst error log
    rule qr{\[($cat_date)\] \[(\w+)\] \[([\w.]+)\] \[(ERROR)\] .*}, qw(
        error_message date app_name module_name log_error
    );
    rule qr{\[(error)\] .*}, qw(
        error_message log_error
    );

    # Server announcing it is ready
    rule qr{([\w:]+) Accepting connections at (.*)}, qw(
        message module_name url
    );

    # Port already in use
    my $date = qw{\d{4}/\d{2}/\d{2}.\d{2}:\d{2}:\d{2}};
    rule qr{($date) Can't connect .*}, qw(
        error_message date
    );

    # Bad fork
    rule qr{($date) Bad fork .*}, qw(
        crit_message date
    );

    # highlight (hopefully) useful stack trace lines
    rule qr{\s+(?!(?:Catalyst|Moose|Plack|Try|eval|Class|HTTP))([\w:]+.*?) called at (.*?) line (\d+)}, qw(
        at_message module_name file line
    );

    # stack trace line
    rule qr{\s+.*? at (.*?) line (\d+)}, qw(
        at_message file line
    );

    # at line in file
    rule qr{\s+at line (\d+) in file (.*)}, qw(
        at_message line file
    );

    # at file line #
    rule qr{\s+at (.*) line (\d+)}, qw(
        at_message file line
    );

    # Quitting
    rule qr{($date) Received QUIT.*}, qw(
        crit_message date
    );

    # Anything else with a date
    rule qr{($date).*}, qw(
        message date
    );

    my $ap_date = qr{\d+/\w+/\d{4}:\d{2}:\d{2}:\d{2} [-+]\d+};

    # Combined log (2xx response)
    rule qr{(::ffff:\d+\.\d+\.\d+\.\d+) \S+ \S+ \[($ap_date)\] "([^"]+)" (2\d+) \S+ "[^"]+".*}, qw(
        message ip_address date url ok_response
    );

    # Combined log (3xx response)
    rule qr{(::ffff:\d+\.\d+\.\d+\.\d+) \S+ \S+ \[($ap_date)\] "([^"]+)" (3\d+) \S+ "[^"]+".*}, qw(
        message ip_address date url redirect_response
    );

    # Combined log (not 2xx/3xx response)
    rule qr{(::ffff:\d+\.\d+\.\d+\.\d+) \S+ \S+ \[($ap_date)\] "([^"]+)" (\d+) \S+ "[^"]+".*}, qw(
        error_message ip_address date url not_ok_response
    );
}
