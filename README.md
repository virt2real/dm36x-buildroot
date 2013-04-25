# Buildroot for the DM36x projects

This README contains basic instructions for creating a system image for DM36x
boards using Buildroot. 

## Preparing your system

Buildroot requires several packages to be installed on the system before it
can work. On Ubuntu, the following apt-get line is sufficient:

    sudo apt-get install git-core bison flex g++ gettext texinfo libncurses5-dev pv libssl-dev lzop gawk

## Building for Virt2Real v.1 mass board

First of all set default board configuration:

    make virt2real_v1_mass_defconfig

Now you can change some options and build the world by using:

    make menuconfig
    make
    make linux-menuconfig // for kernel configuration issues
    make

Now you get uImage and FS image in output/images.

## Building for Leopard Board

To build a firmware image, run:

    ./board/leopardboard/build.sh

This will result in a .fw file being built. This takes a while.

If you are hacking the main image, you probably want more granularity in
building everything. First tell Buildroot which configuration to use:

    make leopardboard_dm368_defconfig

To build everything, run:

    make

The build output is stored in the output/images directory. Subsequent builds
are faster. It is possible to perform partial rebuilds. See the
[Buildroot](http://buildroot.uclibc.org/) website for details.

## Creating a MicroSD card

After the build completes successfully, you should have a .fw file.  Insert a
MicroSD card into an attached card reader and run:

    umount /media/<partitions that were automounted from the card>
    sudo sh ./leopardboard-xyz.fw -f /dev/sdc

where /dev/sdc is the location of the MicroSD card. Be sure to unmount
any directories that may have been automounted before running the
command or there's a high chance of creating a corrupt image.

## Updating the Root FS on target 

The Root FS is configured to mount read-only. This is done to prevent data
corruption from unsafe shutdowns and as a reminder that all configuration and
new packages have to end up in the buildroot configuration.

Since this can be annoying during debug, the rootfs can be mounted by running:

    remount

## Updating any of the applications

As bugs are fixed, it will be necessary to bring in new versions of packages.
Buildroot is configured to not allow this to happen by default. This is good,
since you can have a high confidence of being able to reproduce an old build.

If a package needs to be updated, edit the corresponding .mk file. For
example, if updating foo, edit package/foo/foo.mk and change the VERSION
to be the new version. The version could be a git hash tag or a named tag.

After making and testing the changes, commit the changes to the local
buildroot repository. You may also want to tag the new version so that
firmware files have nice looking names. (Renaming the .fw files will not
change the version numbers reported in the UI)

