# Home assignment project
### Jenkins Pipeline
It's a Jenkins pipeline that includes the following steps:
* Checkout
   
   clone spring-petclinic project 
* Compile
   
   compile the code using mvnw executable file 
* Test
   
  run the test and display the result on jenkins summary page
* Package
  
  package the project as a runnable Docker image
* Push to dockerhub
   
   Store the Docker image in docker hub
* Push to jf-artifactory
   
   Store the Docker image in the JFrog artifactory that is given by jfrog_registry parameter

The source code for the task is [Spring pet-clinic](https://github.com/spring-projects/spring-petclinic).

# How to run the pipeline
### Prerequisites
* [Docker installed](https://docs.docker.com/get-docker/)
* [JFrog cloud subscription](https://jfrog.com/artifactory/start-free/)

### Steps to run the project:
* docker pull shacharlav10/pet-clinic:version-xxx
* docker container run -d --publish 8080:8080 shacharlav10/pet-clinic:version-xxx

### Parameters
* 'tag' - tag/name the version of the application 
* 'jfrog_registry' - JFrog artifactory registry name
* 'test' - run the job with tests
* 'upload2artifactory' - upload image to jf-artifactory
