tests = [
	'Gauss',
	'ExamplesForHomalg',
	'GaussForHomalg',
	'GradedModules',
	'HomalgToCAS',
	'GradedRingForHomalg',
	'IO_ForHomalg',
	'LocalizeRingForHomalg',
	'MatricesForHomalg',
	'RingsForHomalg',
	'SCO',
	'Modules',
	'homalg',
	'AbelianSystems',
	'alexander',
	'CAP_project',
	'Conley',
	'D-Modules',
	'k-Points',
	'Orbifolds',
	'Sheaves',
	'SimplicialObjects',
	'SystemTheory',
	'VirtualCAS',
	'test_suite_D-Modules',
	'test_suite_ExamplesForHomalg_GAP',
	'test_suite_ExamplesForHomalg_Macaulay',
	'test_suite_ExamplesForHomalg_MAGMA',
	'test_suite_ExamplesForHomalg_maple',
	'test_suite_ExamplesForHomalg_Singular',
	'test_suite_GradedModules_Macaulay',
	'test_suite_GradedModules_MAGMA',
	'test_suite_GradedModules_maple',
	'test_suite_GradedModules_Singular',
	'test_suite_MapleForHomalg',
	'test_suite_RingsForHomalg',
	'test_suite_Sheaves_Macaulay',
	'test_suite_Sheaves_MAGMA',
	'test_suite_Sheaves_maple',
	'test_suite_Sheaves_Singular',
]

pipeline {
	agent any

	triggers {
		cron(env.BRANCH_NAME == 'master' ? '00 04 * * *' : '')
	}

	options {
		checkoutToSubdirectory('pkg/homalg_project')
	}

	stages {
		stage('test') {
			steps {
				dir('pkg/homalg_project') {
					sh 'TERM=dumb make -j $(nproc) --output-sync ci-test'
				}
			}
		}
	}

	post {
		success {
			script {
				tests.each { item ->
					plot csvFileName: "plot-${item}-cpu-time.csv",
						title: "${item} CPU Time",
						group: "homalg performance",
						style: "line",
						csvSeries: [[ file: "pkg/${item}_cpu_time.csv" ]]

					plot csvFileName: "plot-${item}-real-time.csv",
						title: "${item} Real Time",
						group: "homalg performance",
						style: "line",
						csvSeries: [[ file: "pkg/${item}_real_time.csv" ]]
				}
			}

			cleanWs()
		}
	}
}
