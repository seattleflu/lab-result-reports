# Newer Debian releases (e.g. "buster") include a version of tlmgr that doesn't
 # work well.  It doesn't matter that "slim" is from 2017, it works fine.
FROM python:3.7-slim-stretch

# Execute subsequent RUN statements with bash for handy modern shell features.
SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        texlive-xetex \
        texlive-fonts-recommended \
        wget \
        xzdec

RUN tlmgr init-usertree --usertree $(kpsewhich -var-value TEXMFLOCAL)
RUN tlmgr install --usertree $(kpsewhich -var-value TEXMFLOCAL) droid

WORKDIR /src

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . ./

CMD ["/bin/bash"]