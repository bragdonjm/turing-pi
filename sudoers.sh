#!/bin/bash

USERS=$1

# Add a line to the sudoers file to enable passwordless sudo access for the specified user
# echo "$USERS ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

echo "$USERS ALL=(ALL) NOPASSWD:ALL" | sudo tee --append /etc/sudoers
