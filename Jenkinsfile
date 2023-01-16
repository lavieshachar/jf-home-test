pipeline{
    agent none
    options{skipDefaultCheckout()}
    parameters{
        string(name: 'tag', defaultValue: "", description: "The version of petclinic application")
        booleanParam(name: 'upload2artifactory', defaultValue: true, description: 'upload Image to artifactory')
    }  

    stages{
        stage('checkout'){ 
                agent {label 'java_build_agent'}
            steps{
                sh "rm -rf spring-petclinic"
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
                   sh "./mvnw clean compile"
                   sh "./mvnw test"
                   sh "./mvnw package"
                }
            }
             
             post {
                always {
                    junit '**/target/surefire-reports/TEST-*.xml'
                }
            }
        }

         stage('build dockerFile'){
            agent {label 'java_build_agent'}
            steps{
                dir('spring-petclinic') {
                    sh "docker build petclinic:${params.tag} ."
                }
            }
        }
        
        stage('push to jf-artifactory'){
            when  { environment name: 'upload2artifactory', value: 'true'}
            agent {label 'java_build_agent'}
            steps{
                sh "docker image push jfrog_artifactory:5000/petclinic/petclinic:${params.tag} "
            }
        }
    }
}
