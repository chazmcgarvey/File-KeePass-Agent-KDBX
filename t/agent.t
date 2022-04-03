#!/usr/bin/env perl

use warnings;
use strict;

use File::KeePassX::Agent;
use File::Spec;
use FindBin qw($Bin);
use Test::More;

my $class = File::KeePassX::Agent->keepass_class;
is $class, 'File::KeePassX', 'Get class from keepass_class method';

is File::KeePassX::Agent::keepass_class(), 'File::KeePassX', 'Get class from keepass_class subroutine';

my $agent = File::KeePassX::Agent->new(keepass_class => 'File::KeePassX');
is $agent->keepass_class, 'File::KeePassX', 'Get class from an agent instance';

my $k = $agent->load_keepass(File::Spec->catfile($Bin, 'files', 'Format300.kdbx'), 'a');
isa_ok $k, 'File::KeePassX', 'Load the correct keepass class from the agent';

is $k->header->{database_name}, 'Test Database Format 0x00030000',
    'Verify the database loaded by the agent';

done_testing;
