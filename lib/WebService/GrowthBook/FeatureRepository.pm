package WebService::GrowthBook::FeatureRepository;
use strict;
use warnings;
use Object::Pad;

class WebService::GrowthBook::FeatureRepository {

    method load_features($url, $client_key) {
        my $features = $self->fetch_features($url, $client_key);
        return $features;
    }

}

1;
