PLUGIN_NAME=fylr-plugin-3d-specimen-viewer

# "basic" files that easydb's Makefile will install
INSTALL_FILES = \
	$(CSS) \
	$(WEB)/$(PLUGIN_NAME).js \
	manifest.yml

# translation files
L10N_FILES = l10n/$(PLUGIN_NAME).csv

# style files
CSS = $(WEB)/$(PLUGIN_NAME).css
SCSS_FILES = src/$(PLUGIN_NAME).scss

# actual plugin code
COFFEE_FILES = \
	src/SpecimenViewer3DPlugin.coffee

# Rule to copy files from dist
# (the files resulting from `npm run build`)
# to build/webfrontend
copy-dist:
		mkdir -p $(WEB)/
		cp -r dist/* $(WEB)

# other rules, as appropriate
all: build

include easydb-library/tools/base-plugins.make

build: copy-dist code css buildinfojson
	mkdir -p build/l10n
	cp -rf $(L10N_FILES) build/l10n
	cp manifest.yml build
	cp README.md build
	cp LICENSE build
	cp build-info.json build

code: $(JS)

clean: clean-base
	rm -f $(PLUGIN_NAME).zip
	rm -f build-info.json

zip: build
	mkdir -p $(PLUGIN_NAME)
	cp -r build/* $(PLUGIN_NAME)
	zip $(PLUGIN_NAME).zip -r $(PLUGIN_NAME) -x *.git*
	rm -rf $(PLUGIN_NAME)
