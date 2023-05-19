# =============================================================================
# Common setup for all Makefiles
# =============================================================================

LC_ALL = C # Ensure simplest POSIX locale

top_dir = $(abspath $(patsubst %/,%,$(dir $(lastword $(MAKEFILE_LIST)))))

# Private sub-targets
# =============================================================================

.PHONY: _help
# -----------------------------------------------------------------------------

# ANSI color codes
BOLD = [1m
NC = [0m

_help:
	@ printf 'Usage: \e$(BOLD)make\e$(NC) [ target ]\n\n'
	@ printf 'Available targets:\n\n'
	@ grep -E '^.PHONY: [a-z-]+ #' Makefile | \
		sed -E 's,^.PHONY: ([a-z-]+) # (.*),\1#\2,' | \
		column -s '#' -t | \
		sed -E "s,^([a-z-]+),  \x1b$(BOLD)\1\x1b$(NC),"
