# auto-commit-push

Automated Commit &amp; Push Action.

For example:

```yaml
name: Auto Commit & Push

on:
  workflow_dispatch:

permissions:
  pull-requests: write
  contents: write

jobs:
  auto-commit-push:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: commit-push
        uses: actions/auto-commit-push@v1
        with:
          name: Your Name
          email: your@email.com
          message: Commit Message
          branch: main
          target-url: https://github.com/user/repo.git
          target-username: user
          target-token: ${{ secrets.GITHUB_TOKEN }}
          co-authors: co-author1, co-author2
```

## Usage

### Inputs

| Name | Description | Required | Default |
| --- | --- | --- | --- |
| name | Your name | true | |
| email | Your email | true | |
| message | Commit message | true | |
| branch | Target branch | true | |
| target-url | Target repository URL | true | |
| target-username | Target repository username | true | |
| target-token | Target repository token | true | |
| co-authors | Co-authors (comma-separated) | false | |

### Outputs

None

## Example

```yaml
name: Auto Commit & Push

on:
  workflow_dispatch:

permissions:
  pull-requests: write
  contents: write

jobs:
  auto-commit-push:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: commit-push
        uses: actions/auto-commit-push@v1
        with:
          name: Your Name
          email: your@email.com
          message: Commit Message
          branch: main
          target-url: https://github.com/user/repo.git
          target-username: user
          target-token: ${{ secrets.GITHUB_TOKEN }}
          co-authors: co-author1, co-author2
```
