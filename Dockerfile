FROM openjdk:19-jdk-alpine

ENV REVIEWDOG_VERSION=v0.14.1
ENV CHECKSTYLE_VERSION=10.3

# do not cache index
RUN apk --no-cache add git

RUN wget -O - -q https://github.com/checkstyle/checkstyle/releases/download/checkstyle-${CHECKSTYLE_VERSION}/checkstyle-${CHECKSTYLE_VERSION}-all.jar > /checkstyle.jar
RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}

# Copies code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["sh", "/entrypoint.sh"]