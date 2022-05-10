FROM alpine as downloader
RUN apk add --no-cache wget unzip && \
wget http://mirrors.ctan.org/support/latexindent.zip &&\
unzip latexindent.zip

FROM perl:slim
COPY --from=downloader /latexindent /latexindent
RUN echo 'y' | perl /latexindent/latexindent-module-installer.pl &&\
    cp /latexindent/latexindent.pl /latexindent/latexindent

ENV PATH $PATH:/latexindent

WORKDIR /workdir