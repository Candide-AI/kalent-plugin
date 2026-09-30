---
name: find-talent
description: Search Kalent after the recruiter confirms the brief. Use the remembered level. Plain search is the default. Qualify only when a must-have needs a judgment a filter cannot make, such as team size managed or company type, and the recruiter confirms. Hand off enrichment and outreach to reach-candidates.
---

# find talent

Search Kalent profiles, and qualify only when a must-have needs a judgment. The English name of this skill is find talent.

https://docs.kalent.ai

## Confirm

Restate the role and the filters you understood. Wait for a yes before you call Kalent.

Use the search level remembered by onboarding. Plain search is the default.

## When to search

Use search when every requirement is a strict filter Kalent can extract from the brief. Job title, skill, location, company, seniority, years of experience, and industry are filters. A search does not judge subtle facts.

Default tool is `search_talents_by_prompt`. Pass the role in plain language.

Use `search_talents_by_filters` only when the user explicitly asks for a structured filter search: a filters array, filterType, isRequired, isExcluded, isExactMatch, radius, or the Kalent filter model.

## When to qualify

Use qualification when the user also wants a verdict on a must-have that a filter cannot decide. Examples: managed a team of fewer than 3 people, worked at a B2B SAS, or any other fact that has to be read from the profile and scored.

A job title, a skill, or a city is not a reason to qualify. Stay on search unless at least one must-have needs that judgment.

If the remembered level is plain search, propose qualified search only for that must-have, and wait for the recruiter to confirm before you qualify.

Show the qualification criteria one by one, separate from the filters. Ten criteria at most.

A comma-separated list is ambiguous. Do not assume AND or OR. Show both readings and make the user pick: every item required, or the items as alternatives. Each validated criterion is its own string.

Send exactly that validated list with `search_qualified_talents_by_filters`, in `qualificationCriterias`. Pass the filters the recruiter confirmed. Pass the remembered verdict language as `scoringLanguage` (`fr` or `en`). Do not add a criterion they did not validate. Do not use `search_qualified_talents_by_prompt`. That tool also extracts criteria from the text and adds them, and you cannot preview those additions.

Qualification spends workspace credits. Say so before the first qualified search if the user did not already ask for scoring.

`search_qualified_talents_by_filters` returns a castingId. Poll `get_qualified_search_result` every 10–20 seconds while nextAction is wait. Call `continue_qualified_search` when nextAction is continue or retry. Keep calling it until the number of green profiles the user wants is reached. A batch of medium and red qualifications does not mean no green profiles remain. There are no webhooks.

Each talent has Kalent’s own `aiVerdict`. Do not invent a score. On every profile you show, say the qualification in words: strong qualification for `green`, medium qualification for `amber`, red qualification for `red`.

Show only the green profiles at first, and highlight them. For each one, show the name, current title, company, location, and the last two experiences. Do not paste raw JSON. Then say how many medium qualifications remain, that they can still be interesting, and that a medium qualification is often only missing information on the profile rather than proof the person did not do it. Do not list those profiles unless the user asks for them.

If the user asks for the medium qualifications, show those profiles, each labeled medium qualification. Then say how many red qualifications remain and that they can still be interesting. Do not list the red profiles unless the user asks for them.

If the user asks for the red qualifications, show those profiles, each labeled red qualification.

## Handoff

Do not enrich contacts or start outreach in this skill. Hand off to reach-candidates.
