# Docker Ubuntu Image for Winthrop University, CSCI 210

Paul Added this line to the readme. <-- remove this

## Overview
Docker is a tool that allows you to deploy linux "containers" on a variety of machines.  These are similar to virtual machines in the sense that each container execution runs in its own space, making it easy to deploy images across a variety of platforms.

The first basic concept to understand is the difference between a *Dockerfile*, a *docker image* and a *docker container*.  A Dockerfile provides the basic description with which to *generate* an image.  An image is the basis for deploying an OS somewhere ... think of it like a detailed description of an installed computer.  A docker container is the actual deployed (running) OS.

You can find more information at [Docker's website here](https://docs.docker.com/get-started/overview/).

## Installing Docker
To use Docker, you will have to install it on your computer.  You will need administrator access to your machine to do this.  There are Docker tools available for Windows, Mac OS X, and Linux.  Follow the ["Get Docker" instructures here](https://docs.docker.com/get-docker/).  Note that you will need to have admin access to install Docker on most platforms (including Windows).


## Setting Up the Docker in CSCI 210
We will be using Docker in CSCI 210 at the start of term, so you will need to install it.  After you've done this, you will need the Dockerfile and other files, which we have stored in a git repo.  If you are in Windows, you can do this from the *GitBash* command line or using a GUI *git* tool.  From the command line (on any OS), you would type:

```
git clone https://github.com/WinthropUniversity/UbuntuDockerConfig-CSCI210.git
```

Once you have done this, you will need to *build* the image from the Dockerfile.  On Mac OS X or Linux, you just do this in a terminal session. On Windows, you *can* do it from *GitBash*, but it will take longer.  Better to use Window's native *CMD*.  Make sure you are in the project directory that you just cloned, then:

```
docker build -t winthrop/csci210:v1 .
docker images
```

That second command will list all the images to which you have access.  You should see the winthrop/csci210:v1 image we just built.  Once you've built the image, you should not have to build it again.

It's straightforward to deploy and run the image as a container now (use "docker run"); however, we need to talk first about *persitency*.  If you run our docker image now, you can certainly play around with it and learn about linux in general (and Ubuntu, in particular); however, if you create or change files in the container, those changes will not persist across a future deployment of the containers.  We'll need to map a volume from inside the container to somewhere on your disk to do that.  I suggest you use the "persistent-homedir" directory in the project directory you just cloned.

We want to run the container *interactively* -- meaning, we want it to be like we're logged into that machine and can interact with it.  There are alternative ways to run containers, but that's another discussion.  We'll also name the container.  This is different than the image name.  You can, conceivably, run multiple container instances off the same image -- they just need unique names.  I'll keep this simple and give it the name "csci210".  On Windows, do this from the native Windows *CMD*.  On other platforms, use your terminal.  **NOTE:** Do not just copy and paste this line; you need to edit the path so it points to your persistent home directory.

```
docker run --name csci210  -it --rm -v C:\wherever\you\cloned\UbuntuDockerConfig-CSCI210\persistent-homedir:/home/student  winthrop/csci210:v1
```

Breaking it down, this command says:
1. Run a docker container
2. Call it 'csci210'
3. Run interactively
4. Remove the container when you exit
5. Map a volume from my local drive to the /home/student directory in the container
6. Use the winthrop/csci210:v1 image that we just built.

If you issued these commands, you should be at a linux command line, logged in as 'student' and in your home directory.

## Detaching and Reattacing to a Running Container
If you exit from the container, it will close and be cleaned up.  You'll have to run it again (see the previous section).  But you can also just *dettach* from the container and leave it running by pressing Ctl-p Ctl-q from inside it.  You can reattach at any time as follows:
```
docker attach csci210
```

## Other Useful Commands

To list all images available:
```
docker images
```

To list all running containers:
```
docker ps -a
```

To *remove* a container:
```
docker rm <container-name>
# e.g.:  docker rm csci210
```

To remove an image:
```
docker rmi <image-name>
# e.g.:  docker rmi winthrop/csci210:v1
```

There are ways to detach from a running container and re-attach to it, but that's a different discussion.  For now, after you exit, go ahead and clean up the container by removing it.  Don't remove the image or you will have to rebuild it.


