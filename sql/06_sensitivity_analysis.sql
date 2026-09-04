WITH rule_results AS (

    SELECT 'D: Product C' AS rule_name,
           15838 AS flagged,
           13766 AS legitimate_flagged,
           103842.34 AS fraud_value

    UNION ALL
    SELECT 'C: C + Credit',
           6045, 4914, 61900.62

    UNION ALL
    SELECT 'A: C + Credit + Amt>=100',
           502, 342, 24034.57

    UNION ALL
    SELECT 'B: + selected email domains',
           229, 134, 13985.61
),

scenarios AS (

    SELECT 'Low friction' AS scenario,
           0.80 AS prevention_rate,
           2.00 AS friction_cost,
           1.00 AS intervention_cost

    UNION ALL

    SELECT 'Base case',
           0.80,
           5.00,
           1.00

    UNION ALL

    SELECT 'High friction',
           0.80,
           10.00,
           1.00

)

SELECT
    scenario,
    rule_name,

    ROUND(
        fraud_value * prevention_rate,
        2
    ) AS expected_fraud_prevented,

    ROUND(
        legitimate_flagged * friction_cost,
        2
    ) AS friction_cost,

    ROUND(
        flagged * intervention_cost,
        2
    ) AS operational_cost,

    ROUND(
        (fraud_value * prevention_rate)
        - (legitimate_flagged * friction_cost)
        - (flagged * intervention_cost),
        2
    ) AS estimated_net_benefit

FROM rule_results
CROSS JOIN scenarios

ORDER BY scenario, estimated_net_benefit DESC;
