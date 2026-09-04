WITH rule_results AS (

    SELECT
        'D: Product C' AS rule_name,
        15838 AS flagged_transactions,
        2072 AS fraud_caught,
        13766 AS legitimate_flagged,
        103842.34 AS fraud_value_caught

    UNION ALL

    SELECT
        'C: C + Credit',
        6045,
        1131,
        4914,
        61900.62

    UNION ALL

    SELECT
        'A: C + Credit + Amt>=100',
        502,
        160,
        342,
        24034.57

    UNION ALL

    SELECT
        'B: + selected email domains',
        229,
        95,
        134,
        13985.61
),

assumptions AS (

    SELECT
        0.80 AS fraud_prevention_rate,
        5.00 AS legitimate_friction_cost,
        1.00 AS intervention_cost

)

SELECT
    rule_name,

    flagged_transactions,

    fraud_caught,

    legitimate_flagged,

    ROUND(fraud_value_caught, 2)
        AS fraud_value_flagged,

    ROUND(
        fraud_value_caught * fraud_prevention_rate,
        2
    ) AS expected_fraud_prevented,

    ROUND(
        legitimate_flagged * legitimate_friction_cost,
        2
    ) AS customer_friction_cost,

    ROUND(
        flagged_transactions * intervention_cost,
        2
    ) AS operational_cost,

    ROUND(
        (fraud_value_caught * fraud_prevention_rate)
        - (legitimate_flagged * legitimate_friction_cost)
        - (flagged_transactions * intervention_cost),
        2
    ) AS estimated_net_benefit

FROM rule_results
CROSS JOIN assumptions

ORDER BY estimated_net_benefit DESC;
