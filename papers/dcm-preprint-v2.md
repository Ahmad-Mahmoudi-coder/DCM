---
title: "Decision-Centred Modelling: A Governed, Modular Architecture for Infrastructure Planning Under Deep Uncertainty"
author:
  - name: Seyed Ahmad Mahmoudi Lahijani
    affiliation: Auckland University of Technology
    email: mahmoudi3678@gmail.com
date: "2026"

abstract: |
  Long-horizon infrastructure decisions face a structural analytical
  problem distinct from insufficient physical detail: when a model
  draws its boundary around the physical system being analysed,
  the consequences that cross that boundary — infrastructure-conditional
  costs, cross-scale demand propagation, regional network constraints —
  become analytically inaccessible. For decisions where these
  consequences are material, the model may point in the wrong direction.

  This paper introduces the Decision-Centred Modelling (DCM)
  framework, which addresses this problem by drawing the analytical
  boundary around the decision and its consequences rather than
  around the physical system. The framework rests on three principles:
  a decision-first boundary specification that defines analytical
  scope through decision-relevance; a thin-waist artefact governance
  layer coupling heterogeneous analytical modules through
  schema-conforming exchange contracts; and progressive refinement
  governed by regret diagnostics. Under conditions where probability
  distributions over futures cannot be defended, regret, robustness,
  and satisficing replace expected value optimisation as the
  appropriate evaluative standards.

  Applied to industrial process heat decarbonisation in Southland,
  New Zealand, the framework reveals a material difference between
  site-boundary and decision-boundary analysis. From within the
  facility boundary, a biomass switching pathway (BB) has a
  NZD 14.2M/year private cost advantage over full electrification
  (EB), with no visible infrastructure consequence. When regional
  grid infrastructure costs are included within the decision
  boundary, BB is preferred in 93 of 100 plausible futures —
  while EB exposes the decision to a major grid reinforcement
  class in 49 of those futures, a consequence invisible to
  conventional site-boundary analysis. The framework architecture
  is domain-general. The platform and proof-of-concept data are
  openly available at https://ahmad-mahmoudi-coder.github.io/DCM/.


keywords:
  - deep uncertainty
  - decision-centred modelling
  - industrial decarbonisation
  - robust decision making
  - modular energy systems
  - process heat
  - New Zealand
bibliography: references/references.bib
---

## 1. Introduction

Long-horizon infrastructure decisions share a structural
feature that is underappreciated in the modelling literature:
the consequences that determine whether a decision was
well-made often extend beyond the physical boundary of
any single system. A factory that commits to electrifying
its process heat creates load that propagates through the
regional electricity network. A region that pursues
industrial electrification generates infrastructure demand
that affects grid upgrade timelines and tariff structures
for all connected users. These consequences are not
incidental — they are frequently decisive. Yet they fall
outside the scope of the analytical models most commonly
used to support these decisions.

The problem is not computational capacity. Modern energy
system models — TIMES, PyPSA, MESSAGE, Calliope — can
represent extraordinary technical complexity. The issue
is boundary placement. When an analytical model draws its
boundary around the physical system being optimised, it
cannot represent consequences that cross that boundary,
however material those consequences may be. This is not
a failure of the models — they were not designed to
represent these consequences — but it creates a systematic
gap between what the model can see and what the decision
actually requires.

This paper introduces the Decision-Centred Modelling (DCM)
framework, which addresses this gap by repositioning the
analytical boundary: rather than drawing it around the
physical system, the framework draws it around the
decision and its decision-relevant consequences. Where a
system-centred model asks "what is the least-cost technology
for this facility?", a decision-centred model asks "how
does this technology choice perform, across the full range
of consequences and futures, relative to available
alternatives?" These are different questions with
structurally different analytical requirements.

The framework makes three claims. First, an architectural
claim: a governed, modular analytical environment organised
around the decision problem and coupled through thin-waist
artefact exchange is technically feasible and analytically
better suited to multi-scale infrastructure decisions under
deep uncertainty than monolithic system-centred models.
Second, a methodological claim: under conditions where
probability distributions over futures cannot be defended,
regret, robustness, and satisficing are more appropriate
evaluative standards than expected value optimisation.
Third, an empirical claim: when the Edendale industrial
electrification decision is evaluated within the DCM
framework — including regional grid infrastructure
consequences within the decision boundary — the comparison
between pathways changes materially relative to a
conventional site-only analysis, in 93 of 100 plausible
futures.

Section 2 reviews the adjacent traditions against which
the framework is positioned. Section 3 specifies the
framework design. Section 4 describes the uncertainty
architecture. Section 5 presents the Southland proof of
concept. Section 6 discusses implications, limitations,
and generalisability. Section 7 concludes.

---

## 2. Background and Related Work

### 2.1 Energy System Modelling

The energy system modelling literature offers a mature
set of tools for evaluating technology transitions and
policy pathways. TIMES and its national implementations
use linear programming to identify least-cost national
energy system configurations over multi-decade horizons
[@herbst2012introduction]. PyPSA provides open-source
network optimisation for electricity systems
[@pfenninger2018importance]. Calliope and similar
capacity expansion models enable multi-sector analysis
with explicit spatial and temporal resolution.

These tools are valuable for the purposes they were
designed to serve. Two characteristics become limiting
specifically for site-to-regional industrial
decarbonisation decisions. First, they draw their
analytical boundary around the physical system being
optimised. Consequences that cross that boundary —
GXP-level hosting capacity constraints, infrastructure-
conditional cost propagation from site to network — are
not represented because they are outside the model's
declared scope. Second, they handle uncertainty through
scenario comparison. TIMES-NZ 3.0, New Zealand's primary
national energy model, evaluates two structural scenarios
(Steady and Shift) that span four critical uncertainties
[@eeca2024timesnz]. Two scenarios provide valuable
macroeconomic framing but cannot span the multi-
dimensional uncertainty space that a twenty-year
industrial infrastructure commitment faces across
multiple independently varying drivers.

These are not critiques of the models for their stated
purposes. They are observations about the specific
analytical gap that arises when site-to-regional
multi-scale decisions require more than national-scale
scenario analysis can provide.

### 2.2 Decision Making Under Deep Uncertainty

DMDU methods emerged because conventional scenario
analysis was producing inadequate guidance for long-horizon
planning problems [@marchau2019decision].
Knight's distinction between risk — where probabilities
are knowable — and uncertainty — where they are not
[@knight1921risk] — identifies the structural condition.
Under deep uncertainty, Simon's satisficing
[@simon1955behavioral] is the appropriate standard: find
alternatives that perform acceptably across many futures
rather than optimising under one assumed future.

Robust Decision Making [@lempert2003shaping] operationalises
this through ensemble evaluation: alternatives are assessed
across large sets of plausible futures using regret and
robustness rather than expected value. Dynamic Adaptive
Policy Pathways [@haasnoot2013dynamic] designs decision
sequences that can be revised as conditions evolve.
Exploratory Modelling and Analysis [@kwakkel2016comparing]
provides the computational infrastructure for large-scale
ensemble evaluation.

The DMDU tradition provides the evaluative standards the
DCM framework adopts. Its primary limitation for the
present purpose is the absence of a modular architectural
specification that makes these standards tractable at
multi-scale resolution for industrial infrastructure
decisions. The DCM framework addresses this gap.

### 2.3 Sequential Decision Analytics

Powell's unified framework for sequential decision
analytics [@powell2022sequential] classifies any decision
method into four policy classes: policy function
approximations (PFAs), cost function approximations
(CFAs), value function approximations (VFAs), and direct
lookahead approximations (DLAs). His formulation searches
over both the function class $f \in F$ and parameters
$\theta \in \Theta$ to maximise expected cumulative
contribution. The DCM framework uses a CFA — proportional
dispatch — for computationally tractable ensemble
evaluation across 100 futures.

The critical extension the DCM framework makes is
applicable when the expectation operator in Powell's
formulation cannot be applied: when probability
distributions over futures are not available or
defensible. In that condition, regret and satisficing
replace $\mathbb{E}[\cdot]$ as the evaluative standard.
Powell's policy class taxonomy remains applicable; the
evaluation metric changes.

### 2.4 The Analytical Gap

The gap the DCM framework addresses arises at the
intersection of three conditions that existing approaches
do not jointly satisfy: multi-scale consequence
visibility spanning site, regional, and national levels;
ensemble-based deep uncertainty evaluation; and modular,
reproducible, auditable analytical architecture. A
systematic review of modelling tools for industrial
process heat decarbonisation found no existing tool met
all three conditions jointly [@lahijani2025modelling].
The DCM framework was designed to fill this gap.

---

## 3. Framework Design

### 3.1 The Decision-First Boundary Principle

The foundational architectural commitment of the DCM
framework is that analytical boundaries are drawn by the
decision context — not by the physical extent of the
system being modelled. The decision-relevant boundary is
defined as the smallest analytical scope within which
all consequences material to the comparison of
alternatives are visible.

This principle has a specific operational implication:
before any analytical module is designed, the decision
context must be declared. What decision is being
supported? What pathways are being compared? What
consequences are material to that comparison? What
scales do those consequences span? The answers define
the analytical scope. The physical system boundary is
then one layer within that scope, not the boundary of
the analysis.

For the industrial electrification decision in §5, the
material consequences include site operating costs,
regional grid infrastructure upgrade requirements, and
carbon cost exposure — spanning facility, GXP, and
national policy scales simultaneously. A model drawn
at the facility boundary can represent the first; it
cannot represent the second or third without deliberate
architectural extension.

### 3.2 Modular Architecture and Thin-Waist Coupling

The DCM framework is organised as a seven-layer
analytical stack, from facility demand construction
through site dispatch, GXP interface, regional
electricity modelling, policy context, DMDU ensemble
evaluation, to the decision layer. Each layer is a
distinct analytical module that can be developed,
validated, and replaced independently.

The coupling mechanism between layers is a thin-waist
artefact exchange. The thin-waist principle — from
internet protocol design, specifically the end-to-end
argument in network architecture [@saltzer1984end] —
specifies that inter-module interfaces must be narrow
(carrying only what must cross the boundary), explicit
(precisely schema-specified), and stable (unchanging
even as module internals evolve). In the DCM framework,
every output that crosses a module boundary is a
schema-conforming, provenance-carrying, validation-gated
artefact carrying its schema version, the inputs that
produced it, a SHA-256 hash for integrity verification,
and the validation record that admitted it into the
comparison chain.

This architecture produces two analytical properties.
First, genuine reproducibility: every finding is
traceable to every assumption through the artefact chain,
and any module can be replaced without disturbing the
chain provided the interface contract is preserved.
Second, tractable progressive refinement: modules can
be developed to minimum viable specification and improved
where regret diagnostics reveal that improvement would
change the decision-relevant comparison.

### 3.3 Evaluation Standards Under Deep Uncertainty

The framework evaluates pathway alternatives using three
complementary metrics that jointly characterise decision
quality when probability distributions over futures
cannot be defended.

**Regret** of pathway $s$ under future $\omega$:

$$\rho(s,\omega) = Z(s,\omega) - \min_{s' \in S} Z(s',\omega)$$

where $Z(s,\omega)$ is the total system cost including
site operating costs and annualised infrastructure costs.
Regret is zero for the minimum-cost pathway in each
future. Maximum regret $R_{\max}(s) = \max_\omega
\rho(s,\omega)$ characterises the worst-case cost of
choosing $s$.

**Satisficing rate** at threshold $\tau$ — the fraction
of futures in which total cost falls within an acceptable
range:

$$\text{SR}(s,\tau) = \frac{|\{\omega : Z(s,\omega) \leq \tau\}|}{|\Omega|}$$

**Win rate** — the fraction of futures in which pathway
$s$ achieves the minimum system cost:

$$\text{WR}(s) = \frac{|\{\omega : \rho(s,\omega) = 0\}|}{|\Omega|}$$

Win rate is technically implied by regret (zero regret
equals a win) but provides a distinct frequency
characterisation useful for communication. A pathway with
high satisficing rate, low mean regret, and low maximum
regret is preferred under deep uncertainty — regardless
of which futures are most likely, and without requiring
probability distributions over $\Omega$.

### 3.4 Progressive Refinement

The framework's development philosophy is governed by
regret diagnostics rather than completeness aspirations.
A minimum viable implementation — honest about its
limitations, architecturally complete, and analytically
rigorous within its declared scope — is more valuable
than a comprehensive but opaque system.

Regret diagnostics operate as follows. For each uncertain
driver in the ensemble, the sensitivity of the pathway
comparison to that driver's value is computed. Drivers
that produce the largest swing in pathway preference —
measured by the range of regret values across futures
sorted by that driver — are the highest-priority
development targets. In the Edendale PoC, the GXP
headroom multiplier produces the largest regret
sensitivity: futures with lower headroom are those where
EB most frequently triggers the N+150 MW upgrade class.
This identifies regional network modelling fidelity as
the highest-priority analytical investment — not for
methodological reasons, but because it is the uncertain
driver most likely to change the recommendation if
represented with greater fidelity. The framework is in
this sense self-directing: it reveals its own most
productive next development step.

---

## 4. Uncertainty Architecture

Long-horizon decisions face three qualitatively distinct
types of uncertainty requiring different analytical
treatments. This three-layer taxonomy extends Knight's
risk/uncertainty distinction [@knight1921risk] by
specifying operationally distinct regimes and connecting
each to a tractable analytical response.

**Layer 1 — Parametric uncertainty** covers conditions
where uncertain drivers can be characterised by plausible
ranges and sampled via structured ensemble methods.
Capital cost multipliers, electricity tariff trajectories,
carbon price scenarios, and demand growth rates are
parametric uncertainties. Their ranges can be calibrated
from historical data and the TIMES-NZ 3.0 Steady/Shift
scenario bounds. The PoC demonstrates Layer 1 treatment
through Latin Hypercube Sampling across five drivers.

**Layer 2 — Structural uncertainty** covers conditions
where the world-model itself is contested — not parameter
values but the structural assumptions of the analytical
framework. Whether LNG import infrastructure is developed
or gas exits the energy mix; whether dairy export demand
follows the Steady or Shift trajectory. These are
discrete branches in the space of possible futures, not
points in a continuous parameter space. The TIMES-NZ 3.0
Steady/Shift scenarios represent structural uncertainty
at the national level, providing calibrated bounds
($52/\text{tCO}_2$ to $260/\text{tCO}_2$) for the ETS
price dimension [@eeca2024timesnz].

**Layer 3 — Deep narrative uncertainty** covers
conditions that are difficult to parameterise with
defensible probability assignments: geopolitical
ruptures, pandemic-scale disruptions, regulatory
reversals. These can only be evaluated as stress tests
— whether the preferred decision retains its advantage
if the shock occurs. The robustness-first evaluation
philosophy addresses Layer 3 indirectly: decisions that
perform well across Layers 1 and 2 tend to be more
resilient to Layer 3 shocks than decisions optimised
for a single assumed future.

The current PoC demonstrates Layer 1 treatment only.
Layer 2 structural scenario branching and Layer 3
stress testing are specified in the framework
architecture and represent natural extensions of the
current implementation.

---

## 5. Proof of Concept: Edendale–Southland

### 5.1 Decision Context

The Fonterra Edendale dairy processing facility in
Southland, New Zealand, is one of New Zealand's largest
industrial process heat consumers, with an annual heat
demand of approximately 819 GWh [@eeca2024rhdd]. Coal
provides approximately 80% of process heat at baseline
(2020). New Zealand's National Environmental Standards
mandate coal phase-out from industrial process heat by
2037. Two primary decarbonisation pathways are
available: full electrification via electric boilers
(EB pathway) or biomass substitution via biomass boilers
(BB pathway). The decision involves a capital commitment
with a 20+ year operational life and consequences that
propagate to the regional electricity network.

### 5.2 Analytical Pipeline

The PoC implements five of the seven DCM layers.

**Demand construction (Layer 1):** A synthetic
DemandPack is constructed for each planning epoch
(2020, 2025, 2028, 2035) from EECA's Regional Heat
Demand Database [@eeca2024rhdd], representing hourly
heat demand at 8,760-timestep annual resolution with
seasonal and operational variability.

**Site dispatch (Layer 2):** Proportional dispatch
allocates heat demand across committed technology units
in proportion to nameplate capacity — a cost function
approximation (CFA) in Powell's policy class taxonomy
[@powell2022sequential]. Annual costs include fuel,
electricity tariffs, NZ ETS carbon costs, and fixed
and variable operation costs.

**GXP interface (Layer 3):** The SignalsPack carries
the hourly incremental electricity demand: the
difference between EB or BB electricity import and
the 2020 coal-baseline import. The EB pathway creates
a peak incremental demand of 133 MW at the
Mararoa-Waimea GXP (EDN0331); BB creates 95 MW.
Both signals are validated against EECA Southland
RETA headroom estimates [@eeca2024southland].

**Regional screening (Layer 4):** For each future
$\omega$, the incremental electricity signal is
compared against available GXP headroom scaled by
the headroom multiplier $U_{\text{head}}^\omega$.
Where the signal exceeds headroom, the minimum
sufficient upgrade is selected from four options
(N+21, N+32, N+97, N+150 MW) with declared capital
costs.

**DMDU evaluation (Layer 6):** System cost for each
pathway under each future combines site operating cost
and annualised upgrade capital cost (10-year
amortisation at 7% real discount rate). Regret,
satisficing rate, and win rate are computed across
the 100-future ensemble.

### 5.3 Ensemble Design

The 100-future paired ensemble uses Latin Hypercube
Sampling across six uncertain multipliers, treated as
statistically independent draws. Multiplier ranges are
calibrated against TIMES-NZ 3.0 Steady/Shift scenario
bounds and EECA Southland RETA capacity estimates.
Futures are paired so that both EB and BB are
evaluated under identical multiplier draws, enabling
unambiguous pathway comparison.

| Multiplier | P10 | Median | P90 |
|---|---|---|---|
| Electricity price | 0.785 | 0.987 | 1.184 |
| Biomass cost | 1.133 | 1.486 | 2.038 |
| ETS carbon price | 0.950 | 1.275 | 1.654 |
| GXP headroom capacity | 0.817 | 0.890 | 0.950 |
| Upgrade capital cost | 0.920 | 1.071 | 1.285 |
| Value of lost load | 10,000 | 15,000 | 20,000 NZD/MWh |

The independence assumption across multipliers is
a simplifying approximation: in practice, electricity
price and GXP headroom may be positively correlated
through shared regional demand growth drivers. Relaxing
this assumption is a sensitivity analysis that the
progressive refinement framework would prioritise if
the headroom multiplier continues to dominate regret
sensitivity in subsequent ensemble designs.

### 5.4 Results

**From within the facility boundary,** the comparison
appears as a cost-emissions trade-off with no
infrastructure complexity. The BB pathway carries a
private cost advantage of NZD 14.2M/year (NZD 76.8M
versus NZD 91.0M annual site cost), while EB eliminates
direct CO₂ emissions entirely. Both pathways require
grid connection; neither triggers visible infrastructure
costs within the site boundary. Conventional site-
boundary analysis frames the decision as: choose BB
for cost advantage, choose EB for zero direct emissions.

**When the decision boundary includes regional grid
infrastructure,** the picture changes structurally.
Under the EB pathway, 100 of 100 futures require a
grid upgrade — 51 requiring N+97 MW (NZD 28.5M capex)
and 49 requiring N+150 MW (NZD 52.0M capex, the
major subtransmission reinforcement class). The BB
pathway requires N+97 MW in all 100 futures but never
triggers the N+150 MW class. The difference is the
38 MW gap in peak incremental demand between pathways
(133 MW for EB, 95 MW for BB), which is sufficient
to cross the N+150 MW upgrade threshold in 49% of
futures under EB. The GXP headroom multiplier is
the primary driver of this split: in futures where
headroom is tighter, EB more frequently triggers the
costlier upgrade class.

**System-cost robustness results** (Table 1) show BB
preferred in 93 of 100 futures. EB's satisficing
rate is 35% versus BB's 88%. EB's maximum regret
is NZD 18.9M/year; BB's maximum regret is
NZD 4.5M/year. EB carries 49% exposure to the N+150
MW upgrade class; BB carries zero.

**Table 1: Robustness comparison — EB and BB pathways,
100-future paired ensemble, Edendale–Southland PoC**

| Metric | EB | BB |
|---|---|---|
| Annual site cost (NZD M/yr) | 91.0 | 76.8 |
| Direct CO₂ (tCO₂/yr) | 0 | 1,610 |
| Satisficing rate | 35% | 88% |
| Mean system regret (NZD M/yr) | 8.8 | 0.1 |
| Maximum regret (NZD M/yr) | 18.9 | 4.5 |
| N+150 MW upgrade exposure | 49% | 0% |
| System-cost win rate | 7% | 93% |

The private cost advantage of BB (NZD 14.2M/year lower
site cost) is reinforced, not reversed, by the system-
level perspective. The EB pathway's infrastructure-
conditional cost penalty — absent from site-boundary
analysis — materialises when the decision boundary
is drawn to include the regional grid.

---

## 6. Discussion

### 6.1 What the Boundary Placement Changes

The EB/BB comparison produces different recommendations
depending on where the analytical boundary is drawn.
This is the primary finding, and it has a specific
mechanism: the 38 MW difference in peak incremental
demand between pathways is sufficient to shift the grid
upgrade class in 49% of futures. This upgrade class
difference is the infrastructure-conditional consequence
that site-boundary analysis cannot represent.

It is worth stating precisely what this result does and
does not show. It does not show that EB is the wrong
choice — in 7 of 100 futures, EB produces a lower
system cost, and it eliminates direct emissions
entirely. It shows that the comparison between pathways
is materially different when infrastructure
consequences are within the analytical scope, and that
the difference favours BB in 93 of 100 futures under
the declared ensemble design. The extent to which this
result is robust to ensemble design choices — 
particularly the independence assumption between
multipliers and the headroom multiplier range — should
be tested in any operational application.

The result also illustrates the specific inadequacy of
national-scale scenario analysis for this class of
decision. TIMES-NZ 3.0's Steady/Shift scenarios provide
valuable macroeconomic framing, but neither scenario
can resolve the GXP-level hosting capacity question
that determines the upgrade class in any specific
future. The 8,760-timestep hourly analysis at the GXP
level is not a refinement of national modelling — it
operates at a different analytical scale that the
national model was not designed to replicate.

### 6.2 Limitations

Three limitations of the current PoC are declared in
the analytical scope specification.

**One-pass coupling.** Site dispatch and regional
screening run in sequence without iterative feedback.
Upgrade costs do not influence technology dispatch
decisions. Iterative multi-pass coupling would capture
these feedback effects at the cost of computational
tractability.

**Proportional dispatch.** The CFA dispatch rule
produces the correct qualitative comparison ranking for
a dairy processing facility with well-characterised
operational patterns. Scheduling-grade dispatch would
be needed for fine-grained operational analysis or for
facilities with more complex demand profiles.

**Stylised regional screening.** The regional module
uses capacity-multiplier scaling from EECA headroom
estimates rather than a full network power flow model.
The progressive refinement diagnostics identify this as
the highest-priority development step: the headroom
multiplier drives more of the EB/BB regret sensitivity
than any other uncertain driver.

### 6.3 Generalisability

The framework's three architectural principles —
decision-first boundary specification, thin-waist
artefact governance, ensemble evaluation under deep
uncertainty — are domain-general. The Southland case
demonstrates their application to industrial process
heat decarbonisation. The same principles apply wherever
long-horizon commitments create consequences that cross
convenient physical system boundaries: water
infrastructure planning, regional transport investment,
corporate sustainability strategy, national energy
transition pathways.

The structural condition that makes the DCM approach
relevant is not specific to energy: it is present in
any decision whose consequences propagate across
scales and whose time horizon exceeds the predictive
validity of probability-based forecasting.

---

## 7. Conclusions

Three conclusions follow from this analysis.

**Analytical boundary placement is a consequential
modelling choice.** Drawing the boundary around the
facility produces one recommendation; drawing it around
the decision produces a materially different comparison
in 93 of 100 plausible futures. The difference is not
model error — it is the structural consequence of what
the model was designed to see.

**Modular architecture makes multi-scale decision
analysis tractable.** Each layer can be developed,
validated, and replaced independently. Progressive
refinement governed by regret diagnostics ensures
analytical investment is directed where it most changes
the decision-relevant comparison.

**Regret, robustness, and satisficing are appropriate
evaluative standards under deep uncertainty.** When
probability distributions over futures cannot be
defended, expected value optimisation is not available
as an evaluative standard. The DCM framework
operationalises the alternative standards in a
reproducible, auditable analytical chain.

The framework is open-access at
https://ahmad-mahmoudi-coder.github.io/DCM/.
Proof-of-concept data and pipeline documentation are
available in the associated GitHub repository. Domain
extensions to other infrastructure planning contexts
are invited through the community contribution
architecture documented at the platform.

---

## Acknowledgements

The author thanks supervisors Michael Protheroe and
Michael Gschwendtner at Auckland University of
Technology for guidance throughout the PhD research
programme from which this work derives. The
proof-of-concept analysis uses data from the Energy
Efficiency and Conservation Authority (EECA) Regional
Energy Transition Accelerator programme. The author
is solely responsible for the analytical framework,
its implementation, and the interpretations presented.

---

## References
