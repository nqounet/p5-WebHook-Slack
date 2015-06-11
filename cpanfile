requires 'perl', '5.008001';
requires 'Moo';
requires 'HTTP::Tiny';
requires 'JSON::MaybeXS';

on 'test' => sub {
    requires 'Test::More', '0.98';
    requires 'Test::Fatal';
};
