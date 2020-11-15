FROM maven:3.5.2-jdk-8-alpine
CMD [ "ls" ]
COPY pom.xml /maven-build/
COPY src/ /maven-build/src/
WORKDIR /maven-build/
RUN mvn package -Dmaven.artifact.threads=30

FROM openjdk:8-jdk
WORKDIR /root/
COPY --from=0 /maven-build/target/spring-0.0.1-SNAPSHOT.jar .
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "spring-0.0.1-SNAPSHOT.jar"]
