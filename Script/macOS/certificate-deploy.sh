#!/bin/sh

cert = ""

security add-trusted-cert -d -r trustAsRoot -k /Library/Keychains/System.keychain $cert