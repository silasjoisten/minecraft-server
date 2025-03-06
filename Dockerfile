# Use the official OpenJDK as the base image for running Java applications
FROM openjdk:21-jdk-slim

RUN apt-get update \
    && apt-get install wget --yes

# Set environment variables (You can customize these)
ENV MINECRAFT_VERSION=1.21.4
ENV EULA=true
ENV MEMORY=2G

# Create a directory for the Minecraft server
WORKDIR /opt/minecraft
RUN chown -R www-data:www-data /opt/minecraft

# Download the Minecraft server.jar file
RUN wget -O /server.jar https://piston-data.mojang.com/v1/objects/59353fb40c36d304f2035d51e7d6e6baa98dc05c/server.jar \
    && chown www-data:www-data /server.jar

# Download the Minecraft paper.jar file
RUN wget -O /paper.jar https://api.papermc.io/v2/projects/paper/versions/1.21.4/builds/190/downloads/paper-1.21.4-190.jar \
    && chown www-data:www-data /paper.jar

USER www-data

# Copy any additional files (like world data, mods, or plugins) to the container if necessary
# ADD ./world /opt/minecraft/world
# ADD ./mods /opt/minecraft/mods

COPY --chown=www-data ./start.sh /start.sh

# Expose the Minecraft server port
EXPOSE 25565

# Start the Minecraft server
CMD ["/start.sh"]
