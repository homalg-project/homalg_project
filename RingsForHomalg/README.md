<!-- BEGIN HEADER -->
# RingsForHomalg – Dictionaries of external rings

| Documentation | Build Status of [homalg_project](/../../) | Code Coverage of [homalg_project](/../../) |
| ------------- | ------------ | ------------- |
| [![HTML stable documentation][docs-img]][docs-url] | [![Build Status][tests-img]][tests-url] | [![Code Coverage][codecov-img]][codecov-url] |

<!-- END HEADER -->
This package gives access to certain classes of rings and matrices from the computer algebra systems

| Computer algebra system | least version  | exectuable |
|:------------------------|:---------------|:-----------|
| [Singular][Singular]    | >= 3-0-4       | `Singular` |
| [Macaulay2][Macaulay2]  | >= 1.2         | `M2`       |
| [MAGMA][MAGMA]          | >= 2.14        | `magma`    |
| [Maple][Maple]          | >= 9 (not 9.5) | `maple`    |
| [Sage][Sage]            | >= 4.1.1       | `sage`     |

For the full functionality the above executables must be in your `PATH`.

Under [MacOSX](https://www.apple.com/macos/) you can use all Maple versions >= 9 (apart from Maple9.5). For Maple9 you should do something like:

```
sudo ln -s "/Applications/Maple 9.app/Contents/MacOS/bin/maple" /usr/local/bin/maple9
```
And starting from version 10 something like:

```
sudo ln -s /Library/Frameworks/Maple.framework/Versions/13/bin/maple /usr/local/bin/maple13
```
<!-- BEGIN FOOTER -->
[docs-img]: https://img.shields.io/badge/HTML-stable-blue.svg
[docs-url]: https://homalg-project.github.io/homalg_project/RingsForHomalg/doc/chap0_mj.html

[tests-img]: https://github.com/homalg-project/homalg_project/workflows/Tests/badge.svg?branch=master
[tests-url]: https://github.com/homalg-project/homalg_project/actions?query=workflow%3ATests+branch%3Amaster

[codecov-img]: https://codecov.io/gh/homalg-project/homalg_project/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/homalg-project/homalg_project
<!-- END FOOTER -->

[Singular]: https://www.singular.uni-kl.de/

[Macaulay2]: http://www2.macaulay2.com/Macaulay2/

[MAGMA]: http://magma.maths.usyd.edu.au/magma/

[Maple]: https://maplesoft.com/products/Maple/

[Sage]: https://www.sagemath.org/
