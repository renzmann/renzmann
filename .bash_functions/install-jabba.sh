install-jabba() {
  export JABBA_VERSION=0.11.2
  curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash -s -- --skip-rc
  load-funcs
}
