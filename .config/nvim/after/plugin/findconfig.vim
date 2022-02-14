if $ALG_VER != ""
  command! FindConfig execute "find config-$ALG_VER.yml"
  command! FindMakefile execute "find Makefile-$ALG_VER"
end
