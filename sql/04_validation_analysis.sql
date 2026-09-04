-- Temporal validation of fraud rules
-- Development period: TransactionDT <= 11093712
-- Validation period: TransactionDT > 11093712
--
-- Rules were developed using the earlier period and evaluated
-- on the later period to reduce the risk of overfitting exploratory patterns.

WITH validation AS (
    SELECT *
    FROM read_csv_auto('data/train_transaction.csv')
    WHERE TransactionDT > 11093712
),

rules AS (

    SELECT
        'A: C + Credit + Amt>=100' AS rule_name,
        *
    FROM validation
    WHERE ProductCD = 'C'
      AND card6 = 'credit'
      AND TransactionAmt >= 100

    UNION ALL

    SELECT
        'B: + selected email domains' AS rule_name,
        *
    FROM validation
    WHERE ProductCD = 'C'
      AND card6 = 'credit'
      AND TransactionAmt >= 100
      AND P_emaildomain IN ('gmail.com','outlook.com','icloud.com')

    UNION ALL

    SELECT
        'C: C + Credit' AS rule_name,
        *
    FROM validation
    WHERE ProductCD = 'C'
      AND card6 = 'credit'

    UNION ALL

    SELECT
        'D: Product C' AS rule_name,
        *
    FROM validation
    WHERE ProductCD = 'C'
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
        (SELECT SUM(isFraud) FROM validation),
        2
    ) AS recall_pct,

    ROUND(
        SUM(
            CASE
                WHEN isFraud = 1 THEN TransactionAmt
                ELSE 0
            END
        ),
        2
    ) AS fraud_value_caught

FROM rules
GROUP BY rule_name
ORDER BY recall_pct DESC;
