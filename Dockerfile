FROM runatlantis/atlantis:latest

RUN apk add --no-cache py3-setuptools py3-pip py3-lxml && \
    pip install --no-cache terraform-compliance && \
    apk del py3-setuptools py3-pip
