FROM bitriseio/docker-android:latest

ENV ANDROID_NDK_HOME /opt/android-ndk


# ------------------------------------------------------
# --- Install required tools

RUN apt-get update -qq


# ------------------------------------------------------
# --- Android NDK

# download
RUN mkdir /opt/android-ndk-tmp
RUN cd /opt/android-ndk-tmp && wget -q http://dl.google.com/android/ndk/android-ndk-r10e-linux-x86_64.bin
# uncompress
RUN cd /opt/android-ndk-tmp && chmod a+x ./android-ndk-r10e-linux-x86_64.bin
RUN cd /opt/android-ndk-tmp && ./android-ndk-r10e-linux-x86_64.bin
# move to it's final location
RUN cd /opt/android-ndk-tmp && mv ./android-ndk-r10e /opt/android-ndk
# remove temp dir
RUN rm -rf /opt/android-ndk-tmp
# add to PATH
ENV PATH ${PATH}:${ANDROID_NDK_HOME}



# ------------------------------------------------------
# --- Cleanup and rev num

# Cleaning
RUN apt-get clean

ENV BITRISE_DOCKER_REV_NUMBER_ANDROID_NDK 2016_01_10_1
CMD bitrise -version
