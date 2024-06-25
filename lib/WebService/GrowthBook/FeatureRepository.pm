package WebService::GrowthBook::FeatureRepository;
use strict;
use warnings;
use Object::Pad;
use HTTP::Tiny;
use Log::Any qw($log);
use Syntax::Keyword::Try;
use JSON::MaybeXS;

class WebService::GrowthBook::FeatureRepository {
    field $http: param //= HTTP::Tiny->new();
    method load_features($api_host, $client_key) {
        # TODO add cache here
        my $features = _fetch_features($api_host, $client_key);
        return $features;
    }

    method _fetch_features($api_host, $client_key){
        my $decoded = _fetch_and_decode($api_host, $client_key);
        
        # TODO decrypt here
        if(exists $decoded->{features}){
            return $decoded->{features};
        }
        else {
            $log->warn("GrowthBook API response missing features");
            return
        }
    }    
    
    method _fetch_and_decode($api_host, $client_key){
        try {
            my $r = _get(_get_features_url($api_host, $client_key));
            if($r->{status} >= 400){
                $log->warn("Failed to fetch features, received status code %d", $r->{status});
                return;
            }
            my $decoded = decode_json_utf8($r->{content});
            return $decoded;
        }
        catch ($e){
            $log->warn("Failed to decode feature JSON from GrowthBook API: $e");
        }
        return;
    }
    method _get($url){
        return  $http->get($url);
    }

    method _get_features_url($api_host, $client_key){
        return "$api_host/features?client_key=$client_key";
    }
}

1;
