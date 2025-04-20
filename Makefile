PLUGIN_NAME=easydb-3d-specimen-viewer-plugin

# "basic" files that easydb's Makefile will install
INSTALL_FILES = \
	$(WEB)/l10n/cultures.json \
	$(WEB)/l10n/de-DE.json \
	$(WEB)/l10n/en-US.json \
	$(CSS) \
	$(WEB)/easydb-3d-specimen-viewer-plugin.js \
	manifest.yml

# translation files
L10N_FILES = l10n/easydb-3d-specimen-viewer-plugin.csv

# style files
CSS = $(WEB)/easydb-3d-specimen-viewer-plugin.css
SCSS_FILES = src/easydb-3d-specimen-viewer-plugin.scss

# actual plugin code
COFFEE_FILES = \
	src/SpecimenViewer3DPlugin.coffee

# Rule to copy files from dist 
# (the files resulting from `npm run build`)
# to build/webfrontend
copy-dist:
		mkdir -p $(WEB)/
		cp -r dist/ $(WEB)

# other rules, as appropriate
all: build

include easydb-library/tools/base-plugins.make

build: copy-dist code css

code: $(JS) $(L10N)

clean: clean-base
