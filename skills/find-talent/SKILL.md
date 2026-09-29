---
name: find-talent
description: Search Kalent for talent and, when asked, score must-have criteria. Ordinary searches use search_talents_by_prompt. Hand off enrichment and outreach to reach-candidates.
---

# find talent

Search and qualify candidates in Kalent. The English name of this skill is find talent.

https://docs.kalent.ai

## Search

Use `search_talents_by_prompt` for every ordinary search. Pass the role in plain language.

Use `search_talents_by_filters` only when the user explicitly asks for a structured filter search: a filters array, filterType, isRequired, isExcluded, isExactMatch, radius, or the Kalent filter model.

## Qualification

Use `search_qualified_talents_by_prompt` by default. Use `search_qualified_talents_by_filters` only after that same explicit request for a structured filter search.

Qualification spends workspace credits. Say so before the first qualified search if the user did not already ask for scoring.

`search_qualified_talents_by_prompt` returns a castingId. Poll `get_qualified_search_result` every 10–20 seconds while nextAction is wait. Call `continue_qualified_search` when nextAction is continue or retry. There are no webhooks.

Show profiles and Kalent’s own verdicts. Do not invent a score.

## Handoff

Do not enrich contacts or start outreach in this skill. Hand off to reach-candidates.
