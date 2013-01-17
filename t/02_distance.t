use strict;
use warnings;
use Test::More tests => 22;
use Text::Levenshtein::XS qw/distance/;

is( distance('four','for'), 		1, 'test distance insertion');
is( distance('four','four'), 		0, 'test distance matching');
is( distance('four','fourth'), 		2, 'test distance deletion');
is( distance('four','fuor'), 		2, 'test distance (no) transposition');
is( distance('four','fxxr'), 		2, 'test distance substitution');
is( distance('four','FOuR'), 		3, 'test distance case');
is( distance('four',''), 			4, 'test distance target empty');
is( distance('','four'), 			4, 'test distance source empty');
is( distance('',''), 			0, 'test distance source and target empty');
is( distance('111','11'), 			1, 'test distance numbers');

# Test some utf8
use utf8;
binmode STDOUT, ":encoding(utf8)";
is( distance('ⓕⓞⓤⓡ','ⓕⓞⓤⓡ'), 		0, 'test distance matching (utf8)');
is( distance('ⓕⓞⓤⓡ','ⓕⓞⓡ'), 		1, 'test distance insertion (utf8)');
is( distance('ⓕⓞⓤⓡ','ⓕⓞⓤⓡⓣⓗ'), 		2, 'test distance deletion (utf8)');
is( distance('ⓕⓞⓤⓡ','ⓕⓤⓞⓡ'), 		2, 'test distance (no) transposition (utf8)');
is( distance('ⓕⓞⓤⓡ','ⓕⓧⓧⓡ'), 		2, 'test distance substitution (utf8)');

# Test Text::LevenshteinXS's tests for compatability
is_deeply(distance("foo","four"),2,"Correct distance foo four");
is_deeply(distance("foo","foo"),0,"Correct distance foo foo");
is_deeply(distance("cow","cat"),2,"Correct distance cow cat");
is_deeply(distance("cat","moocow"),5,"Correct distance cat moocow");
is_deeply(distance("cat","cowmoo"),5,"Correct distance cat cowmoo");
is_deeply(distance("sebastian","sebastien"),1,"Correct distance sebastian sebastien");
is_deeply(distance("more","cowbell"),5,"Correct distance more cowbell");

# Not quite supported yet
#my @foo = distance("foo","four","foo","bar");
#my @bar = (2,0,3);
#is_deeply(\@foo,\@bar,"Array test: Correct distances foo four foo bar");
