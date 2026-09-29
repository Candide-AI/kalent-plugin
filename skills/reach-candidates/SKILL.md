---
name: reach-candidates
description: Save candidates into a sourcing, unlock verified contacts, and run LinkedIn, email, WhatsApp, or SMS sequences after the user confirms the copy.
---

# reach-candidates

Save candidates, unlock verified contacts, and send sequences. Enrichment uses workspace credits. A sequence messages real people, so show the copy and wait for a yes.

https://docs.kalent.ai

## Save

Call `get_sourcings`. Call `create_sourcing` only if none matches. Then call `add_talent_to_sourcing`.

## Enrich

Wait for an explicit yes before `enrich_candidate_contacts` or `enrich_linkedin_contacts`.

Use `enrich_candidate_contacts` for a candidate. Use `enrich_linkedin_contacts` for a LinkedIn URL. `enrichmentType` is `personalEmail`, `phone`, or `all`.

Poll `get_contact_enrichment_result` until `contactsLoading` is false. Never invent an email or a phone.

## Sequence

Wait for an explicit yes before `start_dynamic_sequences`.

Create the blueprint with `create_sequence_blueprint`. Each step needs `id`, `name`, `type`, `content`, and `temporalityType`.

`type` is `LINKEDIN`, `EMAIL`, `WHATSAPP`, or `SMS`. LinkedIn also needs `linkedInType`: `LINKEDIN_INVITATION_WITH_MESSAGE`, `LINKEDIN_MESSAGE`, `LINKEDIN_INVITATION`, or `LINKEDIN_INMAIL`.

`temporalityType` is `ASAP`, `DELAYED`, or `AFTER_INVITATION_SETTLED`. `DELAYED` needs `delay.value` and `delay.unit` (`day`, `minute`, or `second`).

The only variables are `{{firstname}}`, `{{lastname}}`, `{{candidateJobTitle}}`, `{{candidateCompanyName}}`, `{{candidateLocation}}`, `{{sourcingJobTitle}}`, `{{sourcingLocation}}`, `{{recruiterFirstname}}`, and `{{recruiterLastname}}`. Do not use bracket placeholders like `[company]`.

Set `subject` on email and LinkedIn InMail. An InMail subject is at most 200 characters.

`start_dynamic_sequences` uses the blueprint id and candidate ids. InMail uses the signed-in user’s connected LinkedIn account. On `linkedin_not_connected_or_syncing` or `linkedin_inmail_not_available`, explain that and do not retry in a loop.

## Status

Call `update_candidate_status` only when the user asks. `statusHandle` is a real status such as `TO_BE_CONTACTED`, `CONTACTED`, `NOT_RETAINED`, or an existing custom workspace status.
