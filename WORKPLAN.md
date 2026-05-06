# DCM Project — Working Plan

> Keep this file open in a split pane while working.
> Tick items with `- [x]` as you complete them.
> Add new tasks under the relevant phase as they arise.
> Commit this file regularly: `git add WORKPLAN.md && git commit -m "plan: update"`

---

## How to Run a Work Session

1. Open PowerShell → run session setup (see Phase 0 below)
2. Open this file in Cursor split pane
3. Work through the current phase
4. At end of session: tick completed items, add new insights under ### New Tasks
5. Commit: `git add WORKPLAN.md && git commit -m "plan: session YYYY-MM-DD"`

---

## Session Setup (copy-paste every time)

```powershell
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; chcp 65001
$env:Path = "C:\Model\tools\quarto-1.9.37\bin;" + $env:Path
cd C:\Model\decision-centred-modelling
```

Render + publish:
```powershell
quarto render --to html
quarto publish gh-pages
```

Export draft:
```powershell
powershell -File scripts\export-draft.ps1 V##-description
```

---

## PHASE 1 — Immediate (current session)

- [ ] Run render + publish (all recent changes go live)
- [ ] Export V05 DOCX and verify figures appear
- [ ] Upload V05 to Claude for content review
- [ ] Enable GitHub Discussions (github.com/Ahmad-Mahmoudi-coder/DCM/settings)
- [ ] Set up Claude Project with V05 DOCX

---

## PHASE 2 — This Week (content foundation)

### References
- [ ] Run thesis reference extraction script → upload to Claude → get .bib file
- [ ] Add citations to Module 1 (Lempert 2003, Walker 2013, Haasnoot 2013, Simon 1955)
- [ ] Add citations to Module 5 (MBIE, EECA, CCC sources)
- [ ] Add own paper citation to Module 6 §6.9

### Content
- [ ] Add §1.6 Positioning Against Adjacent Traditions (novelty section)
- [ ] Draft SM-1.2-A Mathematical Foundations (request from Claude)
- [ ] Fix any remaining legacy Part/Appendix references
- [ ] Update Module 6 §6.9 "23 of 64" → "100-future ensemble" framing

### Community
- [ ] Implement Giscus comments (visit giscus.app → Cursor prompt)
- [ ] LinkedIn Post 1 — the 23/64 finding hook (request from Claude)

---

## PHASE 3 — Next Week (visuals + site)

- [ ] Mobile-responsive CSS (Cursor prompt)
- [ ] Add Fig 1.1 — Five-feature problem class diagram (request from Claude)
- [ ] Add Fig 3.1 — Artefact lifecycle diagram (request from Claude)
- [ ] Add Fig 3.2 — Thin-waist interface diagram (request from Claude)
- [ ] Add interactive 23/64 chart to landing page (request from Claude with CSV)
- [ ] Deploy AI chat panel with API key (personal laptop)

---

## PHASE 4 — This Month (publication)

- [ ] Draft arXiv preprint (upload V05 to Claude, request extraction)
- [ ] Draft journal paper 1 — framework (Environmental Modelling & Software)
- [ ] LinkedIn Post 2 — decision-first concept
- [ ] Check DMDU Society 2026 conference call for papers

---

## PHASE 5 — Ongoing

- [ ] Invite first expert attestations (share CLAIMS.md with DMDU community)
- [ ] Implement SM-3.9-A External Reference Registry
- [ ] PyPSA Regional Module (SM-6.6-E specification)
- [ ] Video explainer script → HeyGen render

---

## New Tasks
<!-- Add new tasks here as they arise during work sessions -->
<!-- Format: - [ ] Task description | Added: YYYY-MM-DD | Context: brief note -->

---

## Completed
<!-- Move ticked items here when a phase is done — keeps active list clean -->

---

## What to Share with Claude Each Session

| What | Why | How |
|---|---|---|
| Latest DOCX draft | Content review, drafting | Run export script → upload here |
| Terminal error output | Debugging | Paste directly into conversation |
| CSV files from PoC | New figures | Upload files directly |
| `thesis_references_raw.txt` | BibTeX conversion | Run Python script → upload |
| Cursor summary report | Confirm tasks done | Paste summary text |
