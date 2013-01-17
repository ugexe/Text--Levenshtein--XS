use 5.008_008;
use strict;
use warnings;
use ExtUtils::MakeMaker;

my $pm =   'lib/Text/Levenshtein/XS.pm';
my $repo = 'https://github.com/ugexe/Text--Levenshtein--XS';
my $bugs = 'https://rt.cpan.org/Public/Dist/Display.html?Name=Text-Levenshtein-XS';

WriteMakefile ( 
    NAME => 'Text::Levenshtein::XS',
    VERSION_FROM => $pm,
    ABSTRACT_FROM => $pm,
    AUTHOR => 'Nick Logan <ugexe@cpan.org>',
    LICENSE => 'perl',
    MIN_PERL_VERSION => '5.008008',
    PREREQ_PM => {
    },
    META_MERGE => {
        resources => {
            repository => $repo,
            bugtracker => "$bugs",
        },
    },
    depend => { '$(FIRST_MAKEFILE)' => '$(VERSION_FROM)' },
);



# Remove the Makefile dependency. Causes problems on a few systems.
sub MY::makefile { '' }
