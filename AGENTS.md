# Repository engineering guide

This repository follows the canonical
[`thecompez/ai-for-modern-cpp`](https://github.com/thecompez/ai-for-modern-cpp)
agent guide, with these project-specific additions:

- The primary toolchain is Clang 22+, CMake 4.3+, Ninja, Qt 6.8+, and C++26.
- Production C++ declarations live in filesystem-friendly `.cppm` files;
  implementations live in matching `.cpp` files.
- C++ module names are dot-separated under `pds.native.*`, and namespaces
  mirror module identities.
- Prefer `import std;` on the supported preset path. Qt textual includes are
  isolated in global module fragments or documented Qt entry-point boundaries.
- Public QML types are unprefixed because the module import already supplies
  identity: `import Pds.Native` followed by `Button`, `InputText`, or `Theme`.
- QML filenames exactly match their public type names, such as `Button.qml`.
- Generated filenames are `Tokens.qml`, `tokens.cppm`, and
  `tokens-reference.md`.
- The explicit design-system specification, including its PascalCase scoped
  enum convention, remains authoritative where it is more specific.
- Build and test results must be reported exactly; no unexecuted check may be
  described as successful.
