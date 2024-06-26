use strict;
use warnings;
use WebService::GrowthBook::FeatureResult;
use Test::More;
subtest "boolean" => sub {
 my $test_cases = [[1,1,1,0],[0,0,0,1]];
    for my $case ($test_cases->@*){
        my $result = WebService::GrowthBook::FeatureResult->new(value => $case->[0]);
        is($result->value, $case->[1], "$case->[0] value is $case->[1]");
        is($result->on, $case->[2], "$case->[0] on is $case->[2]");
        is($result->off, $case->[3], "$case->[0] off is $case->[3]");
    }
};

subtest "number" => sub {
    my $test_cases = [[0,0],[1,1],[-1,-1],[0.5,0.5],[-0.5,-0.5]];
    for my $case ($test_cases->@*){
        my $result = WebService::GrowthBook::FeatureResult->new(value => $case->[0]);
        is($result->value, $case->[1], "$case->[0] value is $case->[1]");
    }
};

subtest "string" => sub {
    my $test_cases = [["hello","hello"],["Hi",'Hi'],["123","123"],['{"a":1, "b":2}', '{"a":1, "b":2}'],['true','true']];
    for my $case ($test_cases->@*){
        my $result = WebService::GrowthBook::FeatureResult->new(value => $case->[0]);
        is($result->value, $case->[1], "$case->[0] value is $case->[1]");
    }
};

subtest "data structure" => sub {
    my $test_cases = [[{"a" => 1, "b" => 2},{"a" => 1, "b" => 2}],[[1,2,3],[1,2,3]],[{"a" => [1,2,3]},{"a" => [1,2,3]}],[[{"a" => [123]}], [{"a" => [123]}]]];
    for my $case ($test_cases->@*){
        my $result = WebService::GrowthBook::FeatureResult->new(value => $case->[0]);
        is_deeply($result->value, $case->[1], "complex data structure test");
    }
};


done_testing();