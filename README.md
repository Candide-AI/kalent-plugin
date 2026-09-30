# Kalent

AI talent sourcing: search, qualify, enrich, and outreach.

Kalent turns any AI assistant into a full recruiting workflow. Describe the role in plain English, the agent extracts the brief, sources beyond what LinkedIn Recruiter shows, explains why each profile is a fit, pulls verified contacts, then sends a personalized first touch and follow-ups when they don’t reply. Built for recruiting firms, staffing agencies, and in-house talent teams that want an end-to-end agentic sourcing flow, with secure OAuth via MCP.

Find and reach top candidates without leaving your AI workspace. Kalent searches 200M+ professional profiles, scores each must-have criterion, unlocks verified email and mobile, and runs LinkedIn, email, and WhatsApp sequences.

## Install

Install Kalent from the Cursor Marketplace. In Grok Bot, open Settings, then Plugins. Sign in with the Kalent account. Auth is OAuth with PKCE and dynamic client registration.

Server URL: https://app.kalent.ai/api/mcp

https://docs.kalent.ai

Until the listing is live, add that URL as a custom MCP server named Kalent and leave credential fields empty.

## Tools

- `search_talents_by_prompt` when every requirement is a strict filter, such as job title, skill, location, company, seniority, or years of experience. Pass the role in plain language.
- `search_talents_by_filters` only when the user explicitly asks for a structured Kalent filter search.
- `search_qualified_talents_by_filters` when a must-have needs a judgment a filter cannot make, such as managed a team of fewer than 3 people or worked at a B2B SAS, and the recruiter has confirmed that level. Send exactly the validated criteria, each as its own string. Do not use `search_qualified_talents_by_prompt` for that search: it also extracts criteria from the prompt and adds them, and those additions cannot be previewed. It returns a castingId. Poll `get_qualified_search_result` while nextAction is wait. Keep calling `continue_qualified_search` when nextAction is continue or retry until the wanted number of green profiles is reached. A batch of medium and red qualifications does not mean no greens remain. On the results, show only `green` profiles first and label each one a strong qualification. Say that medium qualifications (`amber`) remain and can be interesting, often only because the profile lacks information, and show them only if the user asks. Then say that red qualifications remain and can be interesting, and show them only if the user asks. Label every shown profile strong, medium, or red.
- `create_sourcing`, then `add_talent_to_sourcing`.
- `enrich_candidate_contacts` or `enrich_linkedin_contacts`, then `get_contact_enrichment_result`.
- `create_sequence_blueprint` and `start_dynamic_sequences` for LinkedIn, email, WhatsApp, and SMS.

Search, qualification, and enrichment use workspace credits. A sequence messages real people, so the agent shows the copy and waits for a yes.

## Skills

### onboarding

Remember company, the kind of roles, market, verdict language (`fr` or `en`), and the search level. Explain plain search and qualified search once. Plain search is the default. Do not search.

### find-talent

Search Kalent after the recruiter confirms the brief. Use the remembered level. Plain search is the default. Qualify only when a must-have needs a judgment a filter cannot make, such as team size managed or company type, and the recruiter confirms. Hand off enrichment and outreach to reach-candidates.

### reach-candidates

Save candidates into a sourcing, unlock verified contacts, and run LinkedIn, email, WhatsApp, or SMS sequences after the user confirms the copy.
