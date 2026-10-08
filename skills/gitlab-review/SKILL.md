---
name: gitlab-review
description: Submit code-review findings on a GitLab merge request as a DRAFT review (unpublished draft notes the user publishes) with the `gitlab-review` CLI. Use after reviewing a GitLab MR when the findings should go to GitLab, or when asked to leave, draft or submit review comments on an MR.
---

# Draft MR reviews

`gitlab-review` sends findings to the user's event router, which creates them on the MR as **draft notes**: inline on the diff line where possible, otherwise as general comments that link to the line. Only the user can see drafts until they publish the review. You never publish, approve or post anything else to GitLab.

1. Run `gitlab-review guide` first. It is the authoritative format and lists every option and exit code.
2. Optional dry run: `gitlab-review plan --mr <MR url> <<'EOF' ... EOF` shows where each comment will land without writing anything.
3. Submit: `gitlab-review submit --mr <MR url> <<'EOF'` with the review JSON, then `EOF`. Use a quoted heredoc and don't write files into the workspace. It waits for the result and prints it, including comments that could not be placed inline and why.

Rules:
- Word every comment, reply and the summary as the `review-comments` skill says (load it first): Polish unless the author writes in English, one short finding per comment on the line it is about, suggestions where they fit, plus a short summary.
- Don't repeat points already raised in the existing threads; reply to a thread instead (by its id).
- Re-submitting replaces this tool's earlier drafts that the user has not edited, so submit the complete review each time.
- Exit code 3 means the result isn't in yet: check later with `gitlab-review status <id>`.
