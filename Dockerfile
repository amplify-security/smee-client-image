ARG ALPINE_VERSION="3.22"

FROM alpine:${ALPINE_VERSION}

ARG NODE_APK_VERSION="22.16.0-r2"
ARG NPM_APK_VERSION="11.3.0-r1"
ARG SMEE_VERSION="2.0.3"

# install dependencies
RUN apk --no-cache add nodejs=${NODE_APK_VERSION} npm=${NPM_APK_VERSION}

# add smee system user
RUN adduser -s /sbin/nologin -S -D -H -u 1000 smee

# install smee-client
RUN npm install -g smee-client@${SMEE_VERSION} && \
    npm cache clean --force

USER smee
ENTRYPOINT ["smee"]
CMD ["--help"]
