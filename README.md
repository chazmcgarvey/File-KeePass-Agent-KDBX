# NAME

File::KeePass::Agent::KDBX - A KeePass 2 agent

# VERSION

version 0.902

# SYNOPSIS

    use File::KeePass::Agent::KDBX;

    File::KeePass::Agent::KDBX->new(%attributes)->run;
    # OR
    File::KeePass::Agent::KDBX->new(%attributes)->run($filepath, $password);

See [File::KeePass::Agent](https://metacpan.org/pod/File%3A%3AKeePass%3A%3AAgent) for a more complete synopsis.

# DESCRIPTION

This is a thin subclass of [File::KeePass::Agent](https://metacpan.org/pod/File%3A%3AKeePass%3A%3AAgent) that uses the newer [File::KDBX](https://metacpan.org/pod/File%3A%3AKDBX) parser. It is meant to be
a drop-in replacement. This module really doesn't do anything except provide a way to load a backend other
than [File::KeePass](https://metacpan.org/pod/File%3A%3AKeePass). You could accomplish the same thing with **File::KeePass::Agent** directly in a hackier
way:

    use File::KeePass::Agent;
    use File::KeePass::KDBX;

    no warnings 'redefine';
    *File::KeePass::Agent::keepass_class = sub { 'File::KeePass::KDBX' };

Perhaps in the future **File::KeePass::Agent** will support this without monkey-patching. Until then, this
module allows setting the backend **File::KeePass** class in three ways (in decreasing precedence):

Pass as an attribute to the constructor:

    File::KeePass::Agent::KDBX->new(keepass_class => 'My::KeePass')->run;

as a package variable:

    $File::KeePass::Agent::KDBX::KEEPASS_CLASS = 'My::KeePass';
    File::KeePass::Agent::KDBX->new->run;

or from the environment:

    $ENV{PERL_FILE_KEEPASS_CLASS} = 'My::KeePass';
    File::KeePass::Agent::KDBX->new->run;

# ATTRIBUTES

## keepass\_class

    $k = File::KeePass::Agent::KDBX->keepass_class;
    $k = $agent->keepass_class;

Get the backend [File::KeePass](https://metacpan.org/pod/File%3A%3AKeePass) (or compatible) package name.

# ENVIRONMENT

- `PERL_FILE_KEEPASS_CLASS` - Name of the backend class (default: `File::KeePass::KDBX`)

# BUGS

Please report any bugs or feature requests on the bugtracker website
[https://github.com/chazmcgarvey/File-KeePass-Agent-KDBX/issues](https://github.com/chazmcgarvey/File-KeePass-Agent-KDBX/issues)

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

# AUTHOR

Charles McGarvey <ccm@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2022 by Charles McGarvey.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
