xhost +
docker run -it \
  --volume=/tmp/.X11-unix:/tmp/.X11-unix \
  --device=/dev/dri:/dev/dri \
  --device=/dev/fb0:/dev/fb0 \
  -v /opt/vc:/opt/vc \
  -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket \
  --device=/dev/vchiq:/dev/vchiq \
  --device=/dev/fb0:/dev/fb0 \
  --device=/dev/vcio:/dev/vcio \
  --device=/dev/vcsm:/dev/vcsm \
  --device=/dev/vc-mem:/dev/vc-mem \
  --env="DISPLAY=$DISPLAY" \
  --privileged \
  --device=/dev/video0:/dev/video0 \
     pupil-pi \
    bash
