FROM bitriseio/docker-android-alpha:latest

ENV ANDROID_NDK_HOME /opt/android-ndk
ENV ANDROID_NDK_VERSION r14b


# ------------------------------------------------------
# --- Install required tools

RUN apt-get update -qq && \
    apt-get install -y bsdtar && \
    apt-get clean


# ------------------------------------------------------
# --- Android NDK

# create destination directory
RUN mkdir ${ANDROID_NDK_HOME} && \
# download
    wget -qO- https://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip | \
# uncompress to its final location
    bsdtar -xf- -C $ANDROID_NDK_HOME -s /^android-ndk-${ANDROID_NDK_VERSION}//

# add to PATH
ENV PATH ${PATH}:${ANDROID_NDK_HOME}


# ------------------------------------------------------
# --- Cleanup and rev num

ENV BITRISE_DOCKER_REV_NUMBER_ANDROID_NDK v2017_04_18_1
CMD bitrise -version

