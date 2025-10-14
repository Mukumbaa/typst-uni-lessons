#!/bin/bash

cp ../CRY/cry.typ .CRY/cry.typ
cp ../DS/ds.typ .DS/ds.typ

git add .
git commit -m updates
git push origin main
