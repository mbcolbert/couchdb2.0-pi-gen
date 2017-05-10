# pi-gen w/ couchdb2.0
_This tool is used to create Raspbian Jessie-Lite images with CouchDB 2.0 pre-installed_

## Requirements

- Docker
- binfmt-support

## Build using Docker

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

## Using the image

Once you have the image, burn it onto the SD card that you intend to use with your Raspberry Pi.  Follow the directions here:
https://www.raspberrypi.org/documentation/installation/installing-images/linux.md

Boot up your Raspberry Pi and you should be able to ssh to it.  The user is 'pi' and the password is 'raspberry'.

Since this image is optimized as a headless server, its configured to use the minumum 16MB of system memory for video, maximizing available system memory for your application.

In the future, I may look into configurations that overclock either the SD card slot, the CPU, or more, to come up with something more fully optimized.

## Verifying CouchDB

Using a web browser, go to http://<your-pi-ip-address>:5984/_utils to access the CouchDB dashboard.  Select the "Verify" menu item and press the "Verify Installation" button.







