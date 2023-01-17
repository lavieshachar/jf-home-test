FROM openjdk:11-jre-slim

ADD target/*.jar /opt/petclinic/petclinic.jar

CMD java -jar /opt/petclinic/petclinic.jar
