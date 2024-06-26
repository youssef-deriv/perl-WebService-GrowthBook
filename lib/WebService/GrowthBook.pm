package WebService::GrowthBook;
# ABSTRACT: ...

use strict;
use warnings;
no indirect;
use feature qw(state);
use Object::Pad;
use JSON::MaybeUTF8 qw(decode_json_text);
use Scalar::Util qw(blessed);
use WebService::GrowthBook::FeatureRepository;
use WebService::GrowthBook::Feature;
use WebService::GrowthBook::FeatureResult;

our $VERSION = '0.001';

=head1 NAME

WebService::GrowthBook - 

=head1 SYNOPSIS

    use WebService::GrowthBook;
    my $instance = WebService::GrowthBook->new;

=head1 DESCRIPTION

=cut

# singletons
my  $feature_repository = WebService::GrowthBook::FeatureRepository->new;
class WebService::GrowthBook {
    field $url: param //= 'https://api.growthbook.io/api/v1';
    field $client_key: param //= '';
    field $features: param //= {};

    method load_features {
        if(!$client_key) {
            die "Must specify 'client_key' to refresh features";
        }
        my $loaded_features = $feature_repository->load_features($url, $client_key);
        if($loaded_features){
            $self->set_features($loaded_features);
        }
        return 1;
    }
    method set_features($features_set) {
        $features = {};
        for my $feature ($features_set->@*) {
            if(blessed($feature) && $feature->isa('WebService::GrowthBook::Feature')){
                $features->{$feature->id} = $feature;
            }
            else {
                $features->{$feature->{id}} = WebService::GrowthBook::Feature->new(id => $feature->{id}, default_value => $feature->{defaultValue}, value_type => $feature->{valueType});
            }
        }
    }
    
    method is_on($feature_name) {
        # TODO how to do if no such feature name?
        return $self->eval_feature($feature_name)->on;
    }
    
    method is_off($feature_name) {
        # TODO how to do if no such feature name?
        return $self->eval_feature($feature_name)->off;
    }
    
    method eval_feature($feature_name){
        if(!exists($features->{$feature_name})){
            die "No such feature: $feature_name";
        }
        my $feature = $features->{$feature_name};
        my $default_value = $feature->default_value;
        if($feature->value_type eq 'json'){
            $default_value = decode_json_text($default_value);
        }
        elsif($feature->value_type eq 'number'){
            $default_value = 0 + $default_value;
        }
        elsif($feature->value_type eq 'boolean'){
            $default_value = $default_value eq 'true' ? 1 : 0;
        }
    
        return WebService::GrowthBook::FeatureResult->new(
            value => $default_value);
    }
    
    method get_feature_value($feature_name){
        return $self->eval_feature($feature_name)->value;
    }
}

=head1 METHODS

=cut

1;


=head1 SEE ALSO

=over 4

=item *

=back

