if exists("current_compiler")
    finish
endif
let current_compiler = "mypy"


if exists(":CompilerSet") != 2 " older Vim always used :setlocal
    command -nargs=* CompilerSet setlocal <args>
endif


CompilerSet makeprg=mypy\ --check-untyped-defs\ --ignore-missing-import\ \"%:p:h\"
CompilerSet errorformat=
            \%E%f:%l:\ error:\ %m,
            \%I%f:%l:\ note:\ %m
