pipeline {
	agent any

	options {
		checkoutToSubdirectory('pkg/homalg_project')
	}

	stages {
		stage('doc') {
			steps {
				dir('pkg/homalg_project') {
					sh 'TERM=dumb make doc'
				}
			}
		}

		stage('build') {
			steps {
				dir('pkg/homalg_project') {
					sh 'TERM=dumb make build'
				}
			}
		}

		stage('test') {
			steps {
				dir('pkg/homalg_project') {
					sh 'TERM=dumb make ci-test'
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
				file: 'pkg/homalg_project/performance_data.csv',
				exclusionValues: '',
				displayTableFlag: true,
				inclusionFlag: 'OFF',
			url: '']]

			cleanWs()
		}
	}
}
