pipeline{
    agent none

    parameters{
        string(name: 'tag', defaultValue: "", description: "The version of petclinic application")
        booleanParam(name: 'upload2artifactory', defaultValue: true, description: 'upload Image to artifactory')
        booleanParam(name: 'with_tests', defaultValue: true, description: 'run with tests')
    }  

    stages{
        
        stage('checkout'){ 
            agent {label 'java_build_agent'}
            steps{
                sh "rm -rf spring-petclinic"
                sh "git clone https://github.com/spring-projects/spring-petclinic.git"
                sh "git clone https://github.com/lavieshachar/jf-home-test.git"
            }
        }
        
        stage('compile'){
            agent {label 'java_build_agent'}
            steps{
                dir('spring-petclinic') {
                   sh "./mvnw clean compile"
                }
            }
        }
        
        stage('test'){
            agent{label 'java_build_agent'}
            when { environment name: 'with_tests', value: 'true'}
            steps{
                dir('spring-petclinic') {
                   sh "./mvnw test"
                }
            }
             
             post {
                always {
                    junit '**/target/surefire-reports/TEST-*.xml'
                }
            }
        }
        
        stage('package'){
            agent{label 'java_build_agent'}
            steps{
                dir('spring-petclinic') {
                   sh "./mvnw package"
                }
            }
        }

        stage('build dockerFile'){
            agent {label 'java_build_agent'}
            steps{
                dir('jf-home-test') {
                    sh "docker build . -t petclinic:${params.tag}"
                }
            }
        }
        
        stage('push to jf-artifactory'){
            when { environment name: 'upload2artifactory', value: 'true'}
            agent {label 'java_build_agent'}
            steps {
                sh "docker image push jfrog_artifactory:5000/petclinic/petclinic:${params.tag}"
            }
        }
    }
}
