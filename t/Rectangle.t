use strict;
use warnings;
use Test::More;
use Test::Exception;
use Math::Trig ':pi';
use Math::Shape::Grid;

BEGIN { use_ok 'Math::Shape::Rectangle', 'module imports' };

# constructor
ok my $r = Math::Shape::Rectangle->new(1,1,0,2,2),   'create new rectangle';
dies_ok sub { Math::Shape::Rectangle->new(5,4,0,4)},    'dies on too few args';
dies_ok sub { Math::Shape::Rectangle->new(5,4,0,4,2,7)},'dies on too many args';

# get_points
is scalar keys %{ $r->get_points }, 4, '4 points returned';

# attributes
is $r->{centre}{x}, 1, 'centre x position is 1';
is $r->{centre}{y}, 1, 'centre y position is 1';
is $r->{centre}{r}, 0, 'centre r direction is 0';
is $r->{length},    2, 'rectangle is 2 long';
is $r->{width},     2, 'rectangle is 2 wide';
is $r->{tl}{x},     0, 'top-left corner x co';
is $r->{tl}{y},     2, 'top-left corner y co';
Math::Shape::Grid::print($r->get_points);

# rotate
ok $r->rotate(pi), 'rotate pi';
is $r->{centre}{r}, pi, 'centre is facing pi';
is $r->{tl}{x},     2, 'top-left corner x co';
is $r->{tl}{y},     0, 'top-left corner y co';
Math::Shape::Grid::print($r->get_points);

# rotate
ok $r->rotate(pip2), 'rotate pip2';
is $r->{centre}{r}, pi + pip2, 'centre is facing pi 1.5';
is $r->{tl}{x},     2, 'top-left corner x co';
is $r->{tl}{y},     2, 'top-left corner y co';
Math::Shape::Grid::print($r->get_points);

# rotate
ok $r->rotate(- pip2), 'rotate -pip2';
is $r->{centre}{r}, pi, 'centre is facing pi 1.5';
is $r->{tl}{x},     2, 'top-left corner x co';
is $r->{tl}{y},     0, 'top-left corner y co';
Math::Shape::Grid::print($r->get_points);

done_testing();

__END__
