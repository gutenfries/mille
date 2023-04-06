# Set up envorinment
FROM ubuntu:20.04

#####################################################################
# Image Setup:
#####################################################################

# Set up environment variables for the build
ENV DEBIAN_FRONTEND="noninteractive"
ENV UID=1000
ENV GID=1000
ENV USER="developer"

ENV JAVA_VERSION="8"

ENV ANDROID_TOOLS_VERSION="6858069"
ENV ANDROID_SHORT_VERSION="29"
ENV ANDROID_LONG_VERSION="29.0.3"
ENV ANDROID_TOOLS_URL="https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_TOOLS_VERSION}_latest.zip"
ENV ANDROID_ARCHITECTURE="x86_64"
ENV ANDROID_HOME="/home/$USER/android"

ENV FLUTTER_CHANNEL="stable"
ENV FLUTTER_VERSION="3.7.8"
ENV FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/$FLUTTER_CHANNEL/linux/flutter_linux_$FLUTTER_VERSION-$FLUTTER_CHANNEL.tar.xz"
ENV FLUTTER_HOME="/home/$USER/flutter"

ENV PATH="$ANDROID_HOME/cmdline-tools/tools/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/platforms:$FLUTTER_HOME/bin:$PATH"

# resolve apt dependencies
RUN apt-get update \
	&& apt-get install --yes --no-install-recommends \
	openjdk-$JAVA_VERSION-jdk \
	curl \
	unzip \
	sed \
	git \
	bash \
	xz-utils \
	libglvnd0 \
	ssh \
	xauth \
	x11-xserver-utils \
	libpulse0 \
	libxcomposite1 \
	libgl1-mesa-glx \
	sudo \
	clang \
	cmake \
	ninja-build \
	pkg-config \
	libgtk-3-dev \
	liblzma-dev \
	&& rm -rf /var/lib/{apt,dpkg,cache,log}

# create user
RUN groupadd --gid $GID $USER \
	&& useradd -s /bin/bash --uid $UID --gid $GID -m $USER \
	&& echo $USER ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER \
	&& chmod 0440 /etc/sudoers.d/$USER

USER $USER
WORKDIR /home/$USER

# install android sdk
RUN \
	# create android sdk directories, if not existent \
	mkdir -p $ANDROID_HOME \
	&& mkdir -p /home/$USER/.android \
	&& touch /home/$USER/.android/repositories.cfg \
	# fetch android tools over net \
	&& curl -o android_tools.zip $ANDROID_TOOLS_URL \
	# unzip android tools \
	&& unzip -qq -d "$ANDROID_HOME" android_tools.zip \
	# remove temp zip file \
	&& rm android_tools.zip \
	# move desired android tools to correct location \
	&& mkdir -p $ANDROID_HOME/cmdline-tools/tools \
	&& mv $ANDROID_HOME/cmdline-tools/bin $ANDROID_HOME/cmdline-tools/tools \
	&& mv $ANDROID_HOME/cmdline-tools/lib $ANDROID_HOME/cmdline-tools/tools \
	&& yes "y" | sdkmanager "build-tools;$ANDROID_LONG_VERSION" \
	&& yes "y" | sdkmanager "platforms;android-$ANDROID_SHORT_VERSION" \
	&& yes "y" | sdkmanager "platform-tools" \
	# accept android sdk licenses \
	&& yes "y" | sdkmanager --licenses

# install flutter
RUN curl -o flutter.tar.xz $FLUTTER_URL \
	&& mkdir -p $FLUTTER_HOME \
	&& tar xf flutter.tar.xz -C /home/$USER \
	&& rm flutter.tar.xz \
	# set up flutter \
	&& flutter config --no-analytics \
	# pre-cache flutter deps \
	&& flutter precache \
	# ensure flutter is working \
	&& flutter doctor \
	# cache emulators \
	&& flutter emulators --create \
	# pre-run dep upgrade \
	&& flutter update-packages

# Install nodejs 16 and yarn
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
RUN sudo apt-get install -y nodejs
RUN sudo npm install -g yarn

#####################################################################
# App:
#####################################################################

# Resolve app dependencies.
WORKDIR /app
COPY pubspec.yaml ./
COPY package.json ./
# resolve dependencies BEFORE copying the rest of the app,
# to prevent re-resolving dependencies on every change
RUN flutter pub get
RUN yarn install

# Copy app source code (except anything in .dockerignore) and AOT compile app.
COPY . .

# update and/or generate the database
RUN yarn prisma db push --preview-feature
RUN flutter pub run build_runner build --delete-conflicting-outputs
