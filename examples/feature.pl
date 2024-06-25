use strict;
use warnings;
use WebService::GrowthBook;
use WebService::GrowthBook::FeatureRepository;
use Log::Any::Adapter qw(Stdout);

my $key = $ENV{GROWTHBOOK_KEY};
my $gb = WebService::GrowthBook->new(client_key => $key);
$gb->load_features();
print $gb->is_on('bool-feature');