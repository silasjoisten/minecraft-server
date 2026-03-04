# Use the official OpenJDK as the base image for running Java applications
FROM openjdk:21-jdk-slim

RUN apt-get update \
    && apt-get install wget --yes

# Set environment variables (You can customize these)
ENV MINECRAFT_VERSION=1.21.11
ENV SERVER_URL=https://piston-data.mojang.com/v1/objects/64bb6d763bed0a9f1d632ec347938594144943ed/server.jar
ENV PAPER_DOWNLOAD_URL=https://fill-data.papermc.io/v1/objects/367f5088c7cc5c8f83cbededf4760622d4a27425be45611d3db6f11c75fac901/paper-1.21.11-126.jar
ENV EULA=true
ENV MEMORY=2G

# Create a directory for the Minecraft server
WORKDIR /opt/minecraft
RUN chown -R www-data:www-data /opt/minecraft

# Download the Minecraft server.jar file
RUN wget -O /server.jar $SERVER_URL \
    && chown www-data:www-data /server.jar

# Download the Minecraft paper.jar file

RUN wget -O /paper.jar $PAPER_DOWNLOAD_URL \
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
