This repository contains document templates and supporting code for generating
a resume in PDF format.

## Usage

Example:

    fill-template \
        --template templates/resume.tex \
        --params templates/example-params.csv \
        --output "reports/resume.pdf"

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

    docker image pull kafay/latex-resume

To use it to run `fill-template`, for example:

    docker run --rm kafay/latex-resume fill-template …

Note that the image is entirely self-contained and includes a copy of this
repository; the `fill-template` and `templates/resume.tex` above refer to those
"baked into" image.

If you're using the image during development of the templates or code, be sure
to rebuild the image locally (see below) after every change you make.
Alternatively, you can overlay your local, active source dir into the container
at `/src`:

    docker run --rm -v $PWD:/src kafay/latex-resume fill-template …

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
