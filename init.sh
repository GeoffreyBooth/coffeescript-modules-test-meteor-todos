#!/usr/bin/env bash


# Some colors, per http://stackoverflow.com/a/5947802/223225
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color


# Install build dependencies, if necessary
if ! hash meteor 2>/dev/null; then
	curl https://install.meteor.com/ | sh
fi

if ! hash coffee 2>/dev/null; then
	npm install -g coffee-script
fi

if ! hash cake 2>/dev/null; then
	npm install -g cake
fi


# Build todos
cd todos
printf "${GREEN}Installing regular NPM packages...${NC}\n"
meteor npm install

# Manually add the NPM packages that experimental-coffeescript depends on, so that we can swap in our experimental coffeescript module
printf "${GREEN}Installing experimental NPM packages...${NC}\n"
cd ./packages/experimental-coffeescript/.npm/plugin/compileCoffeescript
mkdir node_modules
cd node_modules

# Fake what npm install / shrinkwrap does, so that Meteor doesn’t overwrite our packages
echo 'v4.5.*' > .node_version
cat << EOF > .npm-shrinkwrap.json
{
  "dependencies": {
    "coffee-script": {
      "version": "1.10.0",
      "resolved": "https://registry.npmjs.org/coffee-script/-/coffee-script-1.10.0.tgz",
      "from": "coffee-script@1.10.0"
    },
    "source-map": {
      "version": "0.5.6",
      "resolved": "https://registry.npmjs.org/source-map/-/source-map-0.5.6.tgz",
      "from": "https://registry.npmjs.org/source-map/-/source-map-0.5.6.tgz"
    }
  }
}
EOF

git clone https://github.com/mozilla/source-map.git
echo 'true' > ./source-map/.meteor-portable # More fakery

git clone https://github.com/GeoffreyBooth/coffeescript.git
mv coffeescript coffee-script
cd coffee-script
git checkout import-export
npm install
cake build && cake build:parser
echo 'true' > .meteor-portable

printf "${GREEN}Done! Now let’s see how Meteor compiles this app...${NC}\n"
pwd
cd ../../../../../../../
meteor
