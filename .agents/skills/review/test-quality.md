# Test quality lens

A test earns its place by going **red** on the bug it names. This lens hunts tests that cannot go red: they pass against the code as written, against the code before the change, and against any plausible bug in between.

## Scope

- Every test the diff adds or changes.
- Every existing test of production code the diff changes, even when the test file is untouched. A refactor can strand an old test: its setup now throws early, or its selector now matches nothing, and it stays green for the wrong reason.

For each test, read the production code it exercises, follow the path from its setup to its assertion, and ask: which edit to the subject turns this red? If no plausible edit does, it is a finding.

## Labels

Open each finding with one bold label, so findings read alike across reviews:

| Label | The test is green because… | Where to look |
| --- | --- | --- |
| **Phantom selector** | it asserts the absence of an element nothing in the tree renders | `queryBy…` / `not.toBeInTheDocument()`: search the repo for the testid, text or role, and check the rendered component tree reaches it |
| **Never reaches branch** | setup throws, short-circuits or takes another path before the code the test is named for | error-path tests whose fixture is incomplete (`{ id } as any`), invalid inputs that fail earlier, a stub returning the value that skips the branch (`has()` → false before `&&`), a storage stub that never keeps writes, an absence check run before an async route mounts |
| **Mock echo** | a stub returns X, the subject passes X through, and the test asserts X | `mockReturnValue` / `mockResolvedValue` / fake `fetch` feeding a return value the subject does not shape or choose |
| **Oracle copies subject** | the expected value is computed by the subject, or by a copy of its logic | `expected = fn(…)`, a helper that calls the functions under test, a formula or mapping rewritten in the test |
| **Asserts own setup** | it checks its fixture or harness, not anything the subject produced | assertions on a constant the test declared, or on a helper whose timing decides the result |
| **Self-comparison** | it compares a value to itself | `expect(a[0]).toMatchObject(x)` where `x` was destructured from `a[0]` |
| **Compile-time only** | the type system already guarantees what the runtime assert checks | `toBeUndefined()` on a `void` return, `toBeDefined()` on an exhaustive `Record`, `expect(true)` after a type-level check |
| **Third-party only** | it exercises a library and no app code | no import from the repo beyond the library |
| **Skipped** | it never runs | `.skip`, `describe.skip`, `test.todo` added or left with no linked issue |
| **Change-detector** | it restates a config literal and checks no logic | `toEqual(<verbatim copy of a const>)` |

## Evidence

The concrete failure is the bug that ships green. Each finding names:

1. a specific edit to the production code (delete the guard at `file:line`, return the stub unchanged, drop the dedup), and
2. the code that keeps the test green under that edit, cited by `file:line` you read.

Running a test file unchanged is fine, and its output is evidence (a `RangeError` in stderr shows the setup throws early). Leave source files unedited: the lenses share one working copy.

## Severity

- `major`: the test is the only coverage the diff has for a behaviour it changes.
- `minor`: another test covers the behaviour, or the gap is outside what the diff changes.
- `nit`: **Change-detector**, raised only when the diff adds one.

Also check the environment contract: `.test.ts` runs in node, `.test.tsx` in jsdom; a pure-logic test in `.tsx` pays for jsdom it does not use.
