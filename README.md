# Home assinment project
It is a Jenkins pipeline that includes the following steps:
* Compile the code
* Run tests
* Package the project as a runnable Docker image
* Store the Docker image in JFrog artifactory

The source code for the task is [Spring pet-clinic](https://github.com/spring-projects/spring-petclinic).


# Running the project
What is needed in order to run the pipeline:
* Access to Jenkins application with the following plugins: 
  *  Docker
  *  Git


lable - add a lable to the designated jenkins agent/server which going to run this pipline - 'java_build_agent'
