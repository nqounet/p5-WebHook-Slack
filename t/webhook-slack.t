use strict;
use warnings;
use Test::More;
use Test::Fatal;

use WebHook::Slack;


subtest 'public `new`' => sub {
    like exception { WebHook::Slack->new }, qr/required/, 'url is required';
    like exception { WebHook::Slack->new('') },                  qr/url/, 'isa url failed';
    is exception   { WebHook::Slack->new('http://slack.com') },  undef,   'http ok';
    is exception   { WebHook::Slack->new('https://slack.com') }, undef,   'https ok';
};

subtest 'private `_build_params` on url only' => sub {
    my $hook   = WebHook::Slack->new('http://localhost/');
    my $params = $hook->_build_params('foo');
    ok exists $params->{text}, 'exists text';
    is $params->{text}, 'foo', 'text is foo';
    ok !exists $params->{channel},    'not exists channel';
    ok !exists $params->{username},   'not exists username';
    ok !exists $params->{icon_url},   'not exists icon_url';
    ok !exists $params->{icon_emoji}, 'not exists icon_emoji';
};

subtest 'private `_build_params`' => sub {
    my $hook = WebHook::Slack->new(
        +{
            url        => 'http://localhost/',
            channel    => 'channel',
            username   => 'username',
            icon_url   => 'icon_url',
            icon_emoji => 'icon_emoji'
        }
    );
    my $params = $hook->_build_params('foo');
    ok exists $params->{text}, 'exists text';
    is $params->{text}, 'foo', 'text is foo';
    ok exists $params->{channel},    'exists channel';
    ok exists $params->{username},   'exists username';
    ok exists $params->{icon_url},   'exists icon_url';
    ok exists $params->{icon_emoji}, 'exists icon_emoji';
    is $params->{channel},    'channel',    'channel ok';
    is $params->{username},   'username',   'username ok';
    is $params->{icon_url},   'icon_url',   'icon_url ok';
    is $params->{icon_emoji}, 'icon_emoji', 'icon_emoji ok';
};

subtest 'private `_build_form`' => sub {
    my $hook      = WebHook::Slack->new('http://localhost/');
    my $params    = $hook->_build_params('foo');
    my $payload   = $hook->_build_form($params);
    my $json_text = $payload->{payload};
    ok $json_text, 'exists payload';
};

done_testing;
