use 5.006;
use strict;
use warnings;
use File::Spec;
use ExtUtils::MakeMaker 6.64;

my $VERSION_FROM = File::Spec->catfile(qw(lib File Stat Ls.pm));

my %WriteMakefileArgs = (
    NAME            => 'File::Stat::Ls',
    DISTNAME        => 'File-Stat-Ls',
    ABSTRACT_FROM   => $VERSION_FROM,
    VERSION_FROM    => $VERSION_FROM,
    LICENSE         => 'artistic_1',
    MIN_PERL_VERSION => '5.006',
    AUTHOR          => 'geotiger2001@yahoo.com',
    CONFIGURE_REQUIRES => {
        "ExtUtils::MakeMaker" => "6.64",
        'File::Spec' => '0',
    },
    BUILD_REQUIRES     => {
        "ExtUtils::MakeMaker" => '0',
    },
    TEST_REQUIRES      => {
        "Test::More" => '0',
    },
    PREREQ_PM          => {
        "Carp" => '0',
        'POSIX' => '0',
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'File-Stat-Ls-*' },
);

WriteMakefile(%WriteMakefileArgs);
