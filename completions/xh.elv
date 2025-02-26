
use builtin;
use str;

set edit:completion:arg-completer[xh] = {|@words|
    fn spaces {|n|
        builtin:repeat $n ' ' | str:join ''
    }
    fn cand {|text desc|
        edit:complex-candidate $text &display=$text' '(spaces (- 14 (wcswidth $text)))$desc
    }
    var command = 'xh'
    for word $words[1..-1] {
        if (str:has-prefix $word '-') {
            break
        }
        set command = $command';'$word
    }
    var completions = [
        &'xh'= {
            cand --raw 'Pass raw request data without extra processing'
            cand --pretty 'Controls output processing'
            cand --format-options 'Set output formatting options'
            cand -s 'Output coloring style'
            cand --style 'Output coloring style'
            cand --response-charset 'Override the response encoding for terminal display purposes'
            cand --response-mime 'Override the response mime type for coloring and formatting for the terminal'
            cand -p 'String specifying what the output should contain'
            cand --print 'String specifying what the output should contain'
            cand -P 'The same as --print but applies only to intermediary requests/responses'
            cand --history-print 'The same as --print but applies only to intermediary requests/responses'
            cand -o 'Save output to FILE instead of stdout'
            cand --output 'Save output to FILE instead of stdout'
            cand --session 'Create, or reuse and update a session'
            cand --session-read-only 'Create or read a session without updating it form the request/response exchange'
            cand -A 'Specify the auth mechanism'
            cand --auth-type 'Specify the auth mechanism'
            cand -a 'Authenticate as USER with PASS (-A basic|digest) or with TOKEN (-A bearer)'
            cand --auth 'Authenticate as USER with PASS (-A basic|digest) or with TOKEN (-A bearer)'
            cand --bearer 'Authenticate with a bearer token'
            cand --max-redirects 'Number of redirects to follow. Only respected if --follow is used'
            cand --timeout 'Connection timeout of the request'
            cand --proxy 'Use a proxy for a protocol. For example: --proxy https:http://proxy.host:8080'
            cand --verify 'If "no", skip SSL verification. If a file path, use it as a CA bundle'
            cand --cert 'Use a client side certificate for SSL'
            cand --cert-key 'A private key file to use with --cert'
            cand --ssl 'Force a particular TLS version'
            cand --default-scheme 'The default scheme to use if not specified in the URL'
            cand --http-version 'HTTP version to use'
            cand --resolve 'Override DNS resolution for specific domain to a custom IP'
            cand --interface 'Bind to a network interface or local IP address'
            cand --generate 'Generate shell completions or man pages'
            cand -j '(default) Serialize data items from the command line as a JSON object'
            cand --json '(default) Serialize data items from the command line as a JSON object'
            cand -f 'Serialize data items from the command line as form fields'
            cand --form 'Serialize data items from the command line as form fields'
            cand --multipart 'Like --form, but force a multipart/form-data request even without files'
            cand -h 'Print only the response headers. Shortcut for --print=h'
            cand --headers 'Print only the response headers. Shortcut for --print=h'
            cand -b 'Print only the response body. Shortcut for --print=b'
            cand --body 'Print only the response body. Shortcut for --print=b'
            cand -m 'Print only the response metadata. Shortcut for --print=m'
            cand --meta 'Print only the response metadata. Shortcut for --print=m'
            cand -v 'Print the whole request as well as the response'
            cand --verbose 'Print the whole request as well as the response'
            cand --debug 'Print full error stack traces and debug log messages'
            cand --all 'Show any intermediary requests/responses while following redirects with --follow'
            cand -q 'Do not print to stdout or stderr'
            cand --quiet 'Do not print to stdout or stderr'
            cand -S 'Always stream the response body'
            cand --stream 'Always stream the response body'
            cand -x 'Content compressed (encoded) with Deflate algorithm'
            cand --compress 'Content compressed (encoded) with Deflate algorithm'
            cand -d 'Download the body to a file instead of printing it'
            cand --download 'Download the body to a file instead of printing it'
            cand -c 'Resume an interrupted download. Requires --download and --output'
            cand --continue 'Resume an interrupted download. Requires --download and --output'
            cand --ignore-netrc 'Do not use credentials from .netrc'
            cand --offline 'Construct HTTP requests without sending them anywhere'
            cand --check-status '(default) Exit with an error status code if the server replies with an error'
            cand -F 'Do follow redirects'
            cand --follow 'Do follow redirects'
            cand --native-tls 'Use the system TLS library instead of rustls (if enabled at compile time)'
            cand --https 'Make HTTPS requests if not specified in the URL'
            cand -4 'Resolve hostname to ipv4 addresses only'
            cand --ipv4 'Resolve hostname to ipv4 addresses only'
            cand -6 'Resolve hostname to ipv6 addresses only'
            cand --ipv6 'Resolve hostname to ipv6 addresses only'
            cand -I 'Do not attempt to read stdin'
            cand --ignore-stdin 'Do not attempt to read stdin'
            cand --curl 'Print a translation to a curl command'
            cand --curl-long 'Use the long versions of curl''s flags'
            cand --help 'Print help'
            cand --no-json 'no-json'
            cand --no-form 'no-form'
            cand --no-multipart 'no-multipart'
            cand --no-raw 'no-raw'
            cand --no-pretty 'no-pretty'
            cand --no-format-options 'no-format-options'
            cand --no-style 'no-style'
            cand --no-response-charset 'no-response-charset'
            cand --no-response-mime 'no-response-mime'
            cand --no-print 'no-print'
            cand --no-headers 'no-headers'
            cand --no-body 'no-body'
            cand --no-meta 'no-meta'
            cand --no-verbose 'no-verbose'
            cand --no-debug 'no-debug'
            cand --no-all 'no-all'
            cand --no-history-print 'no-history-print'
            cand --no-quiet 'no-quiet'
            cand --no-stream 'no-stream'
            cand --no-compress 'no-compress'
            cand --no-output 'no-output'
            cand --no-download 'no-download'
            cand --no-continue 'no-continue'
            cand --no-session 'no-session'
            cand --no-session-read-only 'no-session-read-only'
            cand --no-auth-type 'no-auth-type'
            cand --no-auth 'no-auth'
            cand --no-bearer 'no-bearer'
            cand --no-ignore-netrc 'no-ignore-netrc'
            cand --no-offline 'no-offline'
            cand --no-check-status 'no-check-status'
            cand --no-follow 'no-follow'
            cand --no-max-redirects 'no-max-redirects'
            cand --no-timeout 'no-timeout'
            cand --no-proxy 'no-proxy'
            cand --no-verify 'no-verify'
            cand --no-cert 'no-cert'
            cand --no-cert-key 'no-cert-key'
            cand --no-ssl 'no-ssl'
            cand --no-native-tls 'no-native-tls'
            cand --no-default-scheme 'no-default-scheme'
            cand --no-https 'no-https'
            cand --no-http-version 'no-http-version'
            cand --no-resolve 'no-resolve'
            cand --no-interface 'no-interface'
            cand --no-ipv4 'no-ipv4'
            cand --no-ipv6 'no-ipv6'
            cand --no-ignore-stdin 'no-ignore-stdin'
            cand --no-curl 'no-curl'
            cand --no-curl-long 'no-curl-long'
            cand --no-generate 'no-generate'
            cand --no-help 'no-help'
            cand -V 'Print version'
            cand --version 'Print version'
        }
    ]
    $completions[$command]
}
