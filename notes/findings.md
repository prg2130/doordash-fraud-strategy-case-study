### 3. Payment Method and Fraud Risk

Credit transactions show materially higher fraud risk than debit transactions.

Across the dataset:

- Credit fraud rate: 6.68%
- Debit fraud rate: 2.43%

Credit transactions therefore have approximately 2.75x the fraud rate of debit transactions.

This relationship persists across most transaction-value segments. For example:

- Below $25: Credit 13.14% vs Debit 4.66%
- $25-$50: Credit 8.10% vs Debit 2.08%
- $50-$100: Credit 6.08% vs Debit 2.06%
- $250-$500: Credit 7.27% vs Debit 3.89%
- $500-$1,000: Credit 7.88% vs Debit 3.88%

The $1,000+ segment is an exception, where credit and debit fraud rates are similar.

### Card Network

Discover has the highest overall fraud rate among major card networks at 7.73%, compared with approximately 3.48% for Visa, 3.43% for Mastercard, and 2.87% for American Express.

The elevated Discover rate does not disappear after separating credit and debit transactions. Discover credit transactions have a 7.93% fraud rate, compared with 6.92% for Mastercard credit, 6.81% for Visa credit, and 2.86% for American Express credit.

However, Visa represents substantially greater absolute fraud-associated transaction value because of its much larger transaction volume.

### Business Interpretation

Payment type appears to be a useful fraud-risk segmentation signal in this dataset.

Credit transactions consistently show higher fraud rates than debit transactions across most transaction-value segments.

However, these relationships are descriptive and should not be interpreted as causal.

A risk-based fraud strategy could use payment type and card network alongside transaction value and other behavioral or identity signals rather than applying blanket restrictions to any payment method or network.# Marketplace Fraud Strategy Analysis
## Working Findings

### 1. Baseline

Dataset contains 590,540 transactions.

20,663 transactions are labeled as fraud.

Overall transaction fraud rate: 3.50%.

Total transaction value: approximately $79.74 million.

Fraud-associated transaction value: approximately $3.08 million.

Fraud represents approximately 3.87% of transaction value.


### 2. Transaction Value and Fraud Risk

Fraud risk is not simply higher for larger transactions.

Transactions below $25 have the highest fraud rate at 6.97%, compared with the overall baseline of 3.50%. However, these transactions represent only 1.52% of total fraud-associated transaction value.

The $250-$500 and $500-$1,000 segments have fraud rates of 5.28% and 5.75%, respectively, while also accounting for substantial fraud-associated transaction value.

Transactions between $100 and $1,000 collectively account for approximately 72.75% of all fraud-associated transaction value.

### Business Interpretation

Fraud rate alone should not determine intervention priority.

Very small transactions have high fraud incidence but relatively low financial exposure. The $250-$1,000 transaction range appears particularly important because it combines elevated fraud rates with significant financial exposure.

A marketplace fraud strategy should therefore consider both:

1. Probability of fraud
2. Financial value at risk

rather than optimizing solely for fraud detection volume.
