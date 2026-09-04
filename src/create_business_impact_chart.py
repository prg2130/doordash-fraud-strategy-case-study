import pandas as pd
import matplotlib.pyplot as plt

# Sensitivity-analysis results
data = {
    "Rule": [
        "D: Product C",
        "C: C + Credit",
        "A: C + Credit + Amt >= $100",
        "B: Selected Email Domains"
    ],
    "Low Friction": [
        39703.87,
        33647.50,
        18041.66,
        10691.49
    ],
    "Base Case": [
        -1594.13,
        18905.50,
        17015.66,
        10289.49
    ],
    "High Friction": [
        -70424.13,
        -5664.50,
        15305.66,
        9619.49
    ]
}

df = pd.DataFrame(data)

fig, ax = plt.subplots(figsize=(11, 6))

x = range(len(df))
width = 0.25

ax.bar(
    [i - width for i in x],
    df["Low Friction"],
    width,
    label="Low Friction"
)

ax.bar(
    x,
    df["Base Case"],
    width,
    label="Base Case"
)

ax.bar(
    [i + width for i in x],
    df["High Friction"],
    width,
    label="High Friction"
)

ax.axhline(0, linewidth=1)

ax.set_xticks(list(x))
ax.set_xticklabels(df["Rule"], rotation=10)

ax.set_ylabel("Estimated Net Benefit ($)")
ax.set_title(
    "Fraud Strategy Economics Change With Customer Friction"
)

# Add value labels to bars
for container in ax.containers:
    ax.bar_label(
        container,
        fmt="$%.0f",
        padding=3,
        fontsize=8
    )


ax.legend()

plt.tight_layout()

plt.savefig(
    "charts/business_impact_sensitivity.png",
    dpi=300,
    bbox_inches="tight"
)

print("Chart created: charts/business_impact_sensitivity.png")
