# config-linux
configuration files for linux

gpufan.sh
MSI 2080 Gaming X Trio likes it hot and I must force nvidia-settings to turn on the gpu fans. This should become a systemd service, but even better would be to allow real gpu fan curves. fancontrol(8) uses a simple linear algorithm as does this script, but better is possible. There should be different nodes that you can add to start a new curve from that point until the next node all done via cli. Rendering that curve, that could be done by anything.
