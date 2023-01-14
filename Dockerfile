FROM maven:3-openjdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app/pom.xml
WORKDIR /home/app
RUN mvn clean install

FROM openjdk:11-jre-slim
COPY --from=build /home/app/target/*.war app.war
EXPOSE 9000
ENTRYPOINT ["java", "-jar", "app.war"]