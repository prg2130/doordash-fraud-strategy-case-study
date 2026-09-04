-- Marketplace Fraud Strategy Project
-- Baseline Fraud Analysis

-- 1. Total transactions
SELECT
    COUNT(*) AS total_transactions
FROM read_csv_auto('data/train_transaction.csv');

-- 2. Fraud transactions and fraud rate
SELECT
    COUNT(*) AS total_transactions,
    SUM(isFraud) AS fraud_transactions,
    ROUND(100.0 * SUM(isFraud) / COUNT(*), 2) AS fraud_rate_pct
FROM read_csv_auto('data/train_transaction.csv');

-- 3. Transaction value associated with fraud
SELECT
    ROUND(SUM(TransactionAmt), 2) AS total_transaction_value,
    ROUND(
        SUM(
            CASE
                WHEN isFraud = 1 THEN TransactionAmt
                ELSE 0
            END
        ),
        2
    ) AS fraud_transaction_value,
    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN isFraud = 1 THEN TransactionAmt
                ELSE 0
            END
        ) / SUM(TransactionAmt),
        2
    ) AS fraud_value_pct
FROM read_csv_auto('data/train_transaction.csv');

-- 4. Average transaction value: legitimate vs fraud
SELECT
    isFraud,
    COUNT(*) AS transactions,
    ROUND(AVG(TransactionAmt), 2) AS avg_transaction_value
FROM read_csv_auto('data/train_transaction.csv')
GROUP BY isFraud
ORDER BY isFraud;