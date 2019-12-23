FROM alpine/git as CLONE
ARG url
WORKDIR /app
RUN git clone ${url}

FROM maven:3.6-jdk-8 as BUILD
ARG project
WORKDIR /app
COPY --from=CLONE /app/${project} /app
RUN echo "=> Build base image"
RUN mvn package -DskipTests=true

FROM openjdk:8-jre-alpine
ARG artifactid
ARG version
ENV artifact ${artifactid}-${version}.BUILD-SNAPSHOT.jar
WORKDIR /app
COPY --from=BUILD /app/target/${artifact} /app
EXPOSE 8080
ENTRYPOINT ["sh", "-c"]
CMD ["java -Dspring.profiles.active=mysql -jar ${artifact}"]
