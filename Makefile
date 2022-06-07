PROJECT = hello_erlang
PROJECT_DESCRIPTION = New project
PROJECT_VERSION = 0.1.0

DEPS = cowboy jiffy
dep_cowboy_commit = 2.9.0


DEP_PLUGINS = cowboy, jiffy

BUILD_DEPS += relx
include erlang.mk
