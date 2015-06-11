# NAME

WebHook::Slack - Client for Incoming WebHooks of Slack.

# SYNOPSIS

    use WebHook::Slack;

    my $webhook_url = 'https://hooks.slack.com/services/foo/bar';
    my $slack       = WebHook::Slack->new($webhook_url);
    $slack->send('Hello World');

    my $ya_slack = WebHook::Slack->new(
        +{
            url        => $webhook_url,
            username   => 'obake',
            icon_emoji => ':ghost:'
        }
    );
    $ya_slack->send('Hi!');

# DESCRIPTION

WebHook::Slack is Client for Incoming WebHooks of Slack.

# SEE ALSO

https://api.slack.com/incoming-webhooks

# LICENSE

Copyright (C) nqounet.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

nqounet <mail@nqou.net>
