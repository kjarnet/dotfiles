function npm-clean-install () {
  git checkout -- package-lock.json && rm -rf node_modules && npm i
}

alias npr='npm run'

