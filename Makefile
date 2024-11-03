PLUGIN_NAME=easydb-3d-specimen-viewer-plugin

INSTALL_FILES = \
	$(WEB)/l10n/cultures.json \
	$(WEB)/l10n/de-DE.json \
	$(WEB)/l10n/en-US.json \
	$(CSS) \
	$(WEB)/easydb-3d-specimen-viewer-plugin.js \
	manifest.yml

EXTRA_FILES = \
	$(WEB)/../build/index.html \
	$(WEB)/../build/static/css/main.css \
	$(WEB)/../build/static/js/main.js \
	$(WEB)/../build/index.html \

L10N_FILES = l10n/easydb-3d-specimen-viewer-plugin.csv

CSS = $(WEB)/build/css/easydb-3d-specimen-viewer-plugin.css

SCSS_FILES = src/easydb-3d-specimen-viewer-plugin.scss

COFFEE_FILES = \
	src/SpecimenViewer3DPlugin.coffee

all: build

include easydb-library/tools/base-plugins.make

build: code css $(EXTRA_FILES)

code: $(JS) $(L10N)

clean: clean-base
