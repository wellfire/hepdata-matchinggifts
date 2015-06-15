#!/usr/bin/env python
# -*- coding: utf-8 -*-


try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup


readme = open('README.rst').read()
history = open('HISTORY.rst').read().replace('.. :changelog:', '')

requirements = [
    "requests",
    "xmltodict",
]

setup(
    name='hepdata',
    version='0.1.0',
    description='HEPdata',
    long_description=readme + '\n\n' + history,
    author='Ben Lopatin',
    author_email='ben@wellfire.co',
    url='https://github.com/wellfire/hepdata',
    packages=[
        'hepdata',
    ],
    package_dir={'hepdata':
                 'hepdata'},
    include_package_data=True,
    install_requires=requirements,
    license="BSD",
    zip_safe=False,
    keywords='hepdata',
    classifiers=[
        'Development Status :: 2 - Pre-Alpha',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: BSD License',
        'Natural Language :: English',
        'Programming Language :: Python :: 2',
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.3',
        'Programming Language :: Python :: 3.4',
        'Programming Language :: Python :: 3.5',
    ],
    test_suite='tests',
)
