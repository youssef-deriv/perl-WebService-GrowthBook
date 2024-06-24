package WebService::GrowthBook;
# ABSTRACT: ...

use strict;
use warnings;
use Object::Pad;

our $VERSION = '0.001';

=head1 NAME

WebService::GrowthBook - Module abstract

=head1 SYNOPSIS

    use WebService::GrowthBook;
    my $instance = WebService::GrowthBook->new;

=head1 DESCRIPTION

=cut

class WebService::GrowthBook {
    field $url: param;

    method load_features {
        return 1;
    }
}

=head1 METHODS

=cut

1;


=head1 SEE ALSO

=over 4

=item *

=back

