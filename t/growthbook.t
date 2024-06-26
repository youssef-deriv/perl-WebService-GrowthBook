use strict;
use warnings;
use Test::More;
use Test::Exception;
use Test::MockModule;
use WebService::GrowthBook;
use Path::Tiny;
use FindBin qw($Bin);

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
    content => path("$Bin/test_data_growthbook.json")->slurp;
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