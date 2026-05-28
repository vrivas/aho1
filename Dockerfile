# Etapa 1: Compilación
FROM maven:3.9.6-eclipse-temurin-21 as builder

WORKDIR /app

# Copiar archivos del proyecto
COPY codigo-app/ .

# Compilar y empaquetar la aplicación
RUN mvn clean package -DskipTests

# Etapa 2: Ejecución
FROM eclipse-temurin:21-jre-jammy

WORKDIR /app

# Copiar el JAR compilado desde la etapa anterior
COPY --from=builder /app/target/*.jar app.jar

# Configurar variables de entorno
ENV JAVA_OPTS="-Xmx512m -Xms256m"

# Exponer puerto (si la aplicación lo usa)
EXPOSE 8080

# Ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "app.jar"]
