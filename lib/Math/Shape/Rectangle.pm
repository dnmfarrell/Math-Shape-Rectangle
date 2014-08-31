use strict;
use warnings;
package Math::Shape::Rectangle;
use Math::Shape::Point;
# ABSTRACT: a 2d rectangle in cartesian space

sub new {
    my ($class, $length, $width) = @_;
    my $self = { length => $length,
                 width  => $width };
    bless $self, $class;
}

1;
