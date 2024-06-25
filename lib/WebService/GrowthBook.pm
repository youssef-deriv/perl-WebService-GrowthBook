package WebService::GrowthBook;
# ABSTRACT: ...

use strict;
use warnings;
use Object::Pad;
use WebService::GrowthBook::FeatureRepository;
use WebService::GrowthBook::Features;

our $VERSION = '0.001';

=head1 NAME

WebService::GrowthBook - Module abstract

=head1 SYNOPSIS

    use WebService::GrowthBook;
    my $instance = WebService::GrowthBook->new;

=head1 DESCRIPTION

=cut

# singletons
my $feature_repository = WebService::GrowthBook::FeatureRepository->new;
class WebService::GrowthBook {
    field $url: param //= '';
    field $client_key: param //= '';
    field $features: param //= {};
    method load_features {
        if(!$client_key) {
            die "Must specify 'client_key' to refresh features";
        }
        my $loaded_features = $feature_repository->load_features($url, $client_key);
        if($loaded_features){
            set_features($loaded_features);
        }
        return 1;
    }
    method set_features($features_set) {
        $features = {};
        for (my ($key, $feature) = each $features_set->%*) {
            if($feature->isa('WebService::GrowthBook::Feature')){
                $features->{$key} = $feature;
            }
            else {
                $features->{$key} = WebService::GrowthBook::Feature->new(default_value => $feature->{default_value});
            }
    }
    
    method is_on($feature_name) {
        # TODO how to do if no such feature name?
        return eval_feature($feature_name)->is_on;
    }
    
    method is_off($feature_name) {
        # TODO how to do if no such feature name?
        return eval_feature($feature_name)->is_off;
    }
    
    method eval_future($feature_name){
        return WebService::GrowthBook::FeatureResult(
            value => $features->{$feature_name}->default_value);
    }
    # TODO get_feature_value
}

=head1 METHODS

=cut

1;


=head1 SEE ALSO

=over 4

=item *

=back

