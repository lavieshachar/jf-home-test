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
                //sh 'mkdir -p .m2/repository'
            }
        }
         stage('build and test petclinic'){
           agent{
                docker{
                    image 'maven:3.8.6-openjdk-11'
                    label 'java_build_agent'
                    //args '-v $WORKSPACE/.m2/repository:/root/.m2'
                }
            }
            steps{
                dir('spring-petclinic') {
                   sh "mvn clean compile"
                   sh "mvn test"
                   sh "mvn package"
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
