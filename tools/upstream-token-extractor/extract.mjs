#!/usr/bin/env node

import { mkdir, writeFile } from "node:fs/promises";
import { dirname, resolve } from "node:path";
import { pathToFileURL } from "node:url";

const [modulePath, normalizedPath, snapshotPath] = process.argv.slice(2);
if (!modulePath || !normalizedPath || !snapshotPath) {
  process.stderr.write(
    "Usage: extract.mjs <upstream tokens index.mjs> <tokens.json> <snapshot.json>\n",
  );
  process.exit(2);
}

const upstream = await import(pathToFileURL(resolve(modulePath)));
const orderedEntries = Object.entries(upstream).sort(([left], [right]) =>
  left.localeCompare(right),
);

function clamp(value, minimum, maximum) {
  return Math.min(maximum, Math.max(minimum, value));
}

function hueToRgb(p, q, t) {
  let hue = t;
  if (hue < 0) hue += 1;
  if (hue > 1) hue -= 1;
  if (hue < 1 / 6) return p + (q - p) * 6 * hue;
  if (hue < 1 / 2) return q;
  if (hue < 2 / 3) return p + (q - p) * (2 / 3 - hue) * 6;
  return p;
}

function hslToArgb(value) {
  if (value.startsWith("#")) {
    const lower = value.toLowerCase();
    if (lower.length === 4) {
      return `#${lower[1]}${lower[1]}${lower[2]}${lower[2]}${lower[3]}${lower[3]}`;
    }
    return lower;
  }

  const match = value.match(
    /^hsl\(\s*([\d.]+)\s+([\d.]+)%\s+([\d.]+)%(?:\s*\/\s*([\d.]+))?\s*\)$/i,
  );
  if (!match) {
    throw new Error(`Unsupported upstream color syntax: ${value}`);
  }

  const hue = (Number(match[1]) % 360) / 360;
  const saturation = clamp(Number(match[2]) / 100, 0, 1);
  const lightness = clamp(Number(match[3]) / 100, 0, 1);
  const alpha = clamp(match[4] === undefined ? 1 : Number(match[4]), 0, 1);
  let red = lightness;
  let green = lightness;
  let blue = lightness;
  if (saturation !== 0) {
    const q =
      lightness < 0.5
        ? lightness * (1 + saturation)
        : lightness + saturation - lightness * saturation;
    const p = 2 * lightness - q;
    red = hueToRgb(p, q, hue + 1 / 3);
    green = hueToRgb(p, q, hue);
    blue = hueToRgb(p, q, hue - 1 / 3);
  }
  const byte = (component) =>
    Math.round(component * 255)
      .toString(16)
      .padStart(2, "0");
  const rgb = `${byte(red)}${byte(green)}${byte(blue)}`;
  return alpha < 1 ? `#${byte(alpha)}${rgb}` : `#${rgb}`;
}

function colorScheme(id) {
  if (id.endsWith("Light") || id.endsWith("Dark")) return null;
  const light = upstream[`${id}Light`];
  const dark = upstream[`${id}Dark`];
  return typeof light === "string" && typeof dark === "string"
    ? { light: hslToArgb(light), dark: hslToArgb(dark) }
    : null;
}

function categoryFor(id) {
  if (id.startsWith("color")) return "color";
  if (id.startsWith("spacing")) return "spacing";
  if (id.startsWith("radius")) return "radius";
  if (id.startsWith("duration") || id.startsWith("ease")) return "motion";
  if (
    id.startsWith("font") ||
    id.startsWith("typescale") ||
    id === "leadingNormal"
  ) {
    return "typography";
  }
  if (id.startsWith("breakpoint")) return "breakpoint";
  if (id.startsWith("shadow")) return "shadow";
  if (id.startsWith("blur")) return "blur";
  if (id.startsWith("gradient")) return "gradient";
  throw new Error(`No category mapping for upstream token '${id}'.`);
}

function sourceFor(id, category) {
  if (category === "color") {
    const scheme = id.endsWith("Light")
      ? "light"
      : id.endsWith("Dark")
        ? "dark"
        : "light-dark";
    const base = id.replace(/(Light|Dark)$/, "");
    const group =
      base === "colorFocus"
        ? "a11y"
        : /Canvas|Surface|Frosted|Backdrop/.test(base)
          ? "background"
          : /Primary|Contrast/.test(base)
            ? "foreground"
            : "semantic";
    return `packages/tokens/src/color/${scheme}/${group}/${id}.ts`;
  }
  if (category === "radius") {
    return `packages/tokens/src/border/radius/${id}.ts`;
  }
  if (category === "motion") {
    const group = id.startsWith("duration") ? "duration" : "ease";
    return `packages/tokens/src/motion/${group}/${id}.ts`;
  }
  if (category === "typography") {
    const group = id.startsWith("fontPorsche")
      ? "family"
      : id.startsWith("fontWeight")
        ? "weight"
        : id.startsWith("typescale")
          ? "size"
          : "lineHeight";
    return `packages/tokens/src/font/${group}/${id}.ts`;
  }
  if (category === "spacing") {
    const group = id.startsWith("spacingStatic") ? "static" : "fluid";
    return `packages/tokens/src/spacing/${group}/${id}.ts`;
  }
  return `packages/tokens/src/${category}/${id}.ts`;
}

function normalizedToken(id, upstreamValue) {
  const category = categoryFor(id);
  const base = {
    id,
    category,
    description: `Official Porsche Design System 4.4.0 token ${id}.`,
    classification: "Extracted",
    upstreamSource: sourceFor(id, category),
    upstreamValue,
  };

  if (category === "color") {
    const scheme = colorScheme(id);
    return scheme
      ? { ...base, type: "color", ...scheme }
      : { ...base, type: "color", value: hslToArgb(upstreamValue) };
  }
  if (id.startsWith("duration")) {
    return {
      ...base,
      type: "duration",
      value: Number.parseFloat(upstreamValue) * 1000,
      classification: "Derived",
    };
  }
  if (id.startsWith("ease")) {
    return { ...base, type: "easing", value: upstreamValue };
  }
  if (id.startsWith("fontPorsche")) {
    return { ...base, type: "fontFamily", value: upstreamValue };
  }
  if (id.startsWith("fontWeight")) {
    return { ...base, type: "fontWeight", value: upstreamValue };
  }
  if (id === "leadingNormal") {
    return {
      ...base,
      type: "number",
      value: 24,
      classification: "PlatformAdapted",
    };
  }
  if (id.startsWith("typescale")) {
    if (upstreamValue.endsWith("rem") && !upstreamValue.startsWith("clamp")) {
      return {
        ...base,
        type: "number",
        value: Number.parseFloat(upstreamValue) * 16,
        classification: "Derived",
      };
    }
    return { ...base, type: "string", value: upstreamValue };
  }
  if (id === "radiusFull") {
    return {
      ...base,
      type: "number",
      value: 9999,
      classification: "PlatformAdapted",
    };
  }
  if (category === "radius" || id.startsWith("spacingStatic")) {
    return {
      ...base,
      type: "number",
      value: Number.parseFloat(upstreamValue),
      classification: "Derived",
    };
  }
  if (id.startsWith("spacingFluid")) {
    return { ...base, type: "string", value: upstreamValue };
  }
  if (category === "breakpoint") {
    return { ...base, type: "number", value: upstreamValue };
  }
  if (category === "blur") {
    return {
      ...base,
      type: "number",
      value: Number.parseFloat(upstreamValue.match(/[\d.]+/)[0]),
      classification: "Derived",
    };
  }
  if (category === "shadow" || category === "gradient") {
    return { ...base, type: "string", value: upstreamValue };
  }
  throw new Error(`No value mapping for upstream token '${id}'.`);
}

const snapshot = Object.fromEntries(orderedEntries);
const normalized = {
  tokens: orderedEntries.map(([id, value]) => normalizedToken(id, value)),
};

for (const outputPath of [normalizedPath, snapshotPath]) {
  await mkdir(dirname(resolve(outputPath)), { recursive: true });
}
await writeFile(resolve(normalizedPath), `${JSON.stringify(normalized, null, 2)}\n`);
await writeFile(resolve(snapshotPath), `${JSON.stringify(snapshot, null, 2)}\n`);
