#!/usr/bin/env bash

# sudo nixos-rebuild switch -I nixos-config=configuration.nix

sudo nixos-rebuild switch --flake .\#`hostname` -L && home-manager switch --flake .\#`hostname` -L
