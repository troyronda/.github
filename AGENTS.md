# Agents working in this repo

Shared, reusable GitHub Actions workflows and default community health files. Public.

## Test

```sh
scripts/test-private-terms.sh
```

CI runs it on every pull request, with actionlint on the workflows.

## Layout

- `.github/workflows/go.yml`, `.github/workflows/private-terms.yml`: reusable workflows (`on: workflow_call`).
- `.github/workflows/test.yml`: this repo's own CI.
- `scripts/`: scripts the reusable workflows run, checked out at the workflow's own commit.
- `SECURITY.md`: the default security policy.

## Rules

- Test fixtures are made up. Private-terms tests use invented terms only.
- No secrets in the repo, in tests or in logs. Nothing prints a matching private term.
- Dependencies: official actions or widely used, maintained ones, pinned by full commit SHA with the version as a comment. Tools are pinned by version, and downloaded binaries have their checksum verified.
- Tags stay at `v0.x`, are made only after every check passes, and never move.
