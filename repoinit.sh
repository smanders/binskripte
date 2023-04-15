#!/bin/bash
cd "$( dirname "$0" )"
source $1
if [[ -z $ORG || -z $REPOS || -z $SRCDIR ]]; then
  echo "$1 must define ORG REPOS SRCDIR"
  exit
fi
if [ ! -d "$SRCDIR" ]; then
  mkdir --parents $SRCDIR
fi
pushd $SRCDIR >/dev/null
for repo in $REPOS
do
  if [ ! -d "${repo}" ]
  then
    echo ==== ${repo} ====
    git clone ${ORG}/${repo}
    pushd ${repo} >/dev/null
    branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
    if [ "${branch}" != "development" ]; then
      git checkout -b development origin/development
    fi
    if [ -f ".gitmodules" ]; then
      git submodule init
      git submodule update
    fi
    popd >/dev/null
  fi
done
popd >/dev/null
