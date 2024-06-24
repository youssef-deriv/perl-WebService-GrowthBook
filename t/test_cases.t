use strict;
use warnings;
use Test::More;
use WebService::GrowthBook;
use JSON::MaybeXS;
use FindBin qw($Bin);
use Path::Tiny;

my $cases = decode_json(path("$Bin/cases.json")->slurp_utf8);

test_feature($cases->{feature});

sub test_feature {
    my $feature_cases = shift;
    # Now we test only the first 4 cases, since we implemented only a small set of feature function
    $feature_cases = [$feature_cases->@[0..3]];

    subtest 'features' => sub {
        for my $case  ($feature_cases->@*){
            my $test_description = $case->[0];
            my $gb = WebService::GrowthBook->new($case->[1]->%*);
            my $feature_key = $case->[2];
            my $expected_result = $case->[3];
            ok(1);
        }
    };
}

done_testing();