This repository contains document templates and supporting code for generating
individualized official lab result reports for SARS-CoV-2 / hCoV-19 / COVID-19
tests performed by Northwest Genomics Center.

## Usage

Example:

    fill-template \
        --template scan/report-en.tex \
        --params scan/example-params.csv \
        --filter 'status_code not in ["not-received", "pending"]' \
        --output "{qrcode}.pdf"

Requirements:

  * XeLaTeX
  * TeX Live
  * Droid package from TeX Live, if you don't have the full distribution
  * Python 3.6+ and various packages

### via Pipenv

You can install the Python dependencies with Pipenv:

    pipenv sync

XeLaTeX and TeX Live must be installed separately, usually from your platform's
package manager.  Alternatively, see how to run with Docker below.

Then use Pipenv to run `fill-template` as above:

    pipenv run ./fill-template …

### via Docker

Since TeX Live has a somewhat onerous installation process, a Docker image
exists containing all the dependencies required to run the report generation.

    docker image pull seattleflu/lab-result-reports

To use it to run `fill-template`, for example:

    docker run --rm seattleflu/lab-result-reports fill-template …

Note that the image is entirely self-contained and includes a copy of this
repository; the `fill-template` and `scan/report-en.tex` above refer to those
"baked into" image.

If you're using the image during development of the templates or code, be sure
to rebuild the image locally (see below) after every change you make.
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


## Translations

Translations of the English report template into several other languages exist within the `scan` and `scan-irb` directories.
These languages are noted by their ISO 639-1 language codes.
Currently, the way translations are handled are a bit of a mess.
They require copy-pasting from Microsoft Word or Google Sheet documents prepared by a team of external translators.
Those documents can be found on Google Drive by following the link in [this Slack message](https://seattle-flu-study.slack.com/archives/C0173B4S1LY/p1595531766289400).

The process for creating new language templates is unfortunately tedious and highly error-prone.
Luckily, the translations for languages we've seen so far follow English sentence-for-sentence.
So, periods (`.`) are one of the primary indicators for "where" we are in a document when copy-pasting from the Word Document into the LaTeX template.

There is a lot of room for improvement here.
One idea that comes to mind is creating a configuration file similar to [pybabel](http://babel.pocoo.org/en/latest/) that translates from English to various languages, sentence-for-sentence or word-for-ford.
