#!/bin/bash
for D in *; do [ -d "${D}" ] && pushd ${D} >/dev/null && echo ==== ${D} && $* && popd >/dev/null ; done
### examples
# foreach.sh git fetch --all
# foreach.sh git -c color.status=always status | less -R
# foreach.sh git remote show origin
# foreach.sh git stash list
