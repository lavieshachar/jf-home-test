pipeline{
    
    agent any
    parameters{
        string(name: 'tag', defaultValue: "", description: "The version of petclinic application")
        booleanParam(name: 'upload2artifactory', defaultValue: true, description: 'upload Image to artifactory')
        booleanParam(name: 'with_tests', defaultValue: true, description: 'run with tests')
    }  

    stages{
        
        stage('checkout'){ 
            steps{
                sh "rm -rf *"
                sh "git clone https://github.com/spring-projects/spring-petclinic.git"
                sh "git clone https://github.com/lavieshachar/jf-home-test.git"
            }
        }
        
        stage('compile'){
            steps{
                dir('spring-petclinic') {
                   sh "./mvnw clean compile"
                }
            }
        }
        
        stage('test'){
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
            steps{
                dir('spring-petclinic') {
                   sh "./mvnw package"
                }
            }
        }

        stage('build dockerFile'){
            steps{
                dir('jf-home-test') {
                    sh "docker build . -t petclinic:${params.tag}"
                }
            }
        }
        
        stage('push to jf-artifactory'){
            when { environment name: 'upload2artifactory', value: 'true'}
            steps {
                sh "docker push jfrog_artifactory:5000/petclinic/petclinic:${params.tag}"
            }
        }
    }
}
