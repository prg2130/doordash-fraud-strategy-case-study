import pandas as pd
import matplotlib.pyplot as plt
from pathlib import Path

# -----------------------------
# Setup
# -----------------------------

Path("charts").mkdir(exist_ok=True)

df = pd.read_csv("outputs/validation_results.csv")

# Shorter labels for charts
label_map = {
    "D: Product C": "D: Product C",
    "C: C + Credit": "C: C + Credit",
    "A: C + Credit + Amt>=100": "A: C + Credit + ≥$100",
    "B: + selected email domains": "B: + Email Filter"
}

df["label"] = df["rule_name"].map(label_map)


# -----------------------------
# Chart 1: Precision vs Recall
# -----------------------------

plt.figure(figsize=(9, 6))

plt.scatter(
    df["recall_pct"],
    df["precision_pct"],
    s=140
)

for _, row in df.iterrows():
    plt.annotate(
        row["label"],
        (row["recall_pct"], row["precision_pct"]),
        xytext=(7, 5),
        textcoords="offset points",
        fontsize=9
    )

plt.axhline(
    y=3.48,
    linestyle="--",
    linewidth=1,
    label="Validation baseline fraud rate (3.48%)"
)

plt.xlabel("Fraud Recall (%)")
plt.ylabel("Precision (%)")
plt.title("Fraud Rule Trade-off: Precision vs. Recall")
plt.grid(alpha=0.25)
plt.legend()
plt.tight_layout()

plt.savefig(
    "charts/precision_vs_recall.png",
    dpi=300,
    bbox_inches="tight"
)

plt.close()


# -----------------------------
# Chart 2: Fraud vs Legitimate
# transactions flagged
# -----------------------------

plot_df = df.sort_values("fraud_caught")

plt.figure(figsize=(10, 6))

plt.barh(
    plot_df["label"],
    plot_df["fraud_caught"],
    label="Fraud caught"
)

plt.barh(
    plot_df["label"],
    plot_df["legitimate_flagged"],
    left=plot_df["fraud_caught"],
    alpha=0.45,
    label="Legitimate transactions flagged"
)

plt.xlabel("Transactions Flagged")
plt.title("Fraud Detection vs. Customer Friction")
plt.legend()
plt.tight_layout()

plt.savefig(
    "charts/fraud_vs_legitimate_flagged.png",
    dpi=300,
    bbox_inches="tight"
)

plt.close()


# -----------------------------
# Chart 3: Fraud value caught
# -----------------------------

plot_df = df.sort_values("fraud_value_caught")

plt.figure(figsize=(10, 6))

bars = plt.barh(
    plot_df["label"],
    plot_df["fraud_value_caught"]
)

for bar, value in zip(bars, plot_df["fraud_value_caught"]):
    plt.text(
        value,
        bar.get_y() + bar.get_height() / 2,
        f" ${value:,.0f}",
        va="center",
        fontsize=9
    )

plt.xlabel("Fraud Transaction Value Identified ($)")
plt.title("Fraud Value Identified by Rule")
plt.tight_layout()

plt.savefig(
    "charts/fraud_value_caught.png",
    dpi=300,
    bbox_inches="tight"
)

plt.close()


print("Charts created successfully:")
print(" - charts/precision_vs_recall.png")
print(" - charts/fraud_vs_legitimate_flagged.png")
print(" - charts/fraud_value_caught.png")
