#!/bin/bash

source blog/.venv/bin/activate
cd blog/
git pull -q
pelican -q | grep -v ^Done
cp -r output/* /var/www/www.pwnguin.net

