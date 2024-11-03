# 3D Specimen Viewer Plugin

This is an `easydb` plugin that integrates a 3D viewer for various 3D file types.

Currently supported are the file extensions:

- gltf, glb
- stl,
- obj,
- p3v

For more details on these file types and the viewer, please refer to [3d-specimen-viewer](https://gitlab.ethz.ch/betim/3d-specimen-viewer).

## Installation

Please follow the official installation guidelines.

## Development

This plugin mostly consists of the plugin functionality server-side (`src/SpecimenViewer3DPlugin.coffee`) and a react-app providing an iframe that does the actual file loading, display etc.

Therefore, after cloning this repository, you need npm to install the dependencies:

```bash
npm install
```

To build the react app, use

```bash
npm run build
```

Note that currently, the build folder is commited, as that simplifies deployment to easydb.
