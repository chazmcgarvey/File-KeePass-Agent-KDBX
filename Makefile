
# This is not a Perl distribution, but it can build one using Dist::Zilla.

CPANM   = cpanm
COVER   = cover
DZIL    = dzil
PERL    = perl
PROVE   = prove

cpanm_env = AUTHOR_TESTING=0 RELEASE_TESTING=0

all: dist

bootstrap:
	$(cpanm_env) $(CPANM) -nq Dist::Zilla
	$(DZIL) authordeps --missing |$(cpanm_env) $(CPANM) -nq
	$(DZIL) listdeps --develop --missing |$(cpanm_env) $(CPANM) -nq

clean:
	$(DZIL) $@

cover:
	$(COVER) -test

dist:
	$(DZIL) build

distclean: clean
	$(RM) -r cover_db

run:
	$(PERL) -Ilib bin/fkpx-agent t/files/Format300.kdbx

test:
	$(PROVE) -l $(if $(V),-vj1)

.PHONY: all bootstrap clean cover dist distclean run test
