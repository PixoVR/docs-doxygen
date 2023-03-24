# docs-doxygen 

Doxygen submodule for inclusion in SDKs that want documentation published using docs-root.

To use this, create a `documentation` folder at the root of your SDK (sub)module.

In the `documentation` folder, clone this repository, so now you have `documentation/docs-doxygen`.

In the `documentation/docs-doxygen` folder, run the `setup_submodule.sh` script to initialize folders and copy templates.

 - Modify the `env.sh` file as needed.
 - Update/create markdown pages as needed in `pages/`.
 - Do a build with `./build.sh`, and view the documentation in the `html` folder.
 - Add your SDK to the `docs-root` repository, with this submodule added and committed.
 - Link the CI/CD tools with the `main` repository of your SDK, and make sure documentation changes are merged into the `main` branch.

