# pi-gen

_Tool used to create "Raspbian-Lite with Docker" images_

## Docker Build

```bash
./build-docker.sh
```
If everything goes well, your finished image will be in the `deploy/` folder.
You can then remove the build container with `docker rm pigen_work`

If something breaks along the line, you can edit the corresponding scripts, and
continue:

```
CONTINUE=1 ./build-docker.sh
```

There is a possibility that even when running from a docker container, the installation of `qemu-user-static` will silently fail when building the image because `binfmt-support` _must be enabled on the underlying kernel_. An easy fix is to ensure `binfmt-support` is installed on the host machine before starting the `./build-docker.sh` script (or using your own docker build solution).
