use strict;
use warnings;
use Test::More;
use Test::Exception;
use Test::MockModule;
use WebService::GrowthBook;

my $instance = WebService::GrowthBook->new;
throws_ok { $instance->load_features } qr/Must specify 'client_key' to refresh features/;
my $mock = Test::MockModule->new('HTTP::Tiny');
my $get_result;
$mock->mock(
    'get',
    sub {
        return $get_result;
    }
);

$get_result = {
    status  => 200,
    content =>
    '{"features":[{"id":"bool-feature","description":"","archived":false,"dateCreated":"2024-06-25T09:11:17.705Z","dateUpdated":"2024-06-25T09:11:17.705Z","defaultValue":"true","environments":{"production":{"enabled":true,"defaultValue":"true","rules":[],"definition":"{\"defaultValue\":true,\"project\":\"\"}"}},"owner":"Chylli","project":"","tags":[],"valueType":"boolean","revision":{"comment":"","date":"2024-06-25T09:11:17.705Z","publishedBy":"","version":1}},{"id":"string-feature","description":"","archived":false,"dateCreated":"2024-06-25T09:12:03.806Z","dateUpdated":"2024-06-25T09:12:03.806Z","defaultValue":"OFF","environments":{"production":{"enabled":true,"defaultValue":"OFF","rules":[],"definition":"{\"defaultValue\":\"OFF\",\"project\":\"\"}"}},"owner":"Chylli","project":"","tags":[],"valueType":"string","revision":{"comment":"","date":"2024-06-25T09:12:03.806Z","publishedBy":"","version":1}},{"id":"number-feature","description":"","archived":false,"dateCreated":"2024-06-25T09:12:34.817Z","dateUpdated":"2024-06-25T09:12:34.817Z","defaultValue":"123","environments":{"production":{"enabled":true,"defaultValue":"123","rules":[],"definition":"{\"defaultValue\":123,\"project\":\"\"}"}},"owner":"Chylli","project":"","tags":[],"valueType":"number","revision":{"comment":"","date":"2024-06-25T09:12:34.817Z","publishedBy":"","version":1}},{"id":"json-feature","description":"","archived":false,"dateCreated":"2024-06-25T09:13:11.201Z","dateUpdated":"2024-06-25T09:13:11.201Z","defaultValue":"{\n  \"a\": 1,\n  \"b\": 2\n}","environments":{"production":{"enabled":true,"defaultValue":"{\n  \"a\": 1,\n  \"b\": 2\n}","rules":[],"definition":"{\"defaultValue\":{\"a\":1,\"b\":2},\"project\":\"\"}"}},"owner":"Chylli","project":"","tags":[],"valueType":"json","revision":{"comment":"","date":"2024-06-25T09:13:11.201Z","publishedBy":"","version":1}}],"limit":10,"offset":0,"count":4,"total":4,"hasMore":false,"nextOffset":null}'
};

$instance = WebService::GrowthBook->new(client_key => 'key');
$instance->load_features;
ok($instance->is_on('bool-feature'), 'bool-feature is on');
ok(!$instance->is_off('bool-feature'), 'bool-feature is on');
is($instance->get_feature_value('bool-feature'), 1, 'bool-feature value is 1');
is($instance->get_feature_value('string-feature'), 'OFF', 'string-feature value is OFF');
is($instance->get_feature_value('number-feature'), 123, 'number-feature value is 123');
is_deeply($instance->get_feature_value('json-feature'), {"a" => 1,"b" => 2}, 'json-feature value is {"a":1,"b":2}');
done_testing();