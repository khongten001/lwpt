# Program name expressed as a single constant, never hardcoded

The project name appears at dozens of sites in code (filenames in manifests/lockfiles/cfg files, error-message prefixes, modules-directory name, environment variables, banner output). We declare `PROGRAM_NAME = 'lwpt'` and `PROJECT_NAME = 'LWPT'` in `LWPT.Core` and derive every literal use of the name from them — `MANIFEST_FILE = PROGRAM_NAME + '.toml'`, error prefixes via `PROGRAM_NAME + ' install: '`, prose-format help text via `PROJECT_NAME`. The reason is that the project is mid-rename right now (from `lwptk`), and we want the next rename to be a one-line change rather than a multi-hundred-site find-replace; the same constants double as the canonical answer to "what does this project call itself" for any agent or contributor.

## Considered Options

- **Hardcoded literals everywhere.** Idiomatic Pascal, instantly greppable, no indirection. Rejected: the rename we just did would have been days of work and there is no guarantee a literal in some far corner wouldn't survive it. Once burned.

## Consequences

- Reading `PROGRAM_NAME + '.toml'` is slightly noisier than `'lwpt.toml'`. Acceptable tax.
- `PROJECT_NAME` distinct from `PROGRAM_NAME` is deliberate (uppercase acronym in prose vs lowercase Unix convention on disk). Adding a third casing variant would be a smell — push back if you find yourself wanting one.
