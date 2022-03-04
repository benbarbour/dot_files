# set DISPLAY to use X terminal in WSL
# in WSL2 the localhost and network interfaces are not the same than windows
if grep -q WSL2 /proc/version; then
    # execute route.exe in the windows to determine its IP address
    DISPLAY=$(route.exe print | grep 0.0.0.0 | head -1 | awk '{print $4}'):0.0
fi
