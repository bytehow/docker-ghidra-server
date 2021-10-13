FROM openjdk:11-jdk-slim

ENV VERSION 10.0.4_PUBLIC
ENV DL https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.0.4_build/ghidra_10.0.4_PUBLIC_20210928.zip
ENV GHIDRA_SHA 1ce9bdf2d7f6bdfe5dccd06da828af31bc74acfd800f71ade021d5211e820d5e

RUN apt-get update && apt-get install -y wget unzip dnsutils --no-install-recommends
RUN wget --progress=bar:force -O /tmp/ghidra.zip ${DL}
RUN echo "$GHIDRA_SHA /tmp/ghidra.zip" | sha256sum -c - \
    && unzip /tmp/ghidra.zip \
    && mv ghidra_${VERSION} /ghidra \
    && chmod +x /ghidra/ghidraRun \
    && echo "===> Clean up unnecessary files..." \
    && apt-get purge -y --auto-remove wget unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives /tmp/* /var/tmp/* /ghidra/docs /ghidra/Extensions/Eclipse /ghidra/licenses

WORKDIR /ghidra

COPY entrypoint.sh /entrypoint.sh
COPY server.conf /ghidra/server/server.conf

EXPOSE 13100 13101 13102

RUN mkdir /repos

ENTRYPOINT ["/entrypoint.sh"]
CMD ["server"]
