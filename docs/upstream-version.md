# Locked upstream version

The native port is locked to Porsche Design System **4.4.0**. It must not
silently consume newer upstream output.

| Item | Locked value | Verification |
|---|---|---|
| Git tag | `v4.4.0` | `git describe --tags --exact-match HEAD` |
| Git commit | `ff5d3d4dfdab3312dbf299e88457af59f289c264` | tag and npm `gitHead` |
| Documentation | `https://designsystem.porsche.com/v4/`, release 4.4.0 | official v4 homepage |
| Components JS | `4.4.0` | npm registry |
| React wrapper | `4.4.0` | npm registry |
| Angular wrapper | `4.4.0` | npm registry |
| Vue wrapper | `4.4.0` | npm registry |
| Components JS archive SHA-256 | `c00e13a2fa23dadb185652133961464ece6943f1c981b76e44d7c3cd93622eb6` | downloaded npm tarball |

The machine-readable lock is
`upstream/porsche-design-system.lock.json`.

Primary source repository:
`https://github.com/porsche-design-system/porsche-design-system`.

## Update policy

An upstream update requires an explicit lock-file change, a fresh upstream
audit, regenerated token/component specifications, new web references, and a
complete visual-diff run. A documentation-site change alone does not update
this port.
