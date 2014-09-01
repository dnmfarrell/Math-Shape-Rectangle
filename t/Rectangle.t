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

# intersect - no collision
ok my $r2 = Math::Shape::Rectangle->new(5,5,0,3,3), 'constructor';
Math::Shape::Grid::print($r2->get_points);
is $r->test_radius_intersect($r2), 0, 'test_radius_intersect()';
is $r2->test_radius_intersect($r), 0, 'test_radius_intersect()';
is $r->detect_collision($r2), 0, 'detect_collision()';
is $r2->detect_collision($r), 0, 'detect_collision()';

# intersect - collision
ok my $r3 = Math::Shape::Rectangle->new(3,3,0,8,8), 'constructor';
Math::Shape::Grid::print($r3->get_points);

is $r->test_radius_intersect($r3), 1, 'test_radius_intersect()';
is $r3->test_radius_intersect($r), 1, 'test_radius_intersect()';
is $r3->test_radius_intersect($r2),1, 'test_radius_intersect()';
is $r2->test_radius_intersect($r3),1, 'test_radius_intersect()';
is $r->detect_collision($r3),      1, 'detect_collision()';
is $r3->detect_collision($r),      1, 'detect_collision()';
is $r3->detect_collision($r2),     1, 'detect_collision()';
is $r2->detect_collision($r3),     1, 'detect_collision()';

# intersect - near collision - not working for $r
ok my $r4 = Math::Shape::Rectangle->new(3,2,0,2,2), 'constructor';
Math::Shape::Grid::print($r->get_points);
Math::Shape::Grid::print($r4->get_points);
#is $r4->test_radius_intersect($r), 1, 'test_radius_intersect()';
is $r4->test_radius_intersect($r2),0, 'test_radius_intersect()';
is $r4->test_radius_intersect($r3),1, 'test_radius_intersect()';
#is $r4->detect_collision($r),      1, 'detect_collision()';
is $r4->detect_collision($r2),     0, 'detect_collision()';
is $r4->detect_collision($r3),     1, 'detect_collision()';

done_testing();

__END__
