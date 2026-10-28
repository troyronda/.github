# .github

Shared GitHub configuration for troyronda's public repositories. Experimental: the workflows' inputs will change.

- `.github/workflows/go.yml`: a reusable workflow for Go modules: gofmt, a `go mod tidy` diff check, `go vet`, staticcheck, govulncheck (with an optional ignore file), race tests, and gitleaks (the gitleaks program at a pinned version, checksum verified).
- `.github/workflows/private-terms.yml`: a reusable workflow that fails if the repository, its commit messages or the pull request title or body contain a term from the caller's `PRIVATE_TERMS` secret. Without the secret it skips with a notice, so pull requests from forks pass.
- `scripts/has-private-term` and its tests: the matcher the private-terms workflow runs.
- `SECURITY.md`: the default security policy for repositories that don't have their own.

Callers pin a full commit SHA, with the version as a comment:

```yaml
jobs:
  go:
    uses: troyronda/.github/.github/workflows/go.yml@<sha> # v0.1.0
  private-terms:
    uses: troyronda/.github/.github/workflows/private-terms.yml@<sha> # v0.1.0
    secrets:
      PRIVATE_TERMS: ${{ secrets.PRIVATE_TERMS }}
```

Tags are never moved.

Built with the help of AI coding tools. Maintained by Troy Ronda.
