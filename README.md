# .github

Shared GitHub configuration for troyronda's public repositories. Experimental: the workflow's inputs will change.

- `.github/workflows/go.yml`: a reusable workflow for Go modules: gofmt, a `go mod tidy` diff check, `go vet`, staticcheck, govulncheck (with an optional ignore file) and race tests.
- `SECURITY.md`: the default security policy for repositories that don't have their own.

Callers use it at `@main`:

```yaml
jobs:
  go:
    uses: troyronda/.github/.github/workflows/go.yml@main
```

Third-party actions inside it are pinned by full commit SHA with the version as a comment; Dependabot bumps them monthly.

Built with the help of AI coding tools. Maintained by Troy Ronda.
