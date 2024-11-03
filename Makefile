PLUGIN_NAME=easydb-3d-specimen-viewer-plugin

INSTALL_FILES = \
	$(WEB)/dist/easydb-3d-specimen-viewer-plugin.js \
	$(WEB)/dist/viewer-frame.html \
	$(CSS) \
	manifest.yml

L10N_FILES = l10n/easydb-3d-specimen-viewer-plugin.csv

CSS = $(WEB)/dist/css/easydb-3d-specimen-viewer-plugin.css

COFFEE_FILES = \
	src/SpecimenViewer3DPlugin.coffee

all: build

include easydb-library/tools/base-plugins.make

build: code css $(EXTRA_FILES)

code: $(JS) $(L10N)

clean: clean-base
