use strict;
use warnings;
use Test::More;
use Log::Any::Test;
use Log::Any qw($log);
use WebService::GrowthBook::FeatureResult;

subtest "boolean" => sub {
 my $test_cases = [[1,1,1,0],[0,0,0,1]];
    for my $case ($test_cases->@*){
        my $result = WebService::GrowthBook::FeatureResult->new(id => 'test', type => 'boolean',value => $case->[0]);
        is($result->value, $case->[1], "$case->[0] value is $case->[1]");
        is($result->on, $case->[2], "$case->[0] on is $case->[2]");
        is($result->off, $case->[3], "$case->[0] off is $case->[3]");
    }
};

subtest "number" => sub {
    my $test_cases = [[0,0],[1,1],[-1,-1],[0.5,0.5],[-0.5,-0.5]];
    for my $case ($test_cases->@*){
        my $result = WebService::GrowthBook::FeatureResult->new(id => 'test', type => 'number',value => $case->[0]);
        is($result->value, $case->[1], "$case->[0] value is $case->[1]");
    }
};

subtest "string" => sub {
    my $test_cases = [["hello","hello"],["Hi",'Hi'],["123","123"],['{"a":1, "b":2}', '{"a":1, "b":2}'],['true','true']];
    for my $case ($test_cases->@*){
        my $result = WebService::GrowthBook::FeatureResult->new(id => 'test', type => 'string', value => $case->[0]);
        is($result->value, $case->[1], "$case->[0] value is $case->[1]");
    }
};

subtest "data structure" => sub {
    my $test_cases = [[{"a" => 1, "b" => 2},{"a" => 1, "b" => 2}],[[1,2,3],[1,2,3]],[{"a" => [1,2,3]},{"a" => [1,2,3]}],[[{"a" => [123]}], [{"a" => [123]}]]];
    for my $case ($test_cases->@*){
        my $result = WebService::GrowthBook::FeatureResult->new(id => 'test', type => 'json', value => $case->[0]);
        is_deeply($result->value, $case->[1], "complex data structure test");
    }
};

subtest "call on/off on non-boolean" => sub {
    my $result = WebService::GrowthBook::FeatureResult->new(id => 'test', type => 'number', value => 1);
    $log->clear;
    is($result->on, undef, "on called on non-boolean");
    $log->contains_ok(qr/FeatureResult->on called on non-boolean feature test/, "log on non-boolean");
    $log->clear;
    is($result->off, undef, "off called on non-boolean");
    $log->contains_ok(qr/FeatureResult->off called on non-boolean feature test/, "log off non-boolean");
};

done_testing();