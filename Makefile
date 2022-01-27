REBAR := ./rebar

.PHONY: all doc clean test dialyzer

all: compile doc

compile: $(REBAR)
	$(REBAR) get-deps compile

doc:
	$(REBAR) doc skip_deps=true

test: $(REBAR)
	set -x ;\
	if [ -n "$(S)" ] ; then \
	  $(REBAR) eunit suite="$(S)" skip_deps=true ; \
	else \
	  $(REBAR) eunit skip_deps=true ;\
	fi ;

dialyzer:
	$(REBAR) analyze

release: all dialyzer test
	$(REBAR) release

clean:
	$(REBAR) clean

# TODO: get tests working under rebar3
# $(REBAR):
# 	curl '$(REBAR_URL)' > $@ && chmod +x $@
