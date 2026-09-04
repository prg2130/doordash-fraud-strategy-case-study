-- Fraud Rule Evaluation
-- Goal: Compare candidate fraud intervention rules on
-- precision, fraud capture, false positives, and value at risk.

WITH base AS (
    SELECT *
    FROM read_csv_auto('data/train_transaction.csv')
),

rules AS (

    -- Rule A: Product C + credit card + transaction >= $100
    SELECT
        'A: C + Credit + Amt>=100' AS rule_name,
        *
    FROM base
    WHERE ProductCD = 'C'
      AND card6 = 'credit'
      AND TransactionAmt >= 100

    UNION ALL

    -- Rule B: Rule A + selected high-risk email domains
    SELECT
        'B: A + selected email domains' AS rule_name,
        *
    FROM base
    WHERE ProductCD = 'C'
      AND card6 = 'credit'
      AND TransactionAmt >= 100
      AND P_emaildomain IN (
          'gmail.com',
          'outlook.com',
          'icloud.com'
      )

    UNION ALL

    -- Rule C: Higher transaction threshold
    SELECT
        'C: C + Credit + Amt>=250' AS rule_name,
        *
    FROM base
    WHERE ProductCD = 'C'
      AND card6 = 'credit'
      AND TransactionAmt >= 250
)

SELECT
    rule_name,

    COUNT(*) AS flagged_transactions,

    SUM(isFraud) AS fraud_caught,

    COUNT(*) - SUM(isFraud) AS legitimate_flagged,

    ROUND(
        100.0 * SUM(isFraud) / COUNT(*),
        2
    ) AS precision_pct,

    ROUND(
        100.0 * SUM(isFraud) /
        (SELECT SUM(isFraud) FROM base),
        2
    ) AS total_fraud_capture_pct,

    ROUND(
        SUM(
            CASE
                WHEN isFraud = 1 THEN TransactionAmt
                ELSE 0
            END
        ),
        2
    ) AS fraud_value_caught,

    ROUND(
        SUM(
            CASE
                WHEN isFraud = 0 THEN TransactionAmt
                ELSE 0
            END
        ),
        2
    ) AS legitimate_value_at_risk,

    ROUND(
        SUM(CASE WHEN isFraud = 0 THEN TransactionAmt ELSE 0 END)
        /
        NULLIF(
            SUM(CASE WHEN isFraud = 1 THEN TransactionAmt ELSE 0 END),
            0
        ),
        2
    ) AS legitimate_value_per_fraud_value

FROM rules

GROUP BY rule_name
ORDER BY rule_name;
