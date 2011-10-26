#############################################################################
##  v      #                   The Coq Proof Assistant                     ##
## <O___,, #                INRIA - CNRS - LIX - LRI - PPS                 ##
##   \VV/  #                                                               ##
##    //   #  Makefile automagically generated by coq_makefile Vtrunk      ##
#############################################################################

# WARNING
#
# This Makefile has been automagically generated
# Edit at your own risks !
#
# END OF WARNING

#
# This Makefile was generated by the command line :
# coq_makefile -f files.txt -o Makefile 
#

NOARG: all

# 
# This Makefile may take arguments passed as environment variables:
# COQBIN to specify the directory where Coq binaries resides;
# ZDEBUG/COQDEBUG to specify debug flags for ocamlc&ocamlopt/coqc;
# DSTROOT to specify a prefix to install path.

# Here is a hack to make $(eval $(shell works:
define donewline


endef
includecmdwithout@ = $(eval $(subst @,$(donewline),$(shell { $(1) | tr '\n' '@'; })))
$(call includecmdwithout@,$(COQBIN)coqtop -config)

##########################
#                        #
# Libraries definitions. #
#                        #
##########################

OCAMLLIBS?=
COQSRCLIBS?=-I $(COQLIB)kernel -I $(COQLIB)lib \
  -I $(COQLIB)library -I $(COQLIB)parsing \
  -I $(COQLIB)pretyping -I $(COQLIB)interp \
  -I $(COQLIB)proofs -I $(COQLIB)tactics \
  -I $(COQLIB)toplevel \
  -I $(COQLIB)plugins/cc \
  -I $(COQLIB)plugins/decl_mode \
  -I $(COQLIB)plugins/dp \
  -I $(COQLIB)plugins/extraction \
  -I $(COQLIB)plugins/field \
  -I $(COQLIB)plugins/firstorder \
  -I $(COQLIB)plugins/fourier \
  -I $(COQLIB)plugins/funind \
  -I $(COQLIB)plugins/micromega \
  -I $(COQLIB)plugins/nsatz \
  -I $(COQLIB)plugins/omega \
  -I $(COQLIB)plugins/quote \
  -I $(COQLIB)plugins/ring \
  -I $(COQLIB)plugins/romega \
  -I $(COQLIB)plugins/rtauto \
  -I $(COQLIB)plugins/setoid_ring \
  -I $(COQLIB)plugins/subtac \
  -I $(COQLIB)plugins/subtac/test \
  -I $(COQLIB)plugins/syntax \
  -I $(COQLIB)plugins/xml
COQLIBS?= -R . AAC_tactics
COQDOCLIBS?=-R . AAC_tactics

##########################
#                        #
# Variables definitions. #
#                        #
##########################


ZFLAGS=$(OCAMLLIBS) $(COQSRCLIBS) -I $(CAMLP4LIB)
OPT?=
COQFLAGS?=-q $(OPT) $(COQLIBS) $(OTHERFLAGS) $(COQ_XML)
COQC?=$(COQBIN)coqc
COQDEP?=$(COQBIN)coqdep -c
GALLINA?=$(COQBIN)gallina
COQDOC?=$(COQBIN)coqdoc
CAMLC?=$(OCAMLC) -c -rectypes
CAMLOPTC?=$(OCAMLOPT) -c -rectypes
CAMLLINK?=$(OCAMLC) -rectypes
CAMLOPTLINK?=$(OCAMLOPT) -rectypes
GRAMMARS?=grammar.cma
CAMLP4EXTEND?=pa_extend.cmo pa_macro.cmo q_MLast.cmo
CAMLP4OPTIONS?=
PP?=-pp "$(CAMLP4BIN)$(CAMLP4)o -I $(CAMLLIB) -I . $(COQSRCLIBS) $(CAMLP4EXTEND) $(GRAMMARS) $(CAMLP4OPTIONS) -impl"

###################################
#                                 #
# Definition of the "all" target. #
#                                 #
###################################

VFILES:=Caveats.v\
  Tutorial.v\
  Instances.v\
  AAC.v

-include $(addsuffix .d,$(VFILES))
.SECONDARY: $(addsuffix .d,$(VFILES))

VOFILES:=$(VFILES:.v=.vo)
GLOBFILES:=$(VFILES:.v=.glob)
VIFILES:=$(VFILES:.v=.vi)
GFILES:=$(VFILES:.v=.g)
HTMLFILES:=$(VFILES:.v=.html)
GHTMLFILES:=$(VFILES:.v=.g.html)
ML4FILES:=rewrite.ml4

-include $(addsuffix .d,$(ML4FILES))
.SECONDARY: $(addsuffix .d,$(ML4FILES))

MLFILES:=print.ml\
  theory.ml\
  matcher.ml\
  search_monad.ml\
  helper.ml\
  coq.ml

-include $(addsuffix .d,$(MLFILES))
.SECONDARY: $(addsuffix .d,$(MLFILES))

MLPACKFILES:=aac.mlpack

-include $(addsuffix .d,$(MLPACKFILES))
.SECONDARY: $(addsuffix .d,$(MLPACKFILES))

MLIFILES:=rewrite.mli\
  print.mli\
  theory.mli\
  matcher.mli\
  search_monad.mli\
  helper.mli\
  coq.mli

-include $(addsuffix .d,$(MLIFILES))
.SECONDARY: $(addsuffix .d,$(MLIFILES))

ALLCMOFILES:=$(ML4FILES:.ml4=.cmo) $(MLFILES:.ml=.cmo) $(MLPACKFILES:.mlpack=.cmo)
CMOFILES=$(filter-out $(addsuffix .cmo,$(foreach lib,$(MLLIBFILES:.mllib=_MLLIB_DEPENDENCIES) $(MLPACKFILES:.mlpack=_MLPACK_DEPENDENCIES),$($(lib)))),$(ALLCMOFILES))
CMXFILES=$(CMOFILES:.cmo=.cmx)
OFILES=$(CMXFILES:.cmx=.o)
CMIFILES=$(sort $(ALLCMOFILES:.cmo=.cmi) $(MLIFILES:.mli=.cmi))
CMXSFILES=$(CMXFILES:.cmx=.cmxs)

all: $(VOFILES) $(CMOFILES) $(if ifeq '$(HASNATDYNLINK)' 'true',$(CMXSFILES)) 

mlihtml: $(MLIFILES:.mli=.cmi)
	 mkdir $@ || rm -rf $@/*
	$(OCAMLDOC) -html -rectypes -d $@ -m A $(ZDEBUG) $(ZFLAGS) $(^:.cmi=.mli)

all-mli.tex: $(MLIFILES:.mli=.cmi)
	$(OCAMLDOC) -latex -rectypes -o $@ -m A $(ZDEBUG) $(ZFLAGS) $(^:.cmi=.mli)

spec: $(VIFILES)

gallina: $(GFILES)

html: $(GLOBFILES) $(VFILES)
	- mkdir -p html
	$(COQDOC) -toc -html $(COQDOCLIBS) -d html $(VFILES)

gallinahtml: $(GLOBFILES) $(VFILES)
	- mkdir -p html
	$(COQDOC) -toc -html -g $(COQDOCLIBS) -d html $(VFILES)

all.ps: $(VFILES)
	$(COQDOC) -toc -ps $(COQDOCLIBS) -o $@ `$(COQDEP) -sort -suffix .v $(VFILES)`

all-gal.ps: $(VFILES)
	$(COQDOC) -toc -ps -g $(COQDOCLIBS) -o $@ `$(COQDEP) -sort -suffix .v $(VFILES)`

all.pdf: $(VFILES)
	$(COQDOC) -toc -pdf $(COQDOCLIBS) -o $@ `$(COQDEP) -sort -suffix .v $(VFILES)`

all-gal.pdf: $(VFILES)
	$(COQDOC) -toc -pdf -g $(COQDOCLIBS) -o $@ `$(COQDEP) -sort -suffix .v $(VFILES)`


$(addsuffix .cmx,$(filter $(basename $(MLFILES)),$(aac_MLPACK_DEPENDENCIES))): %.cmx: %.ml
	$(CAMLOPTC) $(ZDEBUG) $(ZFLAGS) -for-pack Aac $<

$(addsuffix .cmx,$(filter $(basename $(ML4FILES)),$(aac_MLPACK_DEPENDENCIES))): %.cmx: %.ml4
	$(CAMLOPTC) $(ZDEBUG) $(ZFLAGS) -for-pack Aac $(PP) -impl $<

####################
#                  #
# Special targets. #
#                  #
####################

.PHONY: NOARG all opt byte archclean clean install depend html

%.cmi: %.mli
	$(CAMLC) $(ZDEBUG) $(ZFLAGS) $<

%.mli.d: %.mli
	$(OCAMLDEP) -slash $(OCAMLLIBS) "$<" > "$@" || ( RV=$$?; rm -f "$@"; exit $${RV} )

%.cmo: %.ml4
	$(CAMLC) $(ZDEBUG) $(ZFLAGS) $(PP) -impl $<

%.cmx: %.ml4
	$(CAMLOPTC) $(ZDEBUG) $(ZFLAGS) $(PP) -impl $<

%.ml4.d: %.ml4
	$(OCAMLDEP) -slash $(OCAMLLIBS) $(PP) -impl "$<" > "$@" || ( RV=$$?; rm -f "$@"; exit $${RV} )

%.cmo: %.ml
	$(CAMLC) $(ZDEBUG) $(ZFLAGS) $<

%.cmx: %.ml
	$(CAMLOPTC) $(ZDEBUG) $(ZFLAGS) $<

%.ml.d: %.ml
	$(OCAMLDEP) -slash $(OCAMLLIBS) "$<" > "$@" || ( RV=$$?; rm -f "$@"; exit $${RV} )

%.cmxs: %.cmx
	$(CAMLOPTLINK) $(ZDEBUG) $(ZFLAGS) -shared -o $@ $<

%.cmo: | %.mlpack
	$(CAMLLINK) $(ZDEBUG) $(ZFLAGS) -pack -o $@ $^

%.cmx: | %.mlpack
	$(CAMLOPTLINK) $(ZDEBUG) $(ZFLAGS) -pack -o $@ $^

%.mlpack.d: %.mlpack
	$(COQDEP) -slash $(COQLIBS) -c "$<" > "$@" || ( RV=$$?; rm -f "$@"; exit $${RV} )

%.vo %.glob: %.v
	$(COQC) $(COQDEBUG) $(COQFLAGS) $*

%.vi: %.v
	$(COQC) -i $(COQDEBUG) $(COQFLAGS) $*

%.g: %.v
	$(GALLINA) $<

%.tex: %.v
	$(COQDOC) -latex $< -o $@

%.html: %.v %.glob
	$(COQDOC) -html $< -o $@

%.g.tex: %.v
	$(COQDOC) -latex -g $< -o $@

%.g.html: %.v %.glob
	$(COQDOC) -html -g $< -o $@

%.v.d: %.v
	$(COQDEP) -slash $(COQLIBS) "$<" > "$@" || ( RV=$$?; rm -f "$@"; exit $${RV} )

byte:
	$(MAKE) all "OPT:=-byte"

opt:
	$(MAKE) all "OPT:=-opt"

install-natdynlink:
	for i in $(CMXSFILES); do \
	 install -d `dirname $(DSTROOT)$(COQLIB)user-contrib/AAC_tactics/$$i`; \
	 install $$i $(DSTROOT)$(COQLIB)user-contrib/AAC_tactics/$$i; \
	done

install:$(if ifeq '$(HASNATDYNLINK)' 'true',install-natdynlink)
	for i in $(VOFILES); do \
	 install -d `dirname $(DSTROOT)$(COQLIB)user-contrib/AAC_tactics/$$i`; \
	 install $$i $(DSTROOT)$(COQLIB)user-contrib/AAC_tactics/$$i; \
	done
	for i in $(CMOFILES); do \
	 install -d `dirname $(DSTROOT)$(COQLIB)user-contrib/AAC_tactics/$$i`; \
	 install $$i $(DSTROOT)$(COQLIB)user-contrib/AAC_tactics/$$i; \
	done
	for i in $(CMIFILES); do \
	 install -d `dirname $(DSTROOT)$(COQLIB)user-contrib/AAC_tactics/$$i`; \
	 install $$i $(DSTROOT)$(COQLIB)user-contrib/AAC_tactics/$$i; \
	done

install-doc:
	install -d $(DSTROOT)$(DOCDIR)user-contrib/AAC_tactics/html
	for i in html/*; do \
	 install $$i $(DSTROOT)$(DOCDIR)user-contrib/AAC_tactics/$$i;\
	done
	install -d $(DSTROOT)$(DOCDIR)user-contrib/AAC_tactics/mlihtml
	for i in mlihtml/*; do \
	 install $$i $(DSTROOT)$(DOCDIR)user-contrib/AAC_tactics/$$i;\
	done

clean:
	rm -f $(ALLCMOFILES) $(CMIFILES) $(CMAFILES)
	rm -f $(ALLCMOFILES:.cmo=.cmx) $(CMXAFILES) $(CMXSFILES) $(ALLCMOFILES:.cmo=.o) $(CMXAFILES:.cmxa=.a)
	rm -f $(addsuffix .d,$(MLFILES) $(MLIFILES) $(ML4FILES) $(MLLIBFILES) $(MLPACKFILES))
	rm -f $(VOFILES) $(VIFILES) $(GFILES) $(VFILES:.v=.v.d)
	rm -f all.ps all-gal.ps all.pdf all-gal.pdf all.glob $(VFILES:.v=.glob) $(VFILES:.v=.tex) $(VFILES:.v=.g.tex) all-mli.tex
	- rm -rf html mlihtml

archclean:
	rm -f *.cmx *.o


printenv:
	@$(COQBIN)coqtop -config
	@echo CAMLC =	$(CAMLC)
	@echo CAMLOPTC =	$(CAMLOPTC)
	@echo PP =	$(PP)
	@echo COQFLAGS =	$(COQFLAGS)

Makefile: files.txt
	mv -f $@ $@.bak
	$(COQBIN)coq_makefile -f $< -o $@


# WARNING
#
# This Makefile has been automagically generated
# Edit at your own risks !
#
# END OF WARNING

