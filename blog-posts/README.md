# Julia and Pluto.jl Setup Guide for Quantitative Finance

## Installation and Initial Setup

### 1. Installing Julia
```bash
# For macOS (using Homebrew)
brew install julia

# For Linux (Ubuntu/Debian)
wget https://julialang.org/downloads/julia-latest-linux64.tar.gz
tar -xvzf julia-latest-linux64.tar.gz

# For Windows
# Download installer from official Julia website
```

### 2. First-Time Julia Configuration
```julia
# Open Julia REPL
julia

# Install Pluto and key financial packages
using Pkg
Pkg.add([
    "Pluto",           # Reactive Notebooks
    "PlutoUI",         # Additional UI Components
    "DataFrames",      # Data Manipulation
    "CSV",             # CSV File Handling
    "Plots",           # Visualization
    "StatsBase",       # Statistical Functions
    "Distributions",   # Probability Distributions
    "PyCall"           # Python Interoperability
])
```

## Setting Up Your Development Environment

### Recommended VS Code Setup
1. Install VS Code
2. Install Julia extension
3. Configure Julia path

### Launching Pluto Notebooks
```bash
# From terminal
julia -e "using Pluto; Pluto.run()"
```

## Quantitative Finance Starter Notebook

```julia
### A Pluto.jl notebook ###
# This is a sample reactive notebook demonstrating financial modeling

### ---- Imports and Setup ---- ###
using DataFrames
using Distributions
using Plots
using StatsBase

### ---- Simple Monte Carlo Pricer ---- ###
function monte_carlo_stock_simulation(
    S0::Float64,      # Initial stock price
    μ::Float64,       # Expected return
    σ::Float64,       # Volatility
    T::Float64,       # Time horizon
    N::Int,           # Number of simulations
    steps::Int        # Number of time steps
)
    # Generate stock price paths
    dt = T / steps
    paths = zeros(N, steps+1)
    paths[:, 1] .= S0

    for i in 1:N
        for j in 2:steps+1
            # Geometric Brownian Motion
            paths[i, j] = paths[i, j-1] * exp(
                (μ - 0.5 * σ^2) * dt + 
                σ * sqrt(dt) * randn()
            )
        end
    end

    return paths
end

### ---- Visualization Function ---- ###
function plot_stock_simulations(paths)
    plot(
        transpose(paths), 
        label = false, 
        title = "Stock Price Simulations",
        xlabel = "Time Steps",
        ylabel = "Stock Price"
    )
end

### ---- Example Usage ---- ###
# Parameters
initial_price = 100.0
expected_return = 0.05
volatility = 0.2
time_horizon = 1.0
num_simulations = 100
num_steps = 252  # Trading days in a year

# Run simulation
stock_paths = monte_carlo_stock_simulation(
    initial_price, 
    expected_return, 
    volatility, 
    time_horizon, 
    num_simulations, 
    num_steps
)

# Visualize
plot_stock_simulations(stock_paths)
```

## Migration Strategies

### Python Interoperability
```julia
# Importing Python libraries during transition
using PyCall

# Example of using a Python library
np = pyimport("numpy")
pd = pyimport("pandas")

# Gradual replacement with Julia equivalents
```

## Learning Resources
1. **Books**
   - "Hands-On Design Patterns and Best Practices with Julia"
   - "Julia for Data Science"

2. **Online Courses**
   - Julia Academy (Official)
   - MIT Computational Thinking Course
