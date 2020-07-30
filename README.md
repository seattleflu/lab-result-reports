This repository contains document templates and supporting code for generating
individualized official lab result reports for SARS-CoV-2 / hCoV-19 / COVID-19
tests performed by Northwest Genomics Center.

## Usage

Since TeX Live has a somewhat onerous installation process and sourcing local
font files within LaTeX is not very straight forward, a Docker image exists
containing all the dependencies required to run the report generation.

    docker image pull seattleflu/lab-result-reports

To use it to run `fill-template`, for example:

    docker run --rm seattleflu/lab-result-reports fill-template \
        --template scan/report-en.tex \
        --params scan/example-params.csv \
        --filter 'status_code not in ["not-received", "pending"]' \
        --output "{qrcode}.pdf"


Note that the image is entirely self-contained and includes a copy of this
repository; the `fill-template` and `scan/report-en.tex` above refer to those
"baked into" image.

Be sure to rebuild the image locally (see below) after every change you make.
Alternatively, you can overlay your local, active source dir into the container
at `/src`:

    docker run --rm -v $PWD:/src seattleflu/lab-result-reports fill-template …

The included `./devel/docker-run` takes care of this and a few other niceties:

    ./devel/docker-run fill-template …

To build a new image locally:

    make

To push a new image build to Docker Hub:

    make publish

This ensures the local image is up-to-date and your local git repository is
clean before pushing the image and tagging the current commit (`HEAD`) in git
with `build-N`.  _N_ is _M_ + 1, where _M_ is the number of the previous git
build tag.  The Docker images are tagged both `latest` and `build-N`.

To see an example of the image and `fill-template` in use, see
<https://github.com/seattleflu/backoffice/tree/master/bin/scan-return-of-results/generate-pdfs>.

## Requirements

  * Docker

## Attributions

The Ethiopic WashRa fonts (SIL Open Font License) are downloaded from
[Senamirmir](http://senamirmir.org/projects/typography/washra.html).
