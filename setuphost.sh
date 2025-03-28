#!/bin/bash

# Allow connections from local Docker containers to X server
xhost +local:

# Check if X server is running and accessible
if [ -z "$DISPLAY" ]; then
  echo "ERROR: DISPLAY environment variable not set."
  echo "Make sure X server is running on your host machine."
  exit 1
else
  echo "X server is running on display $DISPLAY"
fi

# Test X server accessibility
echo "Testing X server accessibility..."
xdpyinfo > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "X server is accessible. You should be able to run GUI applications in Docker."
else
  echo "ERROR: Cannot access X server. Check if X server is running properly."
  exit 1
fi

echo "Setup complete. You can now start your Docker container."