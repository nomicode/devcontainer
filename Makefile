# =============================================================================
# Primary build
# =============================================================================

.EXPORT_ALL_VARIABLES:

include common.mk

trunk_args=
ifeq ($(CI),true)
trunk_args += --ci --ci-progress
endif

# Primary targets
# =============================================================================

.PHONY: help
# -----------------------------------------------------------------------------

.DEFAULT_GOAL = help

help: _help

.PHONY: init # Initialize the build system
# -----------------------------------------------------------------------------

init: node_modules
node_modules: package.json
	yarn install $(trunk_args)
	touch $@

init: .git/config
.git/config: node_modules
	yarn trunk git-hooks sync $(trunk_args)
	touch $@

.PHONY: upgrade # Upgrade the build system dependencies
# -----------------------------------------------------------------------------

upgrade: init
	yarn trunk upgrade $(trunk_args)

.PHONY: check # Check new and changed files
# -----------------------------------------------------------------------------

check: init
	yarn trunk check $(trunk_args)

.PHONY: check-all # Check all files in the repository
# -----------------------------------------------------------------------------

check-all: init
	yarn trunk check --all $(trunk_args)

.PHONY: format # Format new and changed files
# -----------------------------------------------------------------------------

format: init
	yarn trunk fmt $(trunk_args)

.PHONY: format-all # Format all files in the repository
# -----------------------------------------------------------------------------

format-all: init
	yarn trunk fmt --all $(trunk_args)

.PHONY: test-build # Test the devcontainer build
# -----------------------------------------------------------------------------

devcontainer_dir = $(top_dir)/.devcontainer

test-build: init
	. $(devcontainer_dir)/.env && $(devcontainer_dir)/test_build.sh

.PHONY: ci # Make all CI targets
# -----------------------------------------------------------------------------

ci:
	CI=true $(MAKE) init upgrade check-all format-all test-build

.PHONY: clean # Remove build artifacts
# -----------------------------------------------------------------------------

clean: _rm-empty-dirs

.PHONY: _rm-empty_-irs
_rm-empty-dirs: _git-clean
	find . -type d -empty -delete

.PHONY: _git-clean
# Remove files that match `.gitignore` (but keep untracked files)
_git-clean:
	git clean -f -d -X
