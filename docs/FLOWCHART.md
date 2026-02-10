# docs/FLOWCHART.md
# FLOWCHART — All Flows (Mermaid)

```mermaid
flowchart TD
  A[BOOT: Preload assets] --> B[START_MENU]
  B -->|Tap Start| C[PLAYING]
  B -->|Sound Toggle| B
  B -->|Quit/Close| Z((End))

  C -->|Tap Jump| C
  C -->|Pause button| D[PAUSED]
  D -->|Resume| C
  D -->|Restart| R[RESTARTING]
  D -->|Sound Toggle| D

  C -->|Collect Heart| C
  C -->|Reach Note Trigger| C
  C -->|Collision with hazard| E[HIT_RECOVERY]
  E -->|After 0.6-1.0s| F[Reset to Checkpoint]
  F --> C

  C -->|Reach Finish Trigger| G[FINISH_CUTSCENE]
  G -->|Cutscene completes| H[VALENTINE_PROMPT]

  H -->|YES| I[CELEBRATION]
  H -->|Restart| R
  H -->|Sound Toggle| H

  I -->|Restart| R
  I -->|Close tab| Z

  R -->|Reset world state + counters| B
