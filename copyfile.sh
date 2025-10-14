#!/bin/bash

cp ../CRY/cry.typ ./cry.typ
cp ../DS/ds.typ ./ds.typ

git add .
git commit -m updates
git push origin main
