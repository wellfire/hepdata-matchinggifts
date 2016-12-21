.PHONY: clean-pyc clean-build docs clean

TEST_FLAGS=--verbose
COVER_FLAGS=--cov=hepdata

oldhelp:
	@echo "clean-test - remove test and coverage artifacts"
	@echo "clean-test-all - remove all test-related artifacts including tox"
	@echo "test-coverage - run tests with coverage report"
	@echo "test-all - run tests on every Python version with tox"
	@echo "check - run all necessary steps to check validity of project"
	@echo "release - package and upload a release"
	@echo "dist - package"

install:  ## Install all requirements including for testing
	pip install -r requirements.txt

install-quiet:  ## Same as install but pipes all output to /dev/null
	pip install -r requirements.txt > /dev/null

clean: clean-build clean-pyc clean-test-all  ## Remove all artifacts

clean-build:  ## Remove build artifacts
	@rm -rf build/
	@rm -rf dist/
	@rm -rf *.egg-info

clean-pyc:  ## Remove Python file artifacts
	-@find . -name '*.pyc' -follow -print0 | xargs -0 rm -f &> /dev/null
	-@find . -name '*.pyo' -follow -print0 | xargs -0 rm -f &> /dev/null
	-@find . -name '__pycache__' -type d -follow -print0 | xargs -0 rm -rf &> /dev/null

clean-test:
	rm -rf .coverage coverage*
	rm -rf tests/.coverage test/coverage*
	rm -rf htmlcov/

clean-test-all: clean-test
	rm -rf .tox/

lint:  ## Static analysis and check style with flake8
	flake8 hepdata

	
test:  ## Run tests quickly with the default Python
	py.test ${TEST_FLAGS}

test-coverage: clean-test
	-py.test ${COVER_FLAGS} ${TEST_FLAGS}
	@exit_code=$?
	@-coverage html
	@exit ${exit_code}

test-all:
	tox


check: clean-build clean-pyc clean-test lint test-coverage

build: clean  ## Create distribution files for release
	python setup.py sdist bdist_wheel

release: build  ## Create distribution files and publish to PyPI
	python setup.py check -r -s
	twine upload dist/*

sdist: clean  ##sdist Create source distribution only
	python setup.py sdist
	ls -l dist

docs:
	$(MAKE) -C docs clean
	$(MAKE) -C docs html
	open docs/_build/html/index.html

help:
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
