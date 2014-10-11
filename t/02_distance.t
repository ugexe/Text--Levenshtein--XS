#!perl -T
use 5.008;
use strict;
use warnings FATAL => 'all';
use Test::More;
use Text::Levenshtein::XS qw/distance/;

subtest 'distance' => sub { 
    is( distance('four','for'),             1, 'test distance insertion');
    is( distance('four','four'),            0, 'test distance matching');
    is( distance('four','fourth'),          2, 'test distance deletion');
    is( distance('four','fuor'),            2, 'test distance (no) transposition');
    is( distance('four','fxxr'),            2, 'test distance substitution');
    is( distance('four','FOuR'),            3, 'test distance case');
    is( distance('four',''),                4, 'test distance target empty');
    is( distance('','four'),                4, 'test distance source empty');
    is( distance('',''),                    0, 'test distance source and target empty');
    is( distance('111','11'),               1, 'test distance numbers');
};

subtest 'utf8' => sub {
    use utf8;
    binmode STDOUT, ":encoding(utf8)";
    is( distance('ⓕⓞⓤⓡ','ⓕⓞⓤⓡ'),            0, 'test distance matching');
    is( distance('ⓕⓞⓤⓡ','ⓕⓞⓡ'),             1, 'test distance insertion');
    is( distance('ⓕⓞⓤⓡ','ⓕⓞⓤⓡⓣⓗ'),          2, 'test distance deletion');
    is( distance('ⓕⓞⓤⓡ','ⓕⓤⓞⓡ'),            2, 'test distance (no) transposition');
    is( distance('ⓕⓞⓤⓡ','ⓕⓧⓧⓡ'),            2, 'test distance substitution');
};

subtest 'Text::LevenshteinXS compatability' => sub {
    is( distance("foo","four"),             2,"Correct distance foo four");
    is( distance("foo","foo"),              0,"Correct distance foo foo");
    is( distance("cow","cat"),              2,"Correct distance cow cat");
    is( distance("cat","moocow"),           5,"Correct distance cat moocow");
    is( distance("cat","cowmoo"),           5,"Correct distance cat cowmoo");
    is( distance("sebastian","sebastien"),  1,"Correct distance sebastian sebastien");
    is( distance("more","cowbell"),         5,"Correct distance more cowbell");
};

# Not quite supported yet
#my @foo = distance("foo","four","foo","bar");
#my @bar = (2,0,3);
#is_deeply(\@foo,\@bar,"Array test: Correct distances foo four foo bar");



done_testing();
1;



__END__