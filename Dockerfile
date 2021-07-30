# Newer Debian releases (e.g. "buster") include a version of tlmgr that doesn't
# work well.  It doesn't matter that "stretch" is from 2017, it works fine.
FROM python:3.7-slim-stretch

# Execute subsequent RUN statements with bash for handy modern shell features.
SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        texlive-xetex \
        texlive-fonts-recommended \
        texlive-fonts-extra \
        fontconfig \
        fonts-noto-cjk \
        wget \
        xzdec


WORKDIR /src

COPY Pipfile Pipfile.lock ./
RUN pip install --no-cache-dir pipenv
RUN pipenv install --system

COPY . ./

ENV PATH /src:$PATH

CMD ["/bin/bash"]
