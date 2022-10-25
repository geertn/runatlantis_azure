FROM ghcr.io/runatlantis/atlantis:v0.20.1

RUN apk add --no-cache \
        ca-certificates \
        less \
        ncurses-terminfo-base \
        krb5-libs \
        libgcc \
        libintl \
        libssl1.1 \
        libstdc++ \
        tzdata \
        userspace-rcu \
        zlib \
        icu-libs \
        curl &&  \
    apk -X "https://dl-cdn.alpinelinux.org/alpine/edge/main" add --no-cache lttng-ust

RUN curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.2.1/powershell-7.2.1-linux-alpine-x64.tar.gz -o /tmp/powershell.tar.gz && \
    mkdir -p /opt/microsoft/powershell/7 && tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7 && chmod +x /opt/microsoft/powershell/7/pwsh && ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh && rm -f /tmp/powershell.tar.gz

RUN pwsh -Command Set-PSRepository -Name PSGallery -InstallationPolicy Trusted && pwsh -Command Install-Module -Name DataGateway && pwsh -Command Set-PSRepository -Name PSGallery -InstallationPolicy Untrusted

RUN curl -L https://github.com/Azure/kubelogin/releases/download/v0.0.20/kubelogin-linux-amd64.zip -o /tmp/kubelogin.zip && \
    unzip /tmp/kubelogin.zip -d /tmp/ && mv /tmp/bin/linux_amd64/kubelogin /usr/local/bin/ && chmod +x /usr/local/bin/kubelogin && rm -rf /tmp/bin/
