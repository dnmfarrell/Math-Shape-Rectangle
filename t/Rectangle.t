use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Math::Shape::Rectangle', 'module imports' };

ok my $rect = Math::Shape::Rectangle->new(4,2), 'create new rectangle';

done_testing();
