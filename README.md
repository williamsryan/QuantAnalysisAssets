# 📊 QuantAnalysisAssets

*A central repository of code, models, notebooks, and guides for quantitative analysis and financial modeling.*

This repository serves as the technical companion to [williamsryan.github.io](https://williamsryan.github.io), containing projects, experiments, and research artifacts across finance, sports analytics, forecasting, and statistical inference. While Julia is heavily featured, this repo is intentionally multi-language and format-agnostic—housing Python notebooks, Julia Pluto files, markdown guides, and reproducible workflows.

It also powers an interactive **GitHub Pages site** for direct access to rendered content and interactive components.

---

## 🗂️ Repository Structure

```
QuantAnalysisAssets/
├── data/         # Sample datasets (real or synthetic)
├── notebooks/    # Jupyter, Pluto, and Colab notebooks
├── src/          # Source code in Julia, Python, or R
├── guides/       # Markdown tutorials and theory writeups
├── tests/        # Unit and validation tests
├── examples/     # Minimal working examples
├── docs/         # GitHub Pages site content
├── README.md
├── .gitignore
```

---

## 🌐 GitHub Pages

This repository is linked to GitHub Pages for an interactive, browsable experience:

📎 **Live site:** [https://williamsryan.github.io/QuantAnalysisAssets](https://williamsryan.github.io/QuantAnalysisAssets) *(enable under Settings → Pages)*

Content includes:

* Linked guides from `guides/`
* Embedded notebooks via nbviewer or Pluto
* Interactive visualizations (via JS/PlutoHTML/Observable)

---

## ⚙️ Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/williamsryan/QuantAnalysisAssets.git
cd QuantAnalysisAssets
```

### 2. Choose a Language Environment

This repo contains both Julia and Python content. You can activate either:

#### 📦 Julia:

```julia
using Pkg
Pkg.activate(".")
Pkg.instantiate()
```

#### 🐍 Python (if `requirements.txt` exists):

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

---

## 🔍 Featured Projects

### ⚾ Strikeout Forecasting (MLB Pitcher K%)

* Notebook: `notebooks/k_forecast.jl`
* Languages: Julia
* Concepts: Feature engineering, Ridge/Forest regression, validation

### 📈 Finance Time Series Tools *(Coming Soon)*

* Languages: Julia + Python
* Topics: Returns modeling, portfolio risk, Bayesian inference

### 📓 Markdown Guides

* Found under `guides/`
* Covering: Time-series modeling, backtesting, model explainability, Monte Carlo simulations

---

## 🧪 Running Tests

```julia
Pkg.test()  # For Julia code
```

```bash
pytest tests/  # For Python-based tests
```

---

## 🛣️ Roadmap

* [ ] Add risk model walkthroughs (VaR, CVaR)
* [ ] Interactive parameter dashboards (PlutoUI, Panel)
* [ ] Deployable financial calculators via GitHub Pages
* [ ] Sports analytics expansion: team-level and play-by-play data

---

## 🤝 Contributing

Pull requests and ideas are welcome. To contribute:

1. Fork this repo
2. Create a new branch (`git checkout -b feature/my-feature`)
3. Commit your work (`git commit -m "My addition"`)
4. Push (`git push origin feature/my-feature`)
5. Submit a Pull Request

---

## 📄 License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

## 🔗 Author & Contact

**Ryan Williams**
🔗 [Personal Website](https://williamsryan.github.io)
💼 [LinkedIn](https://www.linkedin.com/in/ryan-rpwilliams)

> *“A playground for models and metrics—quantified, visualized, and reproducible.”*
