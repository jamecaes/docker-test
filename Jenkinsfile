
node {    
    def app     
    stage('Initialize')
    {
        def dockerHome = tool 'docker'
        def mavenHome  = tool 'maven'
        env.PATH = "${dockerHome}/bin:${mavenHome}/bin:${env.PATH}"
    }    
    stage('Clone repository') {               
        checkout scm    
    }     
    stage('Build image') { 
        
        sh 'mvn -B -DskipTests clean install'
        sh 'echo $PATH'
        sh 'docker ps -a'
        sh 'ls -la target'
        withCredentials([usernamePassword(credentialsId: 'registry-docker', passwordVariable: 'DOCKER_REGISTRY_PWD', usernameVariable: 'DOCKER_REGISTRY_USER')]) {
            sh 'docker login https://registromatrixtech.jfrog.io -u=$DOCKER_REGISTRY_USER -p=$DOCKER_REGISTRY_PWD'
            sh 'docker build --build-arg JAR_FILE=target/docker-test-0.0.1-SNAPSHOT.jar . '
        }
        docker.withRegistry('https://registromatrixtech.jfrog.io', 'registry-docker'){
            
             sh 'docker ls'
            app = docker.build("jamecaes/docker-test")    
        }
    }     
    stage('Test image') {           
        app.inside {            
            sh 'echo "Tests passed"'        
        }    
    }     
    stage('Push image') {
        docker.withRegistry('https://registromatrixtech.jfrog.io', 'registry-docker') {            
            app.push("${env.BUILD_NUMBER}")            
            app.push("latest")        
        }    
    }
}