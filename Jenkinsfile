
node {    
    def app     
    stage('Initialize')
    {
        dockerTool 'docker'
        echo "load docker tool"
        def dockerHome = tool 'docker'
        def mavenHome  = tool 'maven'
        env.PATH = "${dockerHome}/bin:${mavenHome}/bin:${env.PATH}"
        echo "${dockerHome}/bin:"
        def maven = docker.image('maven:latest')
        maven.pull()
        echo "despues de docker"
        docker.withRegistry('https://registromatrixtech.jfrog.io', 'registry-docker'){
            
            echo "login registry"
        }
    }    
    stage('Clone repository') {               
        checkout scm    
    }     
    stage('Build image') { 
        
        sh 'mvn clean install'
        withCredentials([usernamePassword(credentialsId: 'registry-docker', passwordVariable: 'DOCKER_REGISTRY_PWD', usernameVariable: 'DOCKER_REGISTRY_USER')]) {
            sh 'docker login https://registromatrixtech.jfrog.io -u=$DOCKER_REGISTRY_USER -p=$DOCKER_REGISTRY_PWD'
            sh 'docker build --build-arg JAR_FILE=target/docker-test-0.0.1-SNAPSHOT.jar . '
            
        }
            echo "antes del login"
        docker.withRegistry('https://registromatrixtech.jfrog.io', 'registry-docker'){
            
            echo "con login"
            sh 'docker ps'
            echo "antes de buid jamecaes"
            app = docker.build("jamecaes/docker-test")    
        }
        echo "despues de login"

    }     
    stage('Test image') {           
            echo "antes de inside"
        app.inside {            
            sh 'echo "Tests passed"'        
        }    
    }     
    stage('Push image') {
            echo "antes de push"
        docker.withRegistry('https://registromatrixtech.jfrog.io', 'registry-docker') {            
            app.push("${env.BUILD_NUMBER}")            
            app.push("latest")        
        }    
    }
}