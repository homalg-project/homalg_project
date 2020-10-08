<!-- BEGIN HEADER -->
# Gauss – Extended Gauss functionality for GAP

| Documentation | Build Status of [homalg_project](/../../) | Code Coverage of [homalg_project](/../../) |
| ------------- | ------------ | ------------- |
| [![HTML stable documentation][docs-img]][docs-url] | [![Build Status][tests-img]][tests-url] | [![Code Coverage][codecov-img]][codecov-url] |

<!-- END HEADER -->
The Gauss package utilizes some C-code by Max Neunhoeffer that has to
be compiled before you can load Gauss. To compile the code, first run

    ./configure

If the package is not installed in the pkg/ subdirectory of GAP's root
directory you will need to provide the correct path to the latter. This will
create a makefile. Complete the installation of the package by running

    make
<!-- BEGIN FOOTER -->
[docs-img]: https://img.shields.io/badge/HTML-stable-blue.svg
[docs-url]: https://homalg-project.github.io/homalg_project/Gauss/doc/chap0_mj.html

[tests-img]: https://github.com/homalg-project/homalg_project/workflows/Tests/badge.svg?branch=master
[tests-url]: https://github.com/homalg-project/homalg_project/actions?query=workflow%3ATests+branch%3Amaster

[codecov-img]: https://codecov.io/gh/homalg-project/homalg_project/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/homalg-project/homalg_project
<!-- END FOOTER -->
