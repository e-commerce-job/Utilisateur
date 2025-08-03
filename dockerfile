# Étape 1 : Image de build avec Maven + Java 17
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app

# Copie le code source dans le conteneur
COPY . .

# Compile et package sans exécuter les tests
RUN mvn clean package -DskipTests

# Étape 2 : Image d'exécution plus légère
FROM eclipse-temurin:17-jdk
WORKDIR /app

# Copie le .jar depuis l'étape précédente
COPY --from=build /app/target/*.jar app.jar

# Lance l'application
ENTRYPOINT ["java", "-jar", "app.jar"]