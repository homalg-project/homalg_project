## How to add a package to the CI
This section explains how to add a package `MyPackage` to the homalg CI. It assumes some basic knowledge about
[makefiles](https://www.gnu.org/software/make/manual/make.html) in general and
[writing makefile rules](https://www.gnu.org/software/make/manual/make.html#Rule-Introduction) in particular.

This basic idea of the CI is the following: The CI calls `make ci-test` in the `homalg_project` main directory.
The make target `ci-test` depends on other make targets of the form `ci-test_MyPackage`.
`ci-test_MyPackage` then actually executes the tests of `MyPackage` and exits with an nonzero exit code iff errors occur during the tests.

*Note:* In what follows, all references to files are relative to the `homalg_project` main directory and prefixed with `./`.

1. If `MyPackage` is not part of `homalg_project`: Download (and if necessary extract) it in `./ci_prepare`.
   Note: If `MyPackage` is available under `homalg-project` on GitHub, it suffices to add `MyPackage` to the list
   `PACKAGES_TO_CLONE` in `./ci_prepare`.
2. If `MyPackage` requires a build:
    * Add a suitable make target `build_MyPackage` in `./makefile`.
    * Add `build_MyPackage` to the prerequisites of the make target `build` in `./makefile`.
3. Add a make target `ci-test_MyPackage` in `./makefile` which executes the tests of `MyPackage` and
   exits with an nonzero exit code iff an error occurs during the test.
    * For example, if `MyPackage` already has a make target `ci-test`, simply execute it.
    * If `MyPackage` is not part of `homalg_project`, add the make target `ci-prepare` to the prerequisites of `ci-test_MyPackage`.
    * If `MyPackage` requires a build, add `build_MyPackage` to the prerequisites of `ci-test_MyPackage`.
    * If the tests of `MyPackage` depend on Singular, Maple, etc., wrap the call of the tests in
	  `ifneq ($(SINGULAR_PATH),)`, `ifneq ($(MAPLE_PATH),)`, etc. (see existing make targets for details).
4. Add `ci-test_MyPackage` to the prerequisites of the make target `ci-test_additional_packages` in `./makefile`.
5. If performance data should be made available in Jenkins:
    * Prepend the call of the tests of `MyPackage` with `/usr/bin/time --quiet --format="%U %S\n%e" --output=performance.out`.
	  For example, if `MyPackage` already has a make target `ci-test` calling `gap ...`, simply replace this call by
	  `/usr/bin/time --quiet --format="%U %S\n%e" --output=performance.out gap ...`.
    * Note: the output file `performance.out` must be generated inside the directory `MyPackage`,
	  so adjust the path in the call to `/usr/bin/time` if necessary.
    * Add `MyPackage` to the list `tests` in `./Jenkinsfile`.

## How to add a package to the "lines of code" graph
1. Add your repository to the file `clone_repos.sh` in the repository `homalg_stats`.
2. Execute `cumlated_stats.py` (requires `gnuplot`).
3. View `lines_of_code.png` and compare it with the [upstream file](https://algebra.mathematik.uni-siegen.de/img/lines_of_code.png).
   If any unexpected jumps etc. occur, seek help.
