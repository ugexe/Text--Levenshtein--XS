#!perl -T
use 5.008;
use strict;
use warnings FATAL => 'all';
use Test::More;
use Text::Levenshtein::XS qw/distance/;

plan skip_all => "Test::LeakTrace does not work with Devel::Cover" if exists($INC{'Devel/Cover.pm'});

eval "use Test::LeakTrace";
plan skip_all => "Test::LeakTrace required to test for memory leaks" if $@;

no_leaks_ok(sub { distance('aaaa' x $_, 'ax' x $_) for 1..1000 }, 'no memory leaks in distance');



done_testing();
1;



__END__