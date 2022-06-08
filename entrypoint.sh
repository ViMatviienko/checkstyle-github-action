#!/bin/sh

echo "Running check"

cd "${GITHUB_WORKSPACE}" || exit 1

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

exec java -jar /checkstyle.jar "${INPUT_WORKDIR}" -c "${INPUT_CHECKSTYLE_CONFIG}" ${OPT_PROPERTIES_FILE} -f xml \
 | reviewdog -f=checkstyle \
    -name="${INPUT_TOOL_NAME}" \
    -reporter="${INPUT_REPORTER:-github-pr-check}" \
    -filter-mode="${INPUT_FILTER_MODE:-added}" \
    -fail-on-error="${INPUT_FAIL_ON_ERROR:-false}" \
    -level="${INPUT_LEVEL}"