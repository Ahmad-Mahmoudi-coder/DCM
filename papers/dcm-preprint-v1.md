---
title: "A Decision-Centred Modelling Environment for Long-Horizon Infrastructure Planning Under Deep Uncertainty"
author:
  - name: Seyed Ahmad Mahmoudi Lahijani
    affiliation: Auckland University of Technology
    email: mahmoudi3678@gmail.com
    orcid: ""
date: "2026"
abstract: |
  Long-horizon infrastructure decisions — including industrial 
  decarbonisation commitments — face conditions of deep uncertainty 
  where probability distributions over futures cannot be defended. 
  Conventional energy system models address this through scenario 
  comparison but draw their analytical boundary around the physical 
  system rather than the decision, making infrastructure-conditional 
  consequences invisible. This paper introduces the Decision-Centred 
  Modelling (DCM) framework: a governed, modular analytical environment 
  that inverts this boundary condition by drawing analytical scope 
  around the decision and its consequences, regardless of physical 
  system boundaries.

  The framework rests on three architectural principles: a 
  decision-first boundary principle that defines analytical scope 
  through decision-relevance rather than system extent; a thin-waist 
  artefact governance layer that couples heterogeneous analytical 
  modules through schema-conforming, provenance-carrying exchange 
  contracts; and a progressive refinement philosophy governed by 
  regret diagnostics that identifies where analytical investment most 
  improves decision quality. Under deep uncertainty, the evaluative 
  standards of regret, robustness, and satisficing replace expected 
  value optimisation.

  The framework is demonstrated in a proof of concept evaluating 
  industrial process heat decarbonisation pathways for a major dairy 
  processing facility in Southland, New Zealand. Two pathways — full 
  electrification and biomass switching — are evaluated across a 
  100-future paired ensemble spanning five uncertain drivers. When 
  regional grid infrastructure costs are included within the 
  decision boundary, the biomass pathway is preferred in 93 of 100 
  futures. This finding is invisible to conventional site-boundary 
  analysis. The framework architecture is domain-general; the 
  Southland case demonstrates its application to industrial 
  decarbonisation. The platform is openly available at 
  https://ahmad-mahmoudi-coder.github.io/DCM/.
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

Long-horizon infrastructure decisions share a structural feature 
that undermines the dominant analytical paradigm: the consequences 
that determine whether a decision was well-made extend beyond the 
physical boundary of any single system. A factory that commits 
to electrifying its process heat creates load that propagates 
through the regional electricity network. A region that pursues 
industrial electrification creates infrastructure demand that 
affects grid upgrade timelines and tariff structures for all 
connected users. A national energy model that projects 
electrification pathways affects carbon price expectations that 
alter the relative economics of every competing technology. These 
consequences are not incidental — they are often decisive. Yet 
they are systematically invisible within the analytical frameworks 
most commonly used to support these decisions.

The problem is not computational capacity. Modern energy system 
models — TIMES, PyPSA, MESSAGE, Calliope — can represent 
extraordinary technical complexity. The problem is boundary 
placement. When an analytical model draws its boundary around 
the physical system being optimised, it can represent everything 
inside that boundary with precision and miss everything outside 
with equal precision. Infrastructure-conditional costs, 
cross-scale consequence propagation, and the coupling between 
site-level decisions and regional network constraints fall 
outside the typical modelling boundary. They are not represented 
because the model was not designed to see them — not because 
they are analytically inaccessible.

This paper introduces the Decision-Centred Modelling (DCM) 
framework, which addresses this problem through a single 
architectural inversion: the analytical boundary is drawn around 
the decision and its decision-relevant consequences, not around 
the physical system. The distinction is consequential. Where a 
system-centred model asks "what is the optimal technology for 
this facility?", a decision-centred model asks "how does this 
technology choice perform, from the perspective of all affected 
parties, across the range of futures that cannot be predicted?" 
These are different questions with different analytical 
requirements and different answers.

The framework makes three claims. First, an architectural claim: 
a governed, modular analytical environment organised around the 
decision problem and coupled through thin-waist artefact exchange 
is technically feasible and analytically superior to 
system-centred models for long-horizon infrastructure decisions 
under deep uncertainty. Second, a methodological claim: under 
conditions where probability distributions over futures cannot 
be defended, the evaluative standards of regret, robustness, 
and satisficing should replace expected value optimisation. 
Third, an empirical claim: when the Edendale industrial 
electrification decision is evaluated within the DCM framework, 
the preferred pathway reverses in 93 of 100 plausible futures 
relative to a conventional site-only analysis — a direct 
consequence of boundary placement, not parameter choice.

The remainder of this paper is structured as follows. Section 2 
reviews the adjacent traditions against which the framework is 
positioned. Section 3 specifies the framework design. Section 4 
describes the uncertainty architecture. Section 5 presents the 
Southland proof of concept. Section 6 discusses implications, 
limitations, and generalisability. Section 7 concludes.

---

## 2. Background and Related Work

### 2.1 Energy System Modelling: Power and Limits

The energy system modelling literature has produced a mature set 
of tools for evaluating technology transitions and policy 
pathways. TIMES and its national implementations (including 
TIMES-NZ 3.0) [@marchau2019decision; @eeca2024timesnz] use 
linear programming to identify least-cost configurations of 
national energy systems over multi-decade horizons. PyPSA 
[@pfenninger2018importance] provides open-source network 
optimisation for electricity systems. Calliope and similar 
capacity expansion models enable multi-sector analysis with 
explicit spatial resolution.

These tools share two characteristics relevant to the present 
analysis. First, they draw their analytical boundary around 
the physical system being optimised — the national energy 
mix, the electricity network, the regional industrial cluster. 
This is appropriate for many purposes. It becomes a 
structural limitation when the decision-relevant consequences 
extend across that boundary, as they do for any industrial 
facility whose technology choice creates material infrastructure 
demand at the regional network level. Second, they handle 
uncertainty through scenario comparison. TIMES-NZ 3.0, New 
Zealand's primary national energy model, evaluates two 
structural scenarios (Steady and Shift) that bracket 
four critical uncertainties: economic structure, technology 
progress, behavioural orientation, and the role of gas 
[@eeca2024timesnz]. Two scenarios cannot represent the 
combinatorial uncertainty space that a twenty-year industrial 
commitment faces across multiple independently varying drivers.

### 2.2 The DMDU Tradition

Decision Making under Deep Uncertainty (DMDU) emerged precisely 
because conventional scenario analysis was failing in the 
situations where rigorous analysis was most consequential 
[@marchau2019decision]. Knight's distinction between risk — 
where probabilities are knowable — and uncertainty — where 
they are not [@knight1921risk] — identifies the structural 
condition that DMDU methods address. Under deep uncertainty, 
Simon's satisficing [@simon1955behavioral] is the appropriate 
decision standard: find alternatives that meet acceptable 
thresholds across many futures rather than optimising under 
one assumed future.

Robust Decision Making [@lempert2003shaping] operationalises 
this: evaluate alternatives across a large ensemble of plausible 
futures using regret and robustness rather than expected value. 
Dynamic Adaptive Policy Pathways [@haasnoot2013dynamic] extends 
this by designing decision sequences that can be revised as 
conditions evolve, using monitoring and signposts to trigger 
pathway transitions. Exploratory Modelling and Analysis 
[@kwakkel2016comparing] provides the computational infrastructure 
for large-scale ensemble evaluation. The DMDU tradition provides 
the evaluative standards the DCM framework adopts. Its 
limitation, for the present purpose, is the absence of a 
modular architectural specification for multi-scale 
implementation.

### 2.3 Sequential Decision Analytics

Powell's unified framework for sequential decision analytics 
[@powell2022sequential] classifies any decision method into 
four policy classes: policy function approximations (PFAs), 
cost function approximations (CFAs), value function 
approximations (VFAs), and direct lookahead approximations 
(DLAs). His formulation — finding the policy function $f$ and 
parameters $\theta$ that maximise cumulative contribution 
$\mathbb{E}\left[\sum_{t} C_t(S_t, X^\pi(S_t|\theta))\right]$ — 
subsumes expected utility maximisation and provides a taxonomy 
for classifying the modelling methods available at each 
analytical layer. The DCM framework uses a CFA (proportional 
dispatch) for tractable ensemble evaluation. The DCM framework 
is the appropriate generalisation for conditions of deep 
uncertainty where the expectation operator cannot be applied: 
regret and satisficing replace $\mathbb{E}[\cdot]$ when 
probability distributions over futures are not defensible.

### 2.4 The Analytical Gap

The gap the DCM framework addresses is the intersection of 
three conditions that existing approaches do not jointly 
satisfy: multi-scale consequence visibility (from site through 
regional to national), ensemble-based deep uncertainty 
evaluation, and modular, reproducible, auditable analytical 
architecture. The framework is a response to this gap, 
informed by a systematic review of modelling tools for 
industrial process heat decarbonisation that concluded no 
existing tool met all requirements [@lahijani2025modelling].

---

## 3. Framework Design

### 3.1 The Decision-First Boundary Principle

The foundational architectural commitment of the DCM framework 
is that analytical boundaries are drawn by the decision context, 
not by the physical extent of the system being modelled. The 
decision-relevant boundary is defined as the smallest analytical 
scope within which all consequences material to the comparison 
of alternatives are visible.

For the industrial electrification decision, this boundary 
is larger than the facility boundary. The incremental 
electricity demand created by electrifying an industrial boiler 
propagates through the grid exit point (GXP), affects regional 
network hosting capacity, determines infrastructure upgrade 
requirements, and conditions the annualised infrastructure 
costs that both the facility and the network operator must 
recover. These consequences are decision-relevant — they 
affect whether the electrification pathway is preferred — 
and they are outside the facility boundary. A model that 
draws its boundary at the facility cannot see them.

The decision-first principle specifies that the analytical 
environment must be designed to make these consequences visible, 
regardless of whether they fall within any convenient physical 
boundary. This requires a modular architecture: no single 
monolithic model can simultaneously represent facility dispatch 
at hourly resolution and regional network constraints at the 
GXP level with adequate fidelity at both scales. The answer 
is coupling — governed, thin-waist coupling between 
specialised modules.

### 3.2 Modular Architecture and Thin-Waist Coupling

The DCM framework is organised as a seven-layer analytical 
stack (Figure 1), from facility demand construction through 
site dispatch, GXP interface, regional electricity modelling, 
policy and macroeconomic context, DMDU ensemble evaluation, 
to the decision layer. Each layer is a distinct analytical 
module that can be developed, validated, and replaced 
independently.

The coupling mechanism between layers is a thin-waist 
artefact exchange. The thin-waist principle — originating 
in internet protocol design [@rittel1973dilemmas] — specifies 
that inter-module interfaces must be narrow (carrying only 
what must cross the boundary), explicit (precisely 
schema-specified), and stable (unchanging even as module 
internals evolve). In the DCM framework, this means every 
output that crosses a module boundary is a schema-conforming, 
provenance-carrying, validation-gated artefact. The artefact 
carries: its schema version, the analytical inputs that 
produced it, a SHA-256 hash for integrity verification, 
the validation record that accepted it into the comparison 
chain, and the timestamp and context of its creation.

This architecture has two analytical consequences. First, it 
enables genuine reproducibility: every finding can be traced 
to every assumption through the artefact chain, and any 
module can be replaced without disturbing the rest of the 
chain provided the interface contract is preserved. Second, 
it enables progressive refinement: modules can be developed 
to minimum viable specification and improved where regret 
diagnostics reveal that improvement would change the 
decision-relevant comparison.

### 3.3 Deep Uncertainty Evaluation Standards

The framework evaluates pathway alternatives using three 
complementary metrics that together characterise decision 
quality under deep uncertainty.

**Regret** measures the cost of a chosen strategy relative 
to the best available strategy in the same future. For 
pathway $s$ under future $\omega$:

$$\rho(s,\omega) = Z(s,\omega) - \min_{s' \in S} Z(s',\omega)$$

where $Z(s,\omega)$ is the total system cost of pathway $s$ 
under future $\omega$, including site operating costs and 
annualised infrastructure costs. Regret is zero for the 
minimum-cost pathway in each future and positive for all 
others. Maximum regret $R_{\max}(s) = \max_\omega \rho(s,\omega)$ 
measures the worst-case cost of choosing $s$.

**Robustness** is a strategy's property of performing 
acceptably across many futures rather than optimally under 
one. The **satisficing rate** at threshold $\tau$ measures 
the fraction of futures in which total cost falls within 
an acceptable range:

$$\text{SR}(s,\tau) = \frac{|\{\omega : Z(s,\omega) \leq \tau\}|}{|\Omega|}$$

**Win rate** measures the fraction of futures in which 
pathway $s$ achieves the minimum system cost:

$$\text{WR}(s) = \frac{|\{\omega : \rho(s,\omega) = 0\}|}{|\Omega|}$$

These three standards jointly characterise the decision. 
A pathway with high satisficing rate, low mean regret, and 
low maximum regret is preferred under deep uncertainty — 
regardless of which specific futures are most likely, 
and without requiring probability distributions over $\Omega$.

### 3.4 Progressive Refinement

The framework's development philosophy is governed by 
regret diagnostics rather than completeness aspirations. 
A minimum viable implementation — honest about its 
limitations, architecturally complete, and analytically 
rigorous within its scope — is more valuable than a 
comprehensive but opaque system. The regret diagnostics 
reveal which uncertain drivers most determine the pathway 
comparison, pointing toward where analytical investment 
would most change the decision-relevant result. This 
makes the framework self-directing: it identifies its 
own next development priority.

---

## 4. Uncertainty Architecture

Long-horizon decisions face three qualitatively distinct 
types of uncertainty that require different analytical 
treatments.

**Layer 1 — Parametric uncertainty** covers conditions 
where uncertain drivers can be characterised by plausible 
ranges and sampled via structured ensemble methods. 
Capital cost multipliers, electricity tariff trajectories, 
carbon price scenarios, and demand growth rates are 
parametric uncertainties. Their values are unknown but 
their ranges can be calibrated from historical data and 
expert elicitation. The proof-of-concept ensemble 
samples Layer 1 uncertainty through Latin Hypercube 
Sampling across five drivers: electricity price, biomass 
price, ETS carbon price, GXP headroom capacity, and 
upgrade capital cost.

**Layer 2 — Structural uncertainty** covers conditions 
where the world-model itself is contested — not just 
parameter values but the structural assumptions of the 
analytical framework. Whether LNG import infrastructure 
is developed or gas exits the energy mix entirely; 
whether New Zealand's primary sector maintains dairy 
export trajectories or faces structural demand decline. 
These are discrete branches in the space of possible 
futures, not points in a continuous parameter space. 
TIMES-NZ 3.0's Steady and Shift scenarios represent 
structural uncertainty at the national level, providing 
the lower ($52/\text{tCO}_2$, 2035) and upper 
($260/\text{tCO}_2$, 2050) bounds for the ETS price 
dimension of the DCM ensemble.

**Layer 3 — Deep narrative uncertainty** covers genuinely 
unmodelable systemic shocks: geopolitical ruptures, 
pandemic-scale disruptions, regulatory reversals. These 
cannot be assigned defensible probabilities and cannot 
be represented as parameter draws. They can only be 
evaluated as stress tests. The robustness-first 
evaluation philosophy addresses Layer 3 indirectly: 
decisions that perform well across Layers 1 and 2 
tend to be more resilient to Layer 3 shocks than 
decisions optimised for a single assumed future.

This three-layer taxonomy extends Knight's risk/uncertainty 
distinction [@knight1921risk] by specifying three 
operationally distinct regimes and connecting each to 
a tractable analytical treatment.

---

## 5. Proof of Concept: Edendale–Southland

### 5.1 Decision Context

The Fonterra Edendale dairy processing facility in 
Southland, New Zealand, is one of the largest industrial 
process heat consumers in the Southern Hemisphere, with 
an annual heat demand of 819 GWh. Coal provides 
approximately 80% of process heat at baseline (2020). 
New Zealand's National Environmental Standards mandate 
coal phase-out from industrial process heat by 2037. 
Two primary decarbonisation pathways are available: 
full electrification via electric boilers (EB pathway) 
or biomass substitution via biomass boilers (BB pathway). 
The decision involves a capital commitment with a 20+ 
year operational life. The DCM proof of concept 
evaluates this decision using a four-epoch trajectory 
(2020, 2025, 2028, 2035) within the framework's 
multi-scale architecture.

### 5.2 Analytical Pipeline

The PoC implements five of the seven DCM layers:

**Demand construction (Layer 1):** A synthetic 
DemandPack is constructed for each epoch from 
EECA's Regional Heat Demand Database 
[@eeca2024rhdd], representing Edendale's 
hourly heat demand profile at 8,760-timestep 
annual resolution with seasonal and operational 
variability.

**Site dispatch (Layer 2):** Proportional dispatch 
allocates heat demand across committed technology 
units in proportion to nameplate capacity. Annual 
costs include fuel costs, electricity tariffs 
(where applicable), carbon costs under the NZ ETS, 
and fixed and variable operation costs. The EB 
pathway eliminates direct CO₂ emissions (0 tCO₂) 
at an annual site cost of NZD 91.0M in 2035. The 
BB pathway retains residual emissions (1,610 tCO₂/year) 
at NZD 76.8M/year — a private cost advantage of 
NZD 14.2M/year.

**GXP interface (Layer 3):** The SignalsPack 
exported from the site dispatch module carries the 
incremental electricity demand signal: the hourly 
difference between EB or BB electricity import and 
the 2020 coal-baseline import. The EB pathway 
creates a peak incremental demand of 133 MW at the 
Mararoa-Waimea GXP (EDN0331); the BB pathway 
creates 95 MW. This signal, validated against 
the GXP headroom estimates from EECA's Southland 
RETA report [@eeca2024southland], drives the 
regional screening.

**Regional screening (Layer 4):** For each future 
$\omega$ in the 100-future ensemble, the 
incremental electricity signal is compared against 
the available GXP headroom — scaled by the headroom 
multiplier $U_{\text{head}}^\omega$ drawn from the 
ensemble design. Where the signal exceeds available 
headroom, an upgrade is triggered. Four upgrade 
options are available (N+21, N+32, N+97, N+150 MW), 
each with declared capital costs. The minimum 
sufficient upgrade is selected for each future.

**DMDU evaluation (Layer 6):** The system cost for 
each pathway under each future combines the site 
operating cost and the annualised upgrade capital 
cost (10-year amortisation at 7% real discount rate). 
Regret, satisficing rate, and win rate are computed 
across the 100-future ensemble.

### 5.3 Ensemble Design

The 100-future paired ensemble uses Latin Hypercube 
Sampling across six uncertain multipliers, calibrated 
against the TIMES-NZ 3.0 Steady/Shift scenario bounds 
and EECA's Southland RETA capacity estimates:

| Multiplier | P10 | Median | P90 |
|---|---|---|---|
| Electricity price | 0.785 | 0.987 | 1.184 |
| Biomass cost | 1.133 | 1.486 | 2.038 |
| ETS carbon price | 0.950 | 1.275 | 1.654 |
| GXP headroom | 0.817 | 0.890 | 0.950 |
| Upgrade capital | 0.920 | 1.071 | 1.285 |
| VOLL penalty | 10,000 | 15,000 | 20,000 NZD/MWh |

Futures are paired: both EB and BB pathways are 
evaluated under identical multiplier draws, enabling 
unambiguous pathway comparison.

### 5.4 Results

**Site-layer dispatch results** show the expected 
directional trade-off: the EB pathway eliminates 
direct emissions but at a higher private cost 
(NZD 91.0M/year vs NZD 76.8M/year for BB). 
From within the site boundary, the decision appears 
straightforward: both pathways meet the coal phase-out 
requirement; BB has a substantial cost advantage; 
EB has the stronger emissions profile.

**Grid infrastructure results** reveal what the 
site boundary conceals. Under the EB pathway, 
100 of 100 futures require a grid upgrade — 51 
requiring N+97 MW (NZD 28.5M capex) and 49 
requiring N+150 MW (NZD 52.0M capex, the major 
subtransmission reinforcement class). The BB 
pathway requires the N+97 MW upgrade in all 100 
futures but never triggers the N+150 MW class. 
The distinction is the 38 MW difference in peak 
incremental demand between pathways, which is 
sufficient to trigger the costlier upgrade class 
in 49% of futures under EB.

**System-cost robustness results** are shown in 
Table 1. The BB pathway is preferred (lower 
system cost) in 93 of 100 futures. EB's 
satisficing rate against the declared cost 
threshold is 35% versus 88% for BB. EB's 
maximum regret is NZD 18.9M/year versus NZD 
4.5M/year for BB. EB carries a 49% exposure 
to the N+150 MW upgrade class; BB carries zero 
exposure to that class in any future.

**Table 1: Robustness comparison — EB vs BB 
pathways, 100-future paired ensemble**

| Metric | EB Pathway | BB Pathway |
|---|---|---|
| Annual site cost (NZD M) | 91.0 | 76.8 |
| Direct CO₂ (tCO₂/year) | 0 | 1,610 |
| Satisficing rate | 35% | 88% |
| Mean system regret (NZD M/yr) | 8.8 | 0.1 |
| Maximum regret (NZD M/yr) | 18.9 | 4.5 |
| N+150 MW upgrade exposure | 49% | 0% |
| System-cost win rate | 7% | 93% |

**The boundary finding** is that the private cost 
advantage of BB (NZD 14.2M/year lower site cost) 
is reinforced, not reversed, by the system-level 
perspective. In the seven futures where EB achieves 
lower system cost, the margin is small. In the 93 
futures where BB has lower system cost, the margin 
reflects the infrastructure-conditional penalty of 
EB's higher peak demand.

This finding is invisible to a conventional 
site-boundary analysis. From inside the facility, 
both pathways require a grid upgrade; the upgrade 
economics are outside the model. From within the 
DCM framework, the grid upgrade class is 
endogenous to the comparison. The 49% vs 0% 
N+150 MW exposure differential is not a detail — 
it is the finding that determines the preferred 
pathway in 93 of 100 plausible futures.

---

## 6. Discussion

### 6.1 What the Framework Reveals

The Edendale PoC demonstrates the primary analytical 
value of decision-centred boundary placement: consequences 
that are invisible within conventional modelling scope 
become analytically tractable. The infrastructure-
conditional cost penalty of the EB pathway is a real 
economic consequence that any actor in the comparison 
chain — the facility operator, the network operator, 
the regulator, the investor — will eventually face. 
The DCM framework makes it visible before the 
commitment is made.

The result also demonstrates the inadequacy of two-
scenario national modelling for site-level decisions. 
The TIMES-NZ Steady/Shift pair provides valuable 
macroeconomic framing but cannot resolve the 
GXP-level hosting capacity question that determines 
the upgrade class in any specific future. The 8,760-
timestep hourly analysis at the GXP level is not 
a refinement of the national model — it is a 
different analytical layer that the national model 
cannot replicate.

### 6.2 Limitations

Three limitations of the current proof of concept 
are declared in the analytical scope specification 
and should be noted explicitly.

**One-pass coupling.** The current implementation 
runs site dispatch and regional screening in 
sequence without iterative feedback. The GXP signal 
does not feed back to revise dispatch decisions, 
and upgrade costs do not influence technology 
choice. Iterative multi-pass coupling would 
capture these feedback effects at the cost of 
computational tractability.

**Proportional dispatch.** The site dispatch module 
uses a proportional allocation rule rather than a 
scheduling-optimised dispatch. For a dairy 
processing facility with well-characterised 
operational patterns, this produces the correct 
qualitative comparison ranking. Scheduling-grade 
dispatch would be needed for fine-grained 
operational analysis.

**Stylised regional screening.** The regional 
module uses capacity-multiplier scaling from EECA 
headroom estimates rather than a full network 
power flow model. Dedicated PyPSA-NZ regional 
modelling would provide higher fidelity at the 
cost of substantial additional complexity. The 
progressive refinement philosophy identifies 
this as the highest-priority next development step: 
the headroom multiplier is the most influential 
driver of the EB vs BB comparison.

### 6.3 Generalisability

The framework's architectural principles — 
decision-first boundary placement, thin-waist 
artefact governance, ensemble-based deep uncertainty 
evaluation — are domain-general. The Southland 
case demonstrates their application to industrial 
process heat decarbonisation. The same principles 
apply wherever long-horizon commitments create 
consequences that cross convenient system 
boundaries: water infrastructure planning, 
regional transport investment, corporate 
sustainability strategies, national energy 
transition pathways.

The boundary condition that makes the DCM approach 
necessary is not unique to industrial energy: it 
is a structural feature of any decision whose 
consequences are distributed across scales and 
whose time horizon exceeds the predictive validity 
of probability-based forecasting.

---

## 7. Conclusions

This paper has introduced the Decision-Centred 
Modelling framework and demonstrated its application 
to industrial process heat decarbonisation in 
New Zealand. Three conclusions follow from the 
analysis.

First, analytical boundary placement is a 
consequential modelling choice, not a technical 
detail. Drawing the boundary around the facility 
produces one answer; drawing it around the decision 
produces a different answer in 93 of 100 plausible 
futures. The difference is not model error — it is 
the difference between what the model was designed 
to see and what the decision actually requires.

Second, the modular, thin-waist architectural 
approach makes multi-scale decision analysis 
tractable without requiring a single comprehensive 
model. Each layer can be developed, validated, and 
replaced independently. The framework's progressive 
refinement philosophy ensures that analytical 
investment is directed where it most improves the 
decision-relevant comparison, as revealed by regret 
diagnostics.

Third, under conditions of deep uncertainty, the 
evaluative standards of regret, robustness, and 
satisficing provide more defensible guidance than 
expected value optimisation. The DCM framework 
operationalises these standards in a reproducible, 
auditable analytical chain that can be directly 
engaged by domain experts, policy analysts, and 
decision-makers.

The framework is open-access at 
https://ahmad-mahmoudi-coder.github.io/DCM/. 
The proof-of-concept data and pipeline documentation 
are available in the associated GitHub repository. 
Domain extensions to other infrastructure planning 
contexts are invited through the framework's 
community contribution architecture.

---

## References
