# docs-doxygen 

Doxygen submodule for inclusion in SDKs that want documentation published to https://docs.pixovr.com.

This uses:
 - https://github.com/PixoVR/docs-doxygen
 - https://github.com/PixoVR/docs-docker-base
 - https://github.com/PixoVR/docs-root
 - https://github.com/PixoVR/docs-docker-ue4-base (optional)
 - https://github.com/PixoVR/docs-docker-ue5-base (optional)

To actually arrive at https://docs.pixovr.com will require an administrator to add entries to the web server(s) involved.

## Usage

To use this, create a `documentation` folder at the root of your SDK (sub)module.

In the `documentation` folder, clone this repository:

`git submodule add https://github.com/PixoVR/docs-doxygen.git`

...now you have `documentation/docs-doxygen`.

In the `documentation/docs-doxygen` folder, run the `setup_submodule.sh` script to initialize folders and copy templates.

## Configuration

 - Modify the `env.sh` file as needed, updating the paths to parse for documentation.
 - Update/create markdown pages as needed in `pages/`.
 - Do a build with `./build.sh`, and view the documentation in the `html` folder using a local web browser.
 - Add your SDK to the `docs-root` repository, with this submodule added and committed.
 - Link the CI/CD tools with the `main` repository of your SDK, and make sure documentation changes are merged into the `main` branch.

Please note that you really don't want to change the contents of the `docs-doxygen` submodule for any individual implementation.  The `setup_submodule.sh` makes copies of scripts, files, and folders needed to customize any individual documentation implementation.  All changes can be made to the copies in this repo and in turn not committed to the `docs-doxygen` repo.

The intention is to be able to globally change colors, skin, functionality, theme, etc, and republish all documentation as needed without having to modify any individual documentation set.

## Unreal configuration

By default, the doxygen parser will scan the folders pointed to in `env.sh` for source code files.

It can be useful to include Unreal's blueprints and materials in the documentation output.

To do this, replace the Dockerfile copied by `setup_submodule.sh` to `documentation/Dockerfile` with the `documentation/docs-doxygen/setup_template/Dockerfile-unreal4` file:

```
cd documentation/
cp docs-doxygen/setup_template/Dockerfile-unreal4 ./Dockerfile
```

Note that the `Dockerfile` is pointed to in the `cloudbuild.yaml` file, so the name must match.

`Dockerfile-unreal4` will use the Unreal plugin `https://github.com/PixoVR/pixo-unreal-documentation` and the base image built from `https://github.com/PixoVR/docs-docker-ue4-base`.

If this is being used to document an Unreal plugin, this will mount the plugin into a hidden skeleton project, compile it, and then parse the UFS tree for `.uasset` entries containing Blueprints and Materials, and output fake C++ files to a `generated` folder.

Then, doxygen parses these fake C++ files along with the rest of the source, as if those files are native to the source.  Those files are not committed back to the original repository.


