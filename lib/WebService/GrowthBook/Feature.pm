package WebService::GrowthBook::Feature;
use strict;
use warnings;
use Object::Pad;

class WebService::GrowthBook::Feature{
    field $id :param :reader;
    field $default_value :param :reader;
    field $value_type :param :reader;
}

1;
