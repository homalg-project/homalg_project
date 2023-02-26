<!-- BEGIN HEADER -->
# RingsForHomalg&ensp;<sup><sup>[![View code][code-img]][code-url]</sup></sup>

### Dictionaries of external rings

| Documentation | Latest Release | Build Status of [homalg_project](/../../) | Code Coverage |
| ------------- | -------------- | ------------ | ------------- |
| [![HTML stable documentation][html-img]][html-url] [![PDF stable documentation][pdf-img]][pdf-url] | [![version][version-img]][version-url] [![date][date-img]][date-url] | [![Build Status][tests-img]][tests-url] | [![Code Coverage][codecov-img]][codecov-url] |

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
[html-img]: https://img.shields.io/badge/🔗%20HTML-stable-blue.svg
[html-url]: https://homalg-project.github.io/homalg_project/RingsForHomalg/doc/chap0_mj.html

[pdf-img]: https://img.shields.io/badge/🔗%20PDF-stable-blue.svg
[pdf-url]: https://homalg-project.github.io/homalg_project/RingsForHomalg/download_pdf.html

[version-img]: https://img.shields.io/endpoint?url=https://homalg-project.github.io/homalg_project/RingsForHomalg/badge_version.json&label=🔗%20version&color=yellow
[version-url]: https://homalg-project.github.io/homalg_project/RingsForHomalg/view_release.html

[date-img]: https://img.shields.io/endpoint?url=https://homalg-project.github.io/homalg_project/RingsForHomalg/badge_date.json&label=🔗%20released%20on&color=yellow
[date-url]: https://homalg-project.github.io/homalg_project/RingsForHomalg/view_release.html

[tests-img]: https://github.com/homalg-project/homalg_project/actions/workflows/Tests.yml/badge.svg?branch=master
[tests-url]: https://github.com/homalg-project/homalg_project/actions/workflows/Tests.yml?query=branch%3Amaster

[codecov-img]: https://codecov.io/gh/homalg-project/homalg_project/branch/master/graph/badge.svg?flag=RingsForHomalg
[codecov-url]: https://app.codecov.io/gh/homalg-project/homalg_project/tree/master/RingsForHomalg

[code-img]: https://img.shields.io/badge/-View%20code-blue?logo=github
[code-url]: https://github.com/homalg-project/homalg_project/tree/master/RingsForHomalg#top
<!-- END FOOTER -->

[Singular]: https://www.singular.uni-kl.de/

[Macaulay2]: http://www2.macaulay2.com/Macaulay2/

[MAGMA]: http://magma.maths.usyd.edu.au/magma/

[Maple]: https://maplesoft.com/products/Maple/

[Sage]: https://www.sagemath.org/
