FROM bitriseio/docker-android-alpha:latest

ENV ANDROID_NDK_HOME /opt/android-ndk


# ------------------------------------------------------
# --- Install required tools

RUN apt-get update -qq


# ------------------------------------------------------
# --- Android NDK

# download
RUN mkdir /opt/android-ndk-tmp
RUN cd /opt/android-ndk-tmp && wget -q https://dl.google.com/android/repository/android-ndk-r13b-linux-x86_64.zip
# uncompress
RUN cd /opt/android-ndk-tmp && unzip -q android-ndk-r13b-linux-x86_64.zip
# move to its final location
RUN cd /opt/android-ndk-tmp && mv ./android-ndk-r13b ${ANDROID_NDK_HOME}
# remove temp dir
RUN rm -rf /opt/android-ndk-tmp
# add to PATH
ENV PATH ${PATH}:${ANDROID_NDK_HOME}


# ------------------------------------------------------
# --- Android CMake

# download
RUN mkdir /opt/android-cmake-tmp
RUN cd /opt/android-cmake-tmp && wget -q https://dl.google.com/android/repository/cmake-3.6.3155560-linux-x86_64.zip -O android-cmake.zip
# uncompress
RUN cd /opt/android-cmake-tmp && unzip -q android-cmake.zip -d android-cmake
# move to its final location
RUN cd /opt/android-cmake-tmp && mv ./android-cmake ${ANDROID_HOME}/cmake
# remove temp dir
RUN rm -rf /opt/android-cmake-tmp
# add to PATH
ENV PATH ${PATH}:${ANDROID_HOME}/cmake/bin


# ------------------------------------------------------
# --- Cleanup and rev num

# Cleaning
RUN apt-get clean

ENV BITRISE_DOCKER_REV_NUMBER_ANDROID_NDK 2016_06_18_1
CMD bitrise -version
