#!/usr/bin/env bash

indent() {
  sed -u 's/^/       /'
}

cache_copy() {
  rel_dir=$1
  from_dir=$2
  to_dir=$3
  rm -rf $to_dir/$rel_dir
  if [ -d $from_dir/$rel_dir ]; then
    mkdir -p $to_dir/$rel_dir
    cp -pr $from_dir/$rel_dir/. $to_dir/$rel_dir
  fi
}


export_env_dir() {
    env_dir=$1
    whitelist_regex=${2:-''}
    blacklist_regex=${3:-'^(PATH|GIT_DIR|CPATH|CPPATH|LD_PRELOAD|LIBRARY_PATH|JAVA_OPTS)$'}
    if [ -d "$env_dir" ]; then
        for e in $(ls $env_dir); do
            echo "$e" | grep -E "$whitelist_regex" | grep -qvE "$blacklist_regex" &&
                export "$e=$(cat $env_dir/$e)"
            :
        done
    fi
}