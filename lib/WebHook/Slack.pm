package WebHook::Slack;
use Moo;
use HTTP::Tiny;
use JSON::MaybeXS qw(JSON);
use version; our $VERSION = version->declare("v0.1.0");


has [qw(url)] => (
    is       => 'ro',
    isa      => sub { $_[0] =~ m|\Ahttps?://| or die 'URL should begin at `http` or `https`.' },
    required => 1
);

my @extras = qw(channel username icon_url icon_emoji);
has [@extras] => (is => 'rw');

has json => (
    is      => 'ro',
    default => sub { JSON->new }
);

has client => (
    is      => 'ro',
    default => sub { HTTP::Tiny->new }
);

sub BUILDARGS {
    my ($class, @args) = @_;
    return $args[0] if ref $args[0] eq 'HASH';
    unshift @args, 'url' if @args % 2 == 1;
    return {@args};
}

sub send {
    my $self   = shift;
    my $text   = shift;
    my $params = $self->_build_params($text);
    my $form   = $self->_build_form($params);
    return $self->client->post_form($self->url, $form);
}

sub _build_params {
    my $self   = shift;
    my $text   = shift;
    my $params = +{text => $text};
    for my $key (@extras) {
        $params->{$key} = $self->$key if defined $self->$key;
    }
    return $params;
}

sub _build_form {
    my $self    = shift;
    my $params  = shift;
    my $payload = $self->json->encode($params);
    my $form    = +{payload => $payload};
    return $form;
}

1;
__END__

=encoding utf-8

=head1 NAME

WebHook::Slack - Client for Incoming WebHooks of Slack.

=head1 SYNOPSIS

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

=head1 DESCRIPTION

WebHook::Slack is Client for Incoming WebHooks of Slack.

=head1 SEE ALSO

https://api.slack.com/incoming-webhooks

=head1 LICENSE

Copyright (C) nqounet.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

nqounet E<lt>mail@nqou.netE<gt>

=cut
