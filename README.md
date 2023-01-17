# Home assinment project
### Jenkins Pipeline
It's a Jenkins pipeline that includes the following steps:
* Checkout
  * clone spring-petclinic project 
* Compile
  * compile the code using mvnw executable file 
* Test
  * run the test and display the result on jenkins summary page
* Package
  * package the project as a runnable Docker image
* Push to jf-artifactory
  * Store the Docker image in JFrog artifactory

The source code for the task is [Spring pet-clinic](https://github.com/spring-projects/spring-petclinic).

# How to run the pipeline
### Prerequisites - What is needed in order to run the pipeline:
Access to Jenkins application with Git and Docker plugins. 

### Steps:
* choose the desirable params
* 
### Parameters
'tag' - tag/name the version of the application 
'test' - run the job with tests
'upload2artifactory' - upload image to artifactory
