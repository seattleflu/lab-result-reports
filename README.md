This repository contains document templates and supporting code for generating
individualized official lab result reports for SARS-CoV-2 / hCoV-19 / COVID-19
tests performed by Northwest Genomics Center.

Requirements:

  * XeLaTeX
  * TeX Live
  * Droid package from TeX Live, if you don't have the full distribution
  * Python 3.6+ and various packages

You can install the Python dependencies with Pipenv:

    pipenv sync

Since TeX Live has a somewhat onerous installation process, a Docker image may
be built containing all the dependencies required to run the report generation.

To build the image:

    make

To use it to run `fill-template`, for example:

    docker run --rm seattleflu/lab-result-reports fill-template …

Note that the image is entirely self-contained and includes a copy of this
repository; the `fill-template` and `scan/report-en.tex` above refer to those
"baked into" image.

If you're using the image during development of the templates or code, make
sure to run `make` after every change to update the image.  You can also
overlay your local, active source dir into the container at `/src`:

    docker run --rm -v $PWD:/src seattleflu/lab-result-reports fill-template …

To push a new image build to Docker Hub:

    make publish

This ensures the local image is up-to-date and your local git repository is
clean before pushing the image and tagging the current commit (`HEAD`) in git
with `build-N`.  _N_ is _M_ + 1, where _M_ is the number of the previous git
build tag.  The Docker images are tagged both `latest` and `build-N`.
