# 3D Specimen Viewer Plugin

This is an `easydb` plugin that integrates a 3D viewer for various 3D file types.

Currently supported are the file extensions:

- gltf, glb
- stl,
- obj,
- ply,
- fbx,
- p3v

For more details on these file types and the viewer, please refer to [3d-specimen-viewer](https://gitlab.ethz.ch/psa/photogrammetry-viewer/3d-specimen-viewer).

## Installation

Please follow the official installation [guidelines](https://docs.easydb.de/en/sysadmin/configuration/easydb-server.yml/plugins/).

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
Consequently, though, the git history is not as clean as it could be.
