---
name: review
description: Review a required commit range with both staff-engineering and product-management perspectives
---

# review - Commit Range Review

Review a **required commit range** and produce one report that includes:
- a **Staff Engineer review** (technical quality/risk), and
- a **Product Manager review** (customer and business impact).

## Required Input

The prompt **must** include an explicit commit range (examples: `A..B`, `A...B`, `abc123..def456`, `origin/main..HEAD`).

If no commit range is provided, stop and ask for it before reviewing.

## Usage

```text
/review <commit-range>
```

Examples:
- `/review origin/main..HEAD`
- `/review 4f2a1c3..9b8d7e6`

## Workflow

1. **Determine repo root**
   - Use the current working directory.

2. **Validate commit range exists**
   - Prefer Jujutsu first:
     ```bash
     jj log -r '<commit-range>'
     ```
   - If `jj` is unavailable or fails, use git:
     ```bash
     git rev-list <commit-range>
     ```
   - If the range is invalid/empty, report that clearly.

3. **Collect change context**
   - Prefer Jujutsu:
     ```bash
     jj log -r '<commit-range>'
     jj diff --from <range-start> --to <range-end> --color never
     ```
   - If `jj` is unavailable or fails, use git:
     ```bash
     git log --oneline --decorate --graph <commit-range>
     git diff --color=never <commit-range>
     ```

   - When writing feedback, cite **Jujutsu change IDs** for each finding (not git commit hashes).
   - If only git data is available, still label feedback references as "changes" and prefer the nearest equivalent identifier.


4. **Review from both perspectives**

### A) Staff Engineer Review

Focus on:
- correctness and edge cases
- reliability and failure modes
- security and privacy concerns
- performance/scalability
- maintainability, readability, and test quality
- deployment/backward compatibility risks

Output findings by severity: blocker, major, minor, nit.

### B) Product Manager Review

Focus on:
- user/customer impact and value clarity
- requirement completeness and scope fit
- UX quality (clarity, friction, error states)
- analytics/experiment implications
- operational/support impact
- rollout risk and release readiness

Classify PM findings by impact: high, medium, low.

5. **Provide final review summary**
   - Include:
     - commit range reviewed (with feedback references using change IDs)
     - overall recommendation (`approve`, `approve with follow-ups`, or `changes required`)
     - separate Staff Engineer and Product Manager sections
   - If no issues, state that explicitly in both sections.
