package WebService::GrowthBook::InMemoryFeatureCache;
use strict;
use warnings;
no indirect;
use Object::Pad;
use WebService::GrowthBook::CacheEntry;

class WebService::GrowthBook::InMemoryFeatureCache {
    field %cache;

    method get($key){
        my $entry = $cache{$key};
        return undef unless $entry;
        return $entry->value if !$entry->expired;
        return undef;
    }

    method set($key, $value, $ttl){
        if(exists $cache{$key}){
            $cache{$key}->update($value);
            return;
        }
        $cache{$key} = WebService::GrowthBook::CacheEntry->new(value => $value, ttl => $ttl);
    }

    method clear(){
        %cache = ();
    }
}