FROM openjdk:17-slim

ADD target/*.jar /opt/petclinic/petclinic.jar

CMD java -jar /opt/petclinic/petclinic.jar
