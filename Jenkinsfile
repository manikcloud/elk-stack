node {
	def application = "springbootapp"
	def dockerhubaccountid = "varunmanik"
	stage('Clone repository') {
		checkout scm
	}

	stage('Build image') {
		def app
		docker.withRegistry('', 'dockerHub') {
			app = docker.build("${dockerhubaccountid}/${application}:${BUILD_NUMBER}")
		}
	}

	stage('Push image') {
		docker.withRegistry('', 'dockerHub') {
			app.push("${BUILD_NUMBER}")
			app.push("latest")
		}
	}

	stage('Deploy') {
		sh ("docker run -d -p 81:8080 -v /var/log/:/var/log/ ${dockerhubaccountid}/${application}:${BUILD_NUMBER}")
	}

	stage('Remove old images') {
		// remove docker old images
		sh("docker rmi ${dockerhubaccountid}/${application}:latest -f")
	}
}
