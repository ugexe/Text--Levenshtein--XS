#!perl -T
use 5.008;
use strict;
use warnings FATAL => 'all';
use Test::More;
use Test::LeakTrace;
use Text::Levenshtein::XS qw/distance/;

no_leaks_ok(sub { distance('aaa' x $_, 'ax' x $_) for 1..1000 }, 'no memory leaks in distance');



done_testing();
1;



__END__