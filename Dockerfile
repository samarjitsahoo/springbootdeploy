# Stage 1: Build stage
FROM maven:3.8.5-openjdk-17 AS build

# Copy the project files into the container
COPY . .

# Run Maven to build the project, skipping tests
RUN mvn clean package -DskipTests

# Stage 2: Run stage
FROM openjdk:17.0.1-jdk-slim

# Copy the build artifact from the build stage
COPY --from=build /target/springbootdeploy-0.0.1-SNAPSHOT.jar springbootdeploy.jar

# Run the application
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "springbootdeploy.jar"]
