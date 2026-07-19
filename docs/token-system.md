# Token system

`tools/upstream-token-extractor/extract.mjs` imports the locked
`@porsche-design-system/components-js@4.4.0/tokens` module and writes:

- `upstream/extracted/tokens-4.4.0.json`: raw locked snapshot;
- `tokens/source/tokens.json`: normalized source with provenance and
  Extracted/Derived/PlatformAdapted classification.

The current snapshot contains 158 official exports across color, spacing,
radius, typography, motion, shadow, blur, gradient, and breakpoint categories.
No local palette or spacing scale is added.

`PdsTokenGenerator` validates identifiers, category/type compatibility,
literal types, aliases, cycles, and deterministic order, then generates:

- `tokens/generated/Tokens.qml`;
- `tokens/generated/tokens.cppm`;
- `tokens/generated/tokens-reference.md`.

Light/dark dependencies are explicit in generated QML bindings so existing
controls update when `Theme.mode` changes. `validation.token_determinism`
generates twice and compares SHA-256 hashes.
