use strict;
use warnings;
use Test::More;
use Test::Fatal;

use WebHook::Slack;


subtest 'new' => sub {
    like exception { WebHook::Slack->new }, qr/required/, 'url is required';
    like exception { WebHook::Slack->new('') },                  qr/url/, 'isa url failed';
    is exception   { WebHook::Slack->new('http://slack.com') },  undef,   'http ok';
    is exception   { WebHook::Slack->new('https://slack.com') }, undef,   'https ok';
};

done_testing;
