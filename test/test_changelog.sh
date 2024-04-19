#!/bin/bash
set -o pipefail
# set -e # Exit immediately on error
# set -u # Exit on undefined variables
# set -x # Print commands and their arguments as they are executed
# set -o pipefail # Exit on failures in piped commands.

VERSION="1.1.0"
IFS='' read -r -d '' CHANGELOG_1 <<EOF
# Changelog

## $VERSION (date)

### Features

- one
EOF

IFS='' read -r -d '' CHANGELOG_2 <<EOF
$CHANGELOG_1
## 0.0.1 (older date)

### Bug Fixes

- fix
EOF

IFS='' read -r -d '' EXPECTED <<EOF
### Features

- one
EOF

perl="local \$/;<STDIN>=~m/^## \Q$VERSION\E .*?\n\n(.*?)\n(^## |\z)/ms && print \$1;"

IFS= read -rd '' RESULT_1 < <(echo "$CHANGELOG_1" | perl -e "$perl")
IFS= read -rd '' RESULT_2 < <(echo "$CHANGELOG_2" | perl -e "$perl")

echo "Regex should match when only one release is present"
if [[ "$RESULT_1" == "$EXPECTED" ]]; then echo "OK"; else echo "failed"; echo -e "Expected\n>>>$EXPECTED<<<, but was\n>>>$RESULT_1<<<"; fi
echo "Regex should match when multiple releases are present"
if [[ "$RESULT_2" == "$EXPECTED" ]]; then echo "OK"; else echo "failed"; echo -e "Expected\n>>>$EXPECTED<<<, but was\n>>>$RESULT_2<<<"; fi
