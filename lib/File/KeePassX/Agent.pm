package File::KeePassX::Agent;
# ABSTRACT: A KeePass 2 agent

use utf8;
use warnings;
use strict;

use Module::Load;
use namespace::clean;

use parent 'File::KeePass::Agent';

our $VERSION = '999.999'; # VERSION

our $KEEPASS_CLASS;
BEGIN {
    $KEEPASS_CLASS = $ENV{PERL_FILE_KEEPASS_CLASS} || 'File::KeePassX';
}

sub new {
    my $class = shift;
    my %args  = @_ == 1 && (ref $_[0] eq 'HASH') ? %{$_[0]} : @_;
    return bless \%args, $class;
}

sub run { __PACKAGE__->new->SUPER::run(@_) }

=attr keepass_class

    $k = File::KeePassX::Agent->keepass_class;
    $k = $agent->keepass_class;

Get the backend L<File::KeePass> (or compatible) instance.

=cut

sub keepass_class { (ref $_[0] eq 'HASH') && $_[0]->{keepass_class} || $KEEPASS_CLASS }

sub load_keepass {
    my $self = shift;
    load $self->keepass_class;
    return $self->SUPER::load_keepass(@_);
}

1;
__END__

=for Pod::Coverage load_keepass

=head1 SYNOPSIS

    use File::KeePassX::Agent;

    File::KeePassX::Agent->new(%attributes)->run;
    # OR
    File::KeePassX::Agent->new(%attributes)->run($filepath, $password);

See L<File::KeePass::Agent> for a more complete synopsis.

=head1 DESCRIPTION

This is a thin subclass of L<File::KeePass::Agent> that uses the newer L<File::KDBX> parser. It is meant to be
a drop-in replacement.

L<File::KeePass::Agent> is a suggested dependency of this distribution, but it is absolutely required for this
module to work at all. So be sure to list that separately as a dependency of your app or script if you need
it.

This module also provides support for setting the backend L<File::KeePass> class explicitly. You can do that
one of three ways, in decreasing precedence:

Pass as an argument:

    File::KeePassX::Agent->new(keepass_class => 'MyKeePass')->run;

as a package variable:

    File::KeePassX::Agent::KEEPASS_CLASS = 'MyKeePass';
    File::KeePassX::Agent->new->run;

or from the environment (must be set sometime before loading the module):

    BEGIN { $ENV{PERL_FILE_KEEPASS_CLASS} = 'MyKeePass' }
    use File::KeePassX::Agent;
    File::KeePassX::Agent->new->run;

=head1 ENVIRONMENT

=for :list
* C<PERL_FILE_KEEPASS_CLASS> - Name of the backend class (default: C<File::KeePassX>)

=cut
