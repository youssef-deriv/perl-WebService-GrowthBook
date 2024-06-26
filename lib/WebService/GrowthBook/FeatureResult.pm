package WebService::GrowthBook::FeatureResult;
use strict;
use warnings;
no indirect;
use Object::Pad;

## VERSION

class WebService::GrowthBook::FeatureResult{
    field $value :param :reader;
    method on{
        return $value ? 1 : 0;
    }
    method off{
        return $value ? 0 : 1;
    }
}
