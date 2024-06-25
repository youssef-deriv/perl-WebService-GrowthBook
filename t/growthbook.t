use strict;
use warnings;
use Test::More;
use Test::Exception;
use WebService::GrowthBook;

my $instance = WebService::GrowthBook->new;
throws_ok { $instance->load_features } qr/Must specify 'client_key' to refresh features/;

done_testing();