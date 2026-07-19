# Upstream component inventory

Inventory source: `packages/components/src/components` at locked release
4.4.0.

The official source contains Accordion, AI Tag, Banner, Button, Button Pure,
Button Tile, Canvas, Carousel, Checkbox, Crest, Display, Divider, Drilldown,
Fieldset, Flag, Flyout, Heading, Icon, Inline Notification, Input Date, Input
Email, Input Month, Input Number, Input Password, Input Search, Input Tel,
Input Text, Input Time, Input URL, Input Week, Link, Link Pure, Link Tile, Link
Tile Product, Modal, Model Signature, Multi Select, Pagination, Pin Code,
Popover, Radio Group, Scroller, Segmented Control, Select, Sheet, Spinner,
Stepper Horizontal, Switch, Table, Tabs, Tabs Bar, Tag, Tag Dismissible, Text,
Text List, Textarea, Toast and Wordmark.

## Required first milestone

| Official component | Qt type | Current status |
|---|---|---|
| Button | `Button` | calibrated; visual gate passes |
| Button Pure | `ButtonPure` | planned |
| Icon | `Icon` | planned; licensed assets unavailable |
| Text | `Text` | planned |
| Heading | `Heading` | planned |
| Input Text | `InputText` | planned; obsolete generic TextField removed |
| Input Password | `InputPassword` | planned |
| Switch | `Switch` | planned; obsolete generic source removed |
| Checkbox | `Checkbox` | planned |
| Radio Group | `RadioGroup` | planned |
| Select | `Select` | planned |
| Banner | `Banner` | planned; obsolete generic source removed |
| Inline Notification | `InlineNotification` | planned |
| Tag | `Tag` | planned |
| Spinner | `Spinner` | implemented for Button loading calibration |
| Divider | `Divider` | planned |
| Link | `Link` | planned |
| Link Pure | `LinkPure` | planned |
| Modal | `Modal` | planned |
| Tabs | `Tabs` | planned |

`Card` and `IconButton` are not direct v4 component names. They are removed
from the fidelity milestone unless replaced by an unambiguous mapping such as
Button Pure or an official tile component.
