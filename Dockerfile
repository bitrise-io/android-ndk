FROM bitriseio/docker-android-alpha:latest

ENV ANDROID_NDK_HOME /opt/android-ndk
ENV ANDROID_NDK_VERSION r14b


# ------------------------------------------------------
# --- Install required tools

RUN apt-get update -qq


# ------------------------------------------------------
# --- Android NDK

# download
RUN mkdir /opt/android-ndk-tmp
RUN cd /opt/android-ndk-tmp && wget -q https://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip
# uncompress
RUN cd /opt/android-ndk-tmp && unzip -q android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip
# move to its final location
RUN cd /opt/android-ndk-tmp && mv ./android-ndk-${ANDROID_NDK_VERSION} ${ANDROID_NDK_HOME}
# remove temp dir
RUN rm -rf /opt/android-ndk-tmp
# add to PATH
ENV PATH ${PATH}:${ANDROID_NDK_HOME}


# ------------------------------------------------------
# --- Cleanup and rev num

# Cleaning
RUN apt-get clean

ENV BITRISE_DOCKER_REV_NUMBER_ANDROID_NDK v2017_03_29_1
CMD bitrise -version

