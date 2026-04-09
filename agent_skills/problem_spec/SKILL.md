---
name: problem_spec
description: Draft a problem-first implementation spec with one proposed solution and testable acceptance criteria
---

# Problem Spec Skill

Use this skill to produce a spec centered on the problem being solved.

## When to use

- A request is still vague and needs clear problem framing.
- Work needs an implementation-ready spec before coding.
- The team needs measurable acceptance criteria tied to business/system impact.

## Invocation mode check

When invoked, first classify the input:
- **Rough outline**: brief bullets, partial thoughts, missing evidence/constraints/metrics.
- **Well-formed brief**: concrete problem statement with enough detail to draft directly.

If input appears to be a rough outline, ask the user one gating question before drafting:
- Do you want **guided mode** (iterative questions to shape the spec) or **one-shot mode** (AI drafts immediately from available context)?

Mode behavior:
- **Guided mode**: ask focused questions section-by-section (problem, scope, root cause, metrics, acceptance).
- **One-shot mode**: draft immediately, but explicitly mark assumptions and unknowns.

If input is already well-formed, default to one-shot mode unless the user asks for guided mode.

## Core rules

1. Problem-first: define the problem and impact before solution details.
2. Single-solution spec: include exactly one proposed solution.
3. No `Solution Options` section.
4. No separate `Verification Plan` section.
5. Acceptance criteria are the source of truth for verification.
6. Every acceptance criterion must be externally observable and measurable.

## Required spec outline

1. **Problem Definition**
   - Problem statement
   - Affected actors
   - Current pain/impact (quantify baseline impact when relevant and available)
   - Evidence (metrics, incidents, tickets, traces, and repro steps when reproducible; if evidence is unavailable, state why and confidence level)

2. **Scope, Boundaries, Constraints**
   - In scope
   - Out of scope
   - Assumptions
   - Constraints (technical, operational, compliance)

3. **Root Cause**
   - Root cause statement
   - Confidence level
   - Remaining unknowns

4. **Proposed Solution**
   - Solution overview
   - Design details
   - Data/API contract changes
   - Failure behavior

5. **Success Metrics**
   - Primary metric targets
   - Guardrail metrics (non-regression)
   - Not-solved conditions

6. **Acceptance Criteria**
   - Functional criteria
   - Non-functional criteria (performance, reliability, security)
   - Failure-path criteria
   - Observability criteria (logs/metrics/events proving behavior)

7. **Risks and Mitigations**
   - Key risks
   - Mitigation and owner
   - Rollback trigger conditions

## Quality gate (must pass)

Fail the draft if any are true:

- Baseline impact is required but omitted in cases where it is relevant and can be measured.
- Evidence source is required but omitted in cases where evidence is reasonably available.
- More than one solution path is proposed.
- Any acceptance criterion is not measurable.
- Success metrics are not mapped to stated problem impact.
- Failure behavior is implicit or missing.
- Repro steps are treated as optional evidence; if no reliable repro exists, explicitly state that and rely on other evidence sources.
- When baseline impact or evidence is genuinely unavailable or not relevant, the spec does not explicitly say so and provide rationale.

## Output template

Use this exact heading skeleton:

```md
# <Spec Title>

## Problem Definition

## Scope, Boundaries, Constraints

## Root Cause

## Proposed Solution

## Success Metrics

## Acceptance Criteria

## Risks and Mitigations
```
