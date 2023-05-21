node {
    def application = "springbootapp"
    def dockerhubaccountid = "varunmanik"
    def app  // defining app variable here to be globally accessible

    stage('Clone repository') {
        checkout scm
    }

    stage('Build image') {
        app = docker.build("${dockerhubaccountid}/${application}:${BUILD_NUMBER}")
    }

    stage('Push image') {
        withDockerRegistry([ credentialsId: "dockerHub", url: "" ]) {
            app.push()
            app.push("latest")
        }
    }
    stage('Remove old Container') {
            // remove docker old images
            sh("docker rm springboot -f")
        }

    stage('Deploy') {
        sh ("docker run -d -p 81:8080 -v /var/log/:/var/log/ --name=springboot ${dockerhubaccountid}/${application}:${BUILD_NUMBER}")
    }


        
    stage('Remove old images') {
        // remove docker old images
        sh("docker rmi ${dockerhubaccountid}/${application}:latest -f")
    }

}
