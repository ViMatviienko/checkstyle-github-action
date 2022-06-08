# checkstyle-github-action

This action uses an automated code review tool [reviewdog](https://github.com/reviewdog/reviewdog) which runs [checkstyle](https://github.com/checkstyle/checkstyle) code analysis tool on pull request and posts review comments under each line of code that doesn't cope with the established coding standard.

reviewdog runs only for diff like Pull-Request, not whole code base.

## How to use
```yaml
on: pull_request

jobs:
  checkstyle_job:
    runs-on: ubuntu-latest
    name: Checkstyle job
    steps:
      - name: Checkout
        uses: actions/checkout@v3
      - name: Run checkstyle
        uses: ViMatviienko/checkstyle-github-action@main
        with:
          github_token: ${{ github.token }}
          reporter: 'github-pr-review'
          checkstyle_config: ${{ github.workspace }}/filepath/cloud.xml
```
## Example usage
[test-checkstyle-github-action](https://github.com/ViMatviienko/test-checkstyle-github-action/pull/4)

