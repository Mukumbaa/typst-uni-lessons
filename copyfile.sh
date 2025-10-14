#!/bin/bash

install -D ../CRY/cry.typ ./CRY/cry.typ
install -D ../DS/ds.typ ./DS/ds.typ

git add .
git commit -m updates
git push origin main
