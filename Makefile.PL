use 5.008;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

my $pm =   'lib/Text/Levenshtein/XS.pm';
my $repo = 'https://github.com/ugexe/Text--Levenshtein--XS';
my $bugs = 'https://github.com/ugexe/Text--Levenshtein--XS/issues';

WriteMakefile ( 
    NAME => 'Text::Levenshtein::XS',
    VERSION_FROM        => $pm,
    ABSTRACT_FROM       => $pm,
    AUTHOR              => 'Nick Logan <ugexe@cpan.org>',
    LICENSE             => 'perl',
    MIN_PERL_VERSION    => '5.008',
    depend              => { '$(FIRST_MAKEFILE)' => '$(VERSION_FROM)' },
    PREREQ_PM => {
    },
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 6.64, # For TEST_REQUIRES
    },
    TEST_REQUIRES => {
        'Test::More' => 0.98_01,
    },
    META_MERGE => {
        resources => {
            repository => $repo,
            bugtracker => "$bugs",
        },
    },
);



# Remove the Makefile dependency. Causes problems on a few systems.
sub MY::makefile { '' }



1;



__END__