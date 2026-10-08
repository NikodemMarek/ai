---
name: review-comments
description: How to word code review comments, thread replies and review summaries on merge requests — short, concise, informative, in Polish unless the author writes in English, with suggestion blocks where they fit. Use whenever you write review feedback meant for an MR author or reviewer, e.g. before `gitlab-review submit` or when drafting replies to review threads.
---

# Review comments and replies

Every comment is read by a busy colleague. It must be worth their time: one point, said once, with what to do about it.

## Language
- Write in **Polish** by default.
- Write in **English** if the person you address communicates in English:
  - a new comment or the summary: the MR author, judged by the MR title, description and their own comments;
  - a reply in a thread: the person you are replying to, i.e. the language of that thread.
- If unsure, use Polish. Never mix languages within one comment.
- Keep code identifiers, error messages and established technical terms as they are (`race condition`, `deadlock`, `null`); do not translate them.
- Polish style: plain, direct and polite. Prefer impersonal forms ("Tu brakuje…", "Proponuję…", "Warto…") over addressing someone with "Pan/Pani"; correct diacritics always (ą, ć, ę, ł, ń, ó, ś, ź, ż).

## A comment
- **One finding per comment**, placed on the line it is about.
- Start with a label: `**[błąd]**` / `**[ryzyko]**` / `**[sugestia]**` / `**[drobiazg]**` (English: `**[bug]**` / `**[risk]**` / `**[suggestion]**` / `**[nit]**`).
- Then 1–3 sentences: **what** is wrong, **why it matters** (the concrete consequence or failure case), **what to do**.
- Be specific: name the variable, the input, the case. "Może być problem z wydajnością" is useless; "`findAll()` w pętli robi N zapytań do bazy dla N zamówień" is useful.
- No filler: no greetings, praise padding, "Świetna robota, ale…", apologies, restating what the code does, or "być może warto by było rozważyć". Say it once and stop.
- Uncertain? Ask a short, concrete question instead of asserting ("Czy `id` może tu być `null`? Jeśli tak, `equals` rzuci NPE.").
- Don't repeat points already raised in existing threads; reply in that thread instead.

## Suggestions
Add a GitLab suggestion when the fix is **local, small and certain**: a few lines at the commented line, that you can write exactly.
- Only on inline comments on the new side of the diff.
- The block replaces the commented line: ` ```suggestion ` … ` ``` `. To replace a range, use ` ```suggestion:-N+M ` (N lines above, M below the commented line).
- Reproduce the indentation and surrounding code exactly; the author applies it with one click, so it must compile.
- The fence must start at column 0 with exactly three backticks.
- One suggestion per comment. Put the explanation sentence above it.
- No suggestion when the fix spans several places or files, needs a design decision, or you are not sure of the exact code; describe it, or show a short sketch in a normal ` ```lang ` block.

## Replies in a thread
- Answer the point directly in 1–2 sentences.
- If the author is right, say so plainly and drop the point ("Racja, `null` jest odfiltrowany wcześniej w `validate()`.").
- If you still disagree, give the reason or the failing case once, without repeating the original comment.
- If the change fixed it, a short confirmation is enough ("Poprawione, dzięki.").

## Summary
- At most 3 short sentences or bullets: overall verdict, what blocks the merge, what is optional.
- Don't repeat the individual comments; refer to them in aggregate ("2 błędy do poprawy przed merge, reszta to drobiazgi").

## Examples
Indented here only for display; in the real comment every line, the fences included, starts at column 0.

Polish comment with a suggestion:

    **[błąd]** `timeout` jest w sekundach, a `sleep()` przyjmuje milisekundy, więc pętla czeka 1000× krócej, niż zakłada konfiguracja.
    ```suggestion
            Thread.sleep(timeout * 1000L);
    ```

Polish comment without a suggestion:

    **[ryzyko]** `cache` jest współdzielony między wątkami, a `HashMap` nie jest bezpieczny wątkowo; równoległe `put` mogą zgubić wpisy. Proponuję `ConcurrentHashMap` albo synchronizację w `CacheService`.

English reply in an English thread:

    Fair point, the retry is bounded by `maxAttempts` upstream. Dropping this.

Polish summary:

    Dwie rzeczy do poprawy przed merge: wyciek połączenia w `Pool.release` i brak walidacji `limit` w API. Pozostałe uwagi są opcjonalne.
