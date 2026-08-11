# Bug fixes: red test revision, then the fix

Structure a bug fix as two revisions, so the regression test's value is provable from history.

1. Red revision — the test that reproduces the bug, and nothing else. It must _fail_ against the current buggy code
2. Fix revision, a child of the red one — the source change that makes that same test _pass_

Anyone can then check out the red revision, watch the test fail, move to the fix, and watch it pass. A test committed together with its fix can pass for unrelated reasons, and that cannot be distinguished after the fact.

Keep both revisions building and typechecking; only the new test is red at the red revision. Do not squash the pair before review.
