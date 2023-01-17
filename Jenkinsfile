pipeline{
    
    agent any
    parameters{
        string(name: 'tag', defaultValue: "version-xxx", description: "The version of petclinic application")
        booleanParam(name: 'upload2artifactory', defaultValue: true, description: 'upload Image to artifactory')
        booleanParam(name: 'test', defaultValue: true, description: 'run with tests')
    }  

    stages{
        stage('Checkout'){ 
            steps{
                sh "rm -rf *"
                sh "git clone https://github.com/spring-projects/spring-petclinic.git"
                sh "git clone https://github.com/lavieshachar/jf-home-test.git"
                sh "mv jf-home-test/Dockerfile spring-petclinic/Dockerfile
            }
        }
        
        stage('Compile'){
            steps{
                dir('spring-petclinic') {
                   sh "./mvnw clean compile"
                }
            }
        }
        
        stage('Test'){
            when { environment name: 'test', value: 'true'}
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
        
        stage('Package'){
            steps{
                dir('spring-petclinic') {
                   sh "./mvnw package"
                }
            }
        }

        stage('build dockerFile'){
            steps{
                dir('spring-petclinic') {
                    sh "docker build . -t shacharlav10/pet-clinic:${params.tag}"
                }
            }
        }
        
        stage('Push to dockerhub'){
            steps {
                sh "docker push shacharlav10/pet-clinic:${params.tag}"
            }
        }
        
        stage('Push to jf-artifactory'){
            when { environment name: 'upload2artifactory', value: 'true'}
            steps {
                sh "docker push jfrog_artifactory:5000/petclinic/petclinic:${params.tag}"
            }
        }
    }
}
