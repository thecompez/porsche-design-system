# Current implementation gap analysis

The pre-v4 implementation is evidence of failure: it is a generic design
system whose values were invented locally. It is not retained as a visual
starting point.

| Area | Current implementation | Official 4.4.0 behavior | Required correction | Status |
|---|---|---|---|---|
| primary color | arbitrary blue `#2762d9` | semantic `colorPrimary` near black in light mode | replace token source | corrected |
| Button variants | Primary, Secondary, Tertiary, Ghost, Danger | Primary and Secondary only | remove unsupported variants | corrected |
| Button sizes | Small, Medium, Large | normal plus responsive `compact` | replace API and geometry | corrected for base/compact |
| Button geometry | arbitrary 36/44/52px heights and token padding | 16/28/8px normal; 6/16/4px compact; 12/8px radius | rebuild from machine spec | corrected and measured |
| Button state colors | blue hover/danger rules | official primary/contrast and frosted state tokens | replace state resolver | corrected |
| typography | invented Display/Heading/Body/Label enum | official `typescale*`, prose Text and Heading mappings | remove invented API; port official Text/Heading later | obsolete API removed |
| theme | high contrast plus four invented densities | Light, Dark and System | remove non-upstream theme concepts | corrected |
| motion | invented five-level policy | four upstream durations and three easings | replace tokens | corrected |
| icons | original neutral path approximations | official licensed SVG geometry | remove fidelity claim; add licensed source boundary | obsolete paths removed; assets unavailable |
| Switch | arbitrary dimensions/colors | official source-defined switch geometry/states | rebuild after Button gate | obsolete source removed; official port planned |
| TextField | generic composite | official Input Text contract | replace with `InputText` | obsolete source removed; official port planned |
| Card | generic invented component | no direct `Card` component | remove from milestone | removed |
| IconButton | generic invented component | Button Pure is the official mapping | replace with `ButtonPure` | removed; Button Pure planned |
| Banner | locally designed alert | official Banner contract/composition | rebuild from source | obsolete source removed; official port planned |
| gallery | dashboard sidebar and custom control bar | official configurator/example presentation | split lab/reference apps | corrected for Button scope |
| visual tests | Qt-only screenshots | locked official web versus Qt metrics/diff | build dual renderer | corrected; strict gate passes |

## Invented token/API inventory

All 75 prior tokens were classified `Arbitrary` unless a later extraction
proves an exact upstream mapping. Invented reusable names include
`colorActionPrimary`, `radiusControlMedium`, density-specific control sizes,
Automotive density, custom contrast, Danger/Tertiary/Ghost Button variants and
generic Card semantics.

None were grandfathered into the v4 port merely because prior tests passed.
The current normalized source contains only the 158 locked upstream exports.
