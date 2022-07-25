#!bash

if [[  =~ v[0-9]+\.[0-9]+\.0\.[0-9]+ ]]; then
  echo "Valid tagname, continue release"
else
  echo "Invalid tagname, needs doesn't follow pattern: v<Semver>"
  exit 1
fi
