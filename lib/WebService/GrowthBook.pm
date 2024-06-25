package WebService::GrowthBook;
# ABSTRACT: ...

use strict;
use warnings;
use Object::Pad;
use WebService::GrowthBook::FeatureRepository;

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
    method set_features {
        my $features = shift;
    }
}

=head1 METHODS

=cut

1;


=head1 SEE ALSO

=over 4

=item *

=back

