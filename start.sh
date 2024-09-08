#!/bin/sh

cp /server.jar /opt/minecraft/server.jar # Copy the server.jar to the correct location

echo eula=$EULA > /opt/minecraft/eula.txt # Accept the Minecraft EULA

java -Xmx$MEMORY -Xms$MEMORY -jar /opt/minecraft/server.jar nogui
