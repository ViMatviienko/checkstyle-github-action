#!/bin/sh

echo "Getting tools"

cd "${GITHUB_WORKSPACE}" || exit 1

sudo wget -O /checkstyle.jar https://github.com/checkstyle/checkstyle/releases/download/checkstyle-${CHECKSTYLE_VERSION}/checkstyle-${CHECKSTYLE_VERSION}-all.jar?raw=true
wget -O - -q --header='Authorization: token '${PAT} https://raw.githubusercontent.com/ViMatviienko/review_modified/dev/install.sh| sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}

echo "Running check"

export REVIEWDOG_INSECURE_SKIP_VERIFY=true

exec java -jar /checkstyle.jar "${INPUT_WORKDIR}" -c "${INPUT_CHECKSTYLE_CONFIG}" -f xml \
 | reviewdog -f=checkstyle \
    -name="${INPUT_TOOL_NAME}" \
    -reporter="${INPUT_REPORTER:-github-pr-check}" \
    -filter-mode="${INPUT_FILTER_MODE:-added}" \
    -fail-on-error="${INPUT_FAIL_ON_ERROR:-false}" \
    -level="${INPUT_LEVEL}"