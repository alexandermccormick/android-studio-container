# Install Android Studio in a container image with GUI support

### Motivation
This repo was originally forked from [Purik/android-studio-docker](https://github.com/Purik/android-studio-docker). Changes have been made to convert it form using Docker to Podman, and you will now have to supply your own downloaded copy of Android Studio. I chose to install it this way because at the time of writing there is no official static download URL for Android Studio. While the link provided in the Docker version may work, it is old and comes from an unofficial provider.

### Getting Started
1. Clone this repo into it's own workspace
2. Visit [https://developer.android.com/studio#downloads](https://developer.android.com/studio#downloads) and click the link for "Linux (64bit)"
3. Move the Android Studio arhcive you downloaded to this workspace
4. Inside this workspace, run `chmod +x ./build.sh ./run.sh`

Now it is time to build the image and container. The path to our Android Studio archive must be provided for `build.sh`, and the final name for our Android Studio container must be provided for `run.sh`

1. Run `./build.sh /path/to/AndroidStudio.tar.gz`
2. Run `./run.sh name-of-final-container`
	1. Follow the Android Studio install to complete your installation.

The final container is the one you will use for actual development.

### Persist data and volumes
If you wish prepare Docker image once and reuse it multiple times later, follow next steps:
 - Run container by calling ```run.sh <your-image-name>``` (you can find this script beside Dockerfile in repo)
 - From Android Studio GUI click on Configuration menu item and install the necessary SDK tools and plugins
 - Close Studio GUI
 - You will see script is done and docker have build ```your-image-name``` that contains all configured Tools, Pluging, etc
 
