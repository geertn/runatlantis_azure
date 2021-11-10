FROM runatlantis/atlantis:v0.17.5

RUN apk add --no-cache py3-setuptools py3-pip py3-lxml && \
    pip install --no-cache terraform-compliance
