# Phillies Take-Home Assessment Submission

### Candidate: Ryan Williams

### Role: Quantitative Analyst, Predictive Modeling

### Date: \[Submission Date]

---

## Overview

This submission includes responses to all questions in the Philadelphia Phillies' take-home assessment. It is organized in two main parts:

1. **Conceptual and Analytical Questions (Q1–Q10)**
   Presented in a standalone PDF (`written_responses.pdf`). These questions assess reasoning, probability, baseball-specific knowledge, and decision-making under uncertainty.

2. **Predictive Modeling Task (Q11)**
   Delivered via a Jupyter Notebook (`phillies_kpercent_model.ipynb`) with code, markdown, and visualizations. The notebook is also provided as a static PDF for convenience (`phillies_kpercent_model.pdf`).

---

## File Structure

```
/phillies_takehome/
├── written_responses.pdf            # Written responses to Questions 1–10
├── phillies_kpercent_model.ipynb    # Full notebook for Question 11
├── phillies_kpercent_model.pdf      # Exported view of notebook (Q11)
└── README.md                        # This file
```

---

## Q11 Modeling Summary

The task was to predict each MLB pitcher's **2024 Strikeout Percentage (K%)** using prior-season data, with optional feature augmentation.

### Methodology Highlights:

* Built a baseline linear regression model using prior year K%, TBF, and age
* Developed an advanced gradient-boosted tree model (LightGBM) with cross-validation
* Feature-engineered past performance trends
* Structure and code are fully reproducible, with clearly commented steps

### Optional Enhancements:

* Notebook includes hooks for integrating additional data (e.g., fastball velocity, Stuff+ metrics) using `pybaseball` or FanGraphs exports

---
