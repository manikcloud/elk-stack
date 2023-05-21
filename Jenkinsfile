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

    stage('Deploy') {
        sh ("docker ps -q --filter ancestor=${dockerhubaccountid}/${application} | xargs -r docker stop")  // stop the existing container if it's running
        sh ("docker ps -a -q --filter ancestor=${dockerhubaccountid}/${application} | xargs -r docker rm")   // remove the existing container if it exists
        sh ("docker run -d -p 81:8080 -v /var/log/:/var/log/ ${dockerhubaccountid}/${application}:${BUILD_NUMBER}")
    }
    
    stage('Remove old images') {
        // remove docker old images
        sh('docker rmi $(docker images -q ' + dockerhubaccountid + '/' + application + ' | awk \'NR>3\') -f || true')
    }
}
