# Font fidelity

Porsche Design System 4.4.0 uses Porsche Next and language-specific Porsche
Next/CJK stacks. The upstream font token is:

```text
'Porsche Next','Arial Narrow',Arial,'Heiti SC',SimHei,sans-serif
```

Porsche Next font files are Porsche Design System Assets. They are not bundled
or redistributed by this repository.

Resolution order in the Qt port:

1. an externally supplied, properly licensed Porsche Next family;
2. an undistorted Arial-compatible/system sans-serif fallback for general
   headings, body copy, labels, and messages;
3. official upstream CJK fallback stacks mapped to the host platform.

Button is the sole exception. Its locked macOS visual fixture uses Arial Narrow
with a 1.295× horizontal render scale after -0.936px tracking. This measured
`PlatformAdapted` correction is local to the 16px Button label and is disabled
whenever a licensed family is injected through `Theme.fontFamily`. It is not
applied to body copy, headings, form labels, or any fluid type scale.

Button and text comparison reports separate typography metrics from structural
and non-text color metrics. Results produced without Porsche Next must name the
fallback and record baseline/bounds differences in
`docs/known-visual-differences.md`.
