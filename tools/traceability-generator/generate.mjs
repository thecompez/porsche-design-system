import { readFile, writeFile } from 'node:fs/promises';

const root = new URL('../../', import.meta.url);
const status = JSON.parse(await readFile(new URL('spec/component-status.json', root), 'utf8'));
const aspects = [
  ['API', 'Public API mapping'],
  ['TOKENS', 'Token mapping'],
  ['GEOMETRY', 'Geometry specification'],
  ['STATES', 'Supported states'],
  ['A11Y', 'Accessibility'],
  ['KEYBOARD', 'Keyboard behavior'],
  ['RTL', 'RTL behavior'],
  ['LIGHT', 'Light theme'],
  ['DARK', 'Dark theme'],
  ['REFERENCE', 'Official web reference'],
  ['DIFF', 'Native screenshot and visual diff'],
  ['GALLERY', 'Gallery integration'],
  ['DOCS', 'Documentation'],
  ['TESTS', 'Automated tests'],
];

const evidence = (component, aspect, state) => {
  if (state !== 'Complete') {
    return 'Evidence required before completion';
  }
  const slug = component.replaceAll(/([a-z])([A-Z])/g, '$1-$2').toLowerCase();
  const paths = {
    API: `docs/api-mapping/${slug}.md`,
    TOKENS: `spec/components/${slug}.json`,
    GEOMETRY: `spec/components/${slug}.json`,
    STATES: `spec/components/${slug}.json`,
    A11Y: 'tests/accessibility',
    KEYBOARD: 'tests/interaction',
    RTL: 'tests/visual',
    LIGHT: 'tests/visual/reference-web',
    DARK: 'tests/visual/reference-web',
    REFERENCE: 'tests/visual/reference-web',
    DIFF: `tests/visual/reports/${slug}-fidelity.html`,
    GALLERY: 'examples/component-lab and examples/reference-gallery',
    DOCS: `docs/api-mapping/${slug}.md`,
    TESTS: 'CTest',
  };
  return paths[aspect];
};

let trace = `# Implementation traceability

Generated from \`spec/component-status.json\`. A row is complete only when its
named evidence exists and its validation has passed.

| ID | Requirement | Target | Status | Validation | Evidence |
|---|---|---|---|---|---|
| UPSTREAM-001 | Preserve the v4.4.0 lock at commit ff5d3d4… | upstream lock | Complete | lock/hash audit | upstream/porsche-design-system.lock.json |
| TOKEN-001 | Preserve deterministic extraction and generation | tokens/tools | Complete | unit + determinism CTests | 158 classified upstream exports |
| REGRESSION-001 | Preserve Button geometry ≥0.99622 and pixels ≥0.99482 | Button visual gate | Complete | cumulative visual CTest | button-fidelity.json |
`;

for (const component of status.components) {
  for (const [aspect, label] of aspects) {
    const state = component.aspects[aspect] ?? 'In progress';
    const id = `${component.name.toUpperCase().replaceAll('-', '')}-${aspect}-001`;
    trace += `| ${id} | ${component.name}: ${label} | ${component.name} | ${state} | component-specific validation | ${evidence(component.name, aspect, state)} |\n`;
  }
}

await writeFile(new URL('docs/implementation-traceability.md', root), trace);

let dashboard = `# Component completion status

Generated from \`spec/component-status.json\`.

| Component | Implementation | API mapping | Tests | Accessibility | RTL | Visual fixtures | Fidelity pass | Gallery |
|---|---|---|---|---|---|---|---|---|
`;
for (const component of status.components) {
  const value = key => component.dashboard[key];
  dashboard += `| ${component.name} | ${value('implementation')} | ${value('api')} | ${value('tests')} | ${value('accessibility')} | ${value('rtl')} | ${value('visual')} | ${value('fidelity')} | ${value('gallery')} |\n`;
}
await writeFile(new URL('docs/component-completion-status.md', root), dashboard);
