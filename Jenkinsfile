pipeline {
	agent any

	triggers {
		cron('00 04 * * *')
	}

	options {
		checkoutToSubdirectory('pkg/homalg_project')
	}

	stages {
		stage('test') {
			steps {
				dir('pkg/homalg_project') {
					sh 'TERM=dumb make -j 4 --output-sync ci-test'
				}
			}
		}
	}

	post {
		success {
			plot csvFileName: 'plot-homalg-performance.csv',
			group: 'homalg performance',
			style: 'line',
			csvSeries: [[
				file: 'pkg/performance_data.csv',
				exclusionValues: '',
				displayTableFlag: true,
				inclusionFlag: 'OFF',
			url: '']]

			cleanWs()
		}
	}
}
