# Kalent

AI talent sourcing: search, qualify, enrich, and outreach.

Kalent turns any AI assistant into a full recruiting workflow. Describe the role in plain English, the agent extracts the brief, sources beyond what LinkedIn Recruiter shows, explains why each profile is a fit, pulls verified contacts, then sends a personalized first touch and follow-ups when they don’t reply. Built for recruiting firms, staffing agencies, and in-house talent teams that want an end-to-end agentic sourcing flow, with secure OAuth via MCP.

Find and reach top candidates without leaving your AI workspace. Kalent searches 200M+ professional profiles, scores each must-have criterion, unlocks verified email and mobile, and runs LinkedIn, email, and WhatsApp sequences.

## Install

Kalent is not listed on the Cursor Marketplace. Until a listing is approved, add the remote server yourself and sign in with a Kalent account. Auth is OAuth with PKCE and dynamic client registration. Leave API key and credential fields empty.

Server URL: https://app.kalent.ai/api/mcp

Docs: https://docs.kalent.ai

### Cursor

Add a custom MCP server named Kalent with the server URL above.

### Claude

Add a custom connector with the server URL above. The directory listing is not live. This repo also has a plugin bundle (`.claude-plugin/plugin.json`, `.mcp.json`, and `skills/`) for a later directory submission.

### ChatGPT

Developer mode is available on Pro, Plus, Business, Enterprise, and Education accounts on the web. In ChatGPT, open Settings, then Security and login, and turn on Developer mode. Open ChatGPT Plugins, select the plus button, then Add custom MCP server. Enter the server URL above and choose OAuth. Create it as a plugin and install it before using it in a chat.

The same package is what you upload for the ChatGPT and Codex plugin directory. See [OpenAI package](#openai-package).

### Mistral Le Chat

An admin can add the server URL as a custom connector. Mistral does not publish a public directory form.

### Gemini CLI

`gemini-extension.json` is at the repo root and points at the same server. Gemini CLI discovers OAuth from the server. The gallery only lists the repo after the GitHub topic `gemini-cli-extension` is added under About. The crawl is daily.

```
gemini extensions install https://github.com/Candide-AI/kalent-plugin
```

### Grok Bot

A marketplace listing is not live. Add the server URL as a custom MCP server. The submission form is https://x.ai/bot/marketplace/submit-a-plugin. Use the public repo if the listing should include the skills, and use `assets/logo.png` for the square logo with a solid background.

## Tools

- `search_talents_by_prompt` when every requirement is a strict filter, such as job title, skill, location, company, seniority, or years of experience. Pass the role in plain language.
- `search_talents_by_filters` only when the user explicitly asks for a structured Kalent filter search.
- `search_qualified_talents_by_prompt` when a must-have needs a judgment a filter cannot make, such as managed a team of fewer than 3 people or worked at a B2B SAS. It returns a castingId. Poll `get_qualified_search_result` while nextAction is wait. Call `continue_qualified_search` when nextAction is continue or retry. On the results, show only `green` profiles first and label each one a strong qualification. Say that medium qualifications (`amber`) remain and can be interesting, often only because the profile lacks information, and show them only if the user asks. Then say that red qualifications remain and can be interesting, and show them only if the user asks. Label every shown profile strong, medium, or red.
- `create_sourcing`, then `add_talent_to_sourcing`.
- `enrich_candidate_contacts` or `enrich_linkedin_contacts`, then `get_contact_enrichment_result`.
- `create_sequence_blueprint` and `start_dynamic_sequences` for LinkedIn, email, WhatsApp, and SMS.

Search, qualification, and enrichment use workspace credits. A sequence messages real people, so the agent shows the copy and waits for a yes.

## Skills

### get-started

Connect the Kalent account and confirm the workspace before the first search.

### find-talent

Search Kalent when the brief is strict filters. Qualify only when a must-have needs a judgment a filter cannot make, such as team size managed or company type. Hand off enrichment and outreach to reach-candidates.

### reach-candidates

Save candidates into a sourcing, unlock verified contacts, and run LinkedIn, email, WhatsApp, or SMS sequences after the user confirms the copy.

## Privacy

https://kalent.ai/legal/privacy-policy

This package does not store account credentials. Connecting opens Kalent OAuth. Search, qualification, enrichment, and sequences run in the signed-in workspace, and the tools return profile data from that workspace.

## Terms

https://kalent.ai/legal/terms-of-use

## Support

https://help.kalent.ai

Email support@kalent.ai.

Product docs: https://docs.kalent.ai

## Registry namespace

`server.json` is the official MCP Registry manifest. The name is `io.github.Candide-AI/kalent`. Registry permissions use the GitHub login’s exact casing, and the org login is `Candide-AI`. Publishing that name needs `mcp-publisher login github` from an org Owner.

DNS alternative, if you would rather publish under the `kalent.ai` brand: prove the domain, then change `name` to `ai.kalent/kalent`. That is the reverse-DNS form of `kalent.ai`, the same pattern as `io.modelcontextprotocol` for `modelcontextprotocol.io`. Put the TXT record on the apex `kalent.ai`, not under a `_mcp-registry` name.

```
mcp-publisher login dns --domain kalent.ai --private-key <ed25519 hex private key>
```

The TXT value looks like `v=MCPv1; k=ed25519; p=<public key>`.

Validate without publishing:

```
mcp-publisher validate
```

The icon URL in `server.json` points at `assets/logo.png` on the `main` branch. It resolves after this file is on `main`.

## OpenAI package

`extensions.com.openai` in `plugin.json` holds the ChatGPT and Codex listing fields. `assets/logo.png` and `assets/icon.png` are the same 512×512 PNG: the repo SVG rendered on white (`#ffffff`), which is already the white used in the mark. The Agent Plugins schema does not allow a `logo` field on the root manifest, so the previous root `logo` key was removed. OpenAI reads `extensions.com.openai.interface.logo` instead.

Build the submission ZIP (files at the archive root, `.git` and `dist` left out):

```
./scripts/package-openai-zip.sh
```

That writes `dist/kalent-plugin.zip`.

Before review, add the unlisted demo URL as `extensions.com.openai.review.demo_recording_url`. Enter reviewer credentials in the OpenAI dashboard. Do not put them in this repo.
