pipeline{
    agent none
    parameters{
        text(name: 'tag', defaultValue: "", description: "The version of petclinic application")
        booleanParam(name: 'upload2artifactory', defaultValue: true, description: 'upload Image to artifactory')
    }
    
    cleanWs() 

    stages{
        stage('checkout'){ 
            agent {label 'java_build_agent'}
            steps{
                sh "git clone https://github.com/spring-projects/spring-petclinic.git"
            }
        }
         stage('build and test petclinic'){
           agent{
                docker{
                    image 'maven:3.6.3-openjdk-11'
                    label 'java_build_agent'
                }
            }
            steps{
                dir('spring-petclinic') {
                   sh "./mvnw package"
                }
            }
        }

         stage('build and push'){
            agent {label 'java_build_agent'}
            steps{
                dir('spring-petclinic') {
                    sh "docker build petclinic:${params.tag} ."
                    sh "docker image push jfrog_artifactory:5000/petclinic/petclinic:${params.tag} "
                }
            }
        }
    }
}
