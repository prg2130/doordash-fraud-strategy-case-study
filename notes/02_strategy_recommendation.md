# Fraud Strategy Recommendation

## Core Finding

The analysis shows that maximizing fraud detection alone does not maximize
business value.

The optimal intervention depends on the trade-off between:

- fraud prevented
- legitimate customer friction
- operational cost

## Sensitivity Analysis

| Scenario | Recommended Rule | Estimated Net Benefit |
|---|---|---:|
| Low customer friction | D: Product C | $39,703.87 |
| Base case | C: Product C + Credit | $18,905.50 |
| High customer friction | A: Product C + Credit + Amount >= $100 | $15,305.66 |

The preferred rule changes as the assumed cost of customer friction changes.

## Recommended Operating Strategy

Rather than applying one universal fraud rule, use a tiered intervention system.

| Risk Tier | Example Signal | Recommended Action |
|---|---|---|
| Low | No major fraud signals | Approve transaction |
| Medium | Product C + Credit | Step-up verification |
| High | Product C + Credit + Amount >= $100 | Hold / additional verification |
| Very High | Multiple high-risk signals | Decline or manual review |

## Business Recommendation

Fraud prevention should optimize expected business value rather than fraud
recall alone.

Broad rules may capture more fraud but can create substantial customer
friction. More targeted rules reduce false positives but miss more fraudulent
transactions.

The recommended strategy is therefore to match intervention severity to
transaction risk instead of using a universal blocking threshold.
