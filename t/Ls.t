#!/usr/bin/env perl
# Portions Copyright (c) 2019 D3 Engineering, LLC.
use 5.006;
use strict;
use warnings;

use File::Spec;
use Test::More qw(no_plan);

use File::Stat::Ls qw(:all);
my $class = 'File::Stat::Ls';
my $obj = $class->new;

isa_ok($obj, $class);

my @md = @File::Stat::Ls::EXPORT_OK;
foreach my $m (@md) {
    ok($obj->can($m), "$class->can('$m')");
}

# my $fn = '/opt/orasw/dba/cgi/listdir.bat';
# my $f2 = '/opt/orasw/dba/cgi';
# my $f3 = '/opt/orasw/dba/cgi/wordstat.pl';
# my $txt = `ls -l $fn`;
# print "$fn\n";
# print "$txt";
# print $obj->ls_stat($fn);
# # print `ls -l $f2`;
# print $obj->ls_stat($f2);
# print `ls -l $f3`;
# print $obj->ls_stat($f3);

# my @a = `ls $f2`;
# foreach my $f (@a) {
#     next if ! $f || $f =~ /^\s*$/;
#     chomp $f;
#     # print "$f2/$f\n";
#     print $obj->ls_stat("$f2/$f");
# }

my $ls_this = $obj->ls_stat(__FILE__);
cmp_ok(length($ls_this), '>', 0, 'OO: can list ' . __FILE__);
unlike($ls_this, qr/->/, 'OO: no arrow on non-symlink');

$ls_this = ls_stat(__FILE__);
cmp_ok(length($ls_this), '>', 0, 'Procedural: can list ' . __FILE__);
unlike($ls_this, qr/->/, 'Procedural: no arrow on non-symlink');

SKIP: {
    my $symlink = File::Spec->catfile(qw(t symlink));
    eval { my $x = readlink $symlink };
    my $supports_symlink = !$@;

    skip "Platform doesn't support symlinks", 1 unless $supports_symlink;
    my $symlink_ls = ls_stat($symlink);
    like($symlink_ls, qr/->\s*[A-Za-z]/, 'Symlink has an arrow');
}

done_testing;
