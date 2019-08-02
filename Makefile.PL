use 5.006;
use strict;
use warnings;
use File::Spec;
use ExtUtils::MakeMaker 6.64;

my $VERSION_FROM = File::Spec->catfile(qw(lib File Stat Ls.pm));
my @provides = ();

# Module metadata {{{1
eval {
    require Module::Metadata;
    @provides =
        (provides => Module::Metadata->provides(version => '2', dir => 'lib'));
        # Thanks to https://stackoverflow.com/a/28928985/2877364 by LEONT
        # for suggesting Module::Metadata.
};

# }}}1
# Makefile customization {{{1
{
    package MY;

    # Generate README.md
    sub postamble {     # Generate README.md and README
        return <<EOT;
README.md: @{[$VERSION_FROM]} Makefile.PL
\t-pod2markdown "\$<" > "\$@"
\t-"$^X" -i -p -e 'BEGIN { undef \$\$/; } s/# NAME[^A-Z]+/# /s' README.md

README: @{[$VERSION_FROM]} Makefile.PL
\t-pod2text "\$<" > "\$@"

all :: README.md README
EOT
    }
}
# }}}1

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
        'Fcntl'      => '0',
        "Test::More" => '0',
    },
    PREREQ_PM          => {
        "Carp" => '0',
        'POSIX' => '0',
    },
    META_MERGE => {
        'meta-spec' => { version => 2 },

        resources => {
            bugtracker => {
                web  => 'https://github.com/cxw42/File-Stat-Ls/issues',
            },
            repository => {
                type => 'git',
                url  => 'https://github.com/cxw42/File-Stat-Ls.git',
                web  => 'https://github.com/cxw42/File-Stat-Ls',
            },
        },

        prereqs => {
            develop => {
                requires => {
                    'Module::Metadata' => '1.000016',
                },
                recommends => {
                    'Pod::Markdown' => '0',
                    'Pod::Text' => '0',
                },
            },
        },

        @provides,

    }, #META_MERGE
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'File-Stat-Ls-*' },
);

WriteMakefile(%WriteMakefileArgs);
# vi: set fdm=marker: #
