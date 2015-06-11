#!/usr/bin/env perl
use utf8;
use strict;
use warnings;


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
