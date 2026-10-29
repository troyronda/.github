# Agents working in this repo

A shared, reusable GitHub Actions workflow for Go modules, and default community health files. Public.

## Test

CI runs actionlint on every pull request. Locally: `go run github.com/rhysd/actionlint/cmd/actionlint@v1.7.12`.

## Layout

- `.github/workflows/go.yml`: the reusable workflow (`on: workflow_call`). Callers use it at `@main`.
- `.github/workflows/test.yml`: this repo's own CI.
- `SECURITY.md`: the default security policy.

## Rules

- No secrets in the repo or in logs.
- Dependencies: official actions or widely used, maintained ones, pinned by full commit SHA with the version as a comment. Tools are pinned by version.
