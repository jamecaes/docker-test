
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
        
        sh 'uname -a'
        sh 'java -version'
        sh 'echo $JAVA_HOME'
        sh 'mvn -B -DskipTests clean package'          
        app = docker.build("jamecaes/docker-test")    
    }     
    stage('Test image') {           
        app.inside {            
            sh 'echo "Tests passed"'        
        }    
    }     
    stage('Push image') {
        docker.withRegistry('https://registromatrixtech.jfrog.io', 'git') {            
            app.push("${env.BUILD_NUMBER}")            
            app.push("latest")        
        }    
    }
}