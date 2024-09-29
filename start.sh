#!/bin/sh

echo eula=$EULA > /opt/minecraft/eula.txt # Accept the Minecraft EULA

if [ "$PAPER" = "true" ]; then
  cp /paper.jar /opt/minecraft/server.jar # Copy the paper.jar to the correct location

  java -Xms$MEMORY -Xmx$MEMORY -jar /opt/minecraft/server.jar --nogui
else
  cp /server.jar /opt/minecraft/server.jar # Copy the server.jar to the correct location

  java -Xmx$MEMORY -Xms$MEMORY -jar /opt/minecraft/server.jar nogui
fi
