---
name: find-talent
description: Search Kalent when the brief is strict filters. Qualify only when a must-have needs a judgment a filter cannot make, such as team size managed or company type. Hand off enrichment and outreach to reach-candidates.
---

# find talent

Search Kalent profiles, and qualify only when a must-have needs a judgment. The English name of this skill is find talent.

https://docs.kalent.ai

## When to search

Use search when every requirement is a strict filter Kalent can extract from the brief. Job title, skill, location, company, seniority, years of experience, and industry are filters. A search does not judge subtle facts.

Default tool is `search_talents_by_prompt`. Pass the role in plain language.

Use `search_talents_by_filters` only when the user explicitly asks for a structured filter search: a filters array, filterType, isRequired, isExcluded, isExactMatch, radius, or the Kalent filter model.

## When to qualify

Use qualification when the user also wants a verdict on a must-have that a filter cannot decide. Examples: managed a team of fewer than 3 people, worked at a B2B SAS, or any other fact that has to be read from the profile and scored.

A job title, a skill, or a city is not a reason to qualify. Stay on search unless at least one must-have needs that judgment.

Default tool is `search_qualified_talents_by_prompt`. Use `search_qualified_talents_by_filters` only after that same explicit request for a structured filter search.

Put the entire brief in `prompt`, in the user's words: role, locations, years, must-haves, and nice-to-haves. Keep every technology the user named (Python, AWS, C++); do not replace it with a generic phrase such as "backend experience".

Call `search_qualified_talents_by_prompt` with `qualificationCriterias` empty: Kalent extracts the criteria it judges from the brief by itself. Offer the field only after telling the user that, and fill it only if the user then explicitly asks, with the criteria the user validated. A requirement written in the brief is not such a request. Then send one must-have per item, in the user's wording, and keep nice-to-haves in `prompt`. Kalent removes exact duplicates only, so a criterion that restates the brief in other words is judged twice.

With `search_qualified_talents_by_filters`, `qualificationCriterias` is required and holds the only criteria Kalent judges: nothing is extracted from the filters.

Qualification spends workspace credits. Say so before the first qualified search if the user did not already ask for scoring.

`search_qualified_talents_by_prompt` returns a castingId. Poll `get_qualified_search_result` every 10–20 seconds while nextAction is wait. Call `continue_qualified_search` when nextAction is continue or retry. There are no webhooks.

Each talent has Kalent’s own `aiVerdict`. Do not invent a score. On every profile you show, say the qualification in words: strong qualification for `green`, medium qualification for `amber`, red qualification for `red`.

Show only the green profiles at first. Then say how many medium qualifications remain, that they can still be interesting, and that a medium qualification is often only missing information on the profile rather than proof the person did not do it. Do not list those profiles unless the user asks for them.

If the user asks for the medium qualifications, show those profiles, each labeled medium qualification. Then say how many red qualifications remain and that they can still be interesting. Do not list the red profiles unless the user asks for them.

If the user asks for the red qualifications, show those profiles, each labeled red qualification.

## Handoff

Do not enrich contacts or start outreach in this skill. Hand off to reach-candidates.
