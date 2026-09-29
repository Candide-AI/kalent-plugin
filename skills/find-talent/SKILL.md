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

Qualification spends workspace credits. Say so before the first qualified search if the user did not already ask for scoring.

`search_qualified_talents_by_prompt` returns a castingId. Poll `get_qualified_search_result` every 10–20 seconds while nextAction is wait. Call `continue_qualified_search` when nextAction is continue or retry. There are no webhooks.

Show profiles and Kalent’s own verdicts. Do not invent a score.

## Handoff

Do not enrich contacts or start outreach in this skill. Hand off to reach-candidates.
