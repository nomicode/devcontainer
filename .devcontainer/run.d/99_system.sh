#!/bin/sh -e

# Switch default root shell
sudo sed -i 's,/root:/bin/ash,/root:/bin/bash,' /etc/passwd
