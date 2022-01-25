install-jabba() {
  echo "JABBA_VERSION=$JABBA_VERSION"
  curl -sL https://github.com/shyiko/jabba/raw/master/install.sh \
    | bash -s -- --skip-rc \
    && . ~/.jabba/jabba.sh
}
