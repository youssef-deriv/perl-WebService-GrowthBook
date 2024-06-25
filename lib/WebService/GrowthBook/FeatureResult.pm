use strict;
use warnings;
use Object::Pad;

class WebService::GrowthBook::FeatureResult{
    field $value :param :reader;
    method on{
        return $value ? 1 : 0;
    }
    method off{
        return $value ? 0 : 1;
    }
}
