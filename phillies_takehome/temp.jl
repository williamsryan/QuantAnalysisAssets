# Load libraries
using CSV, DataFrames
using StatsPlots
using Turing
using Random, Distributions
using StatsBase
# using CategoricalArrays
using LinearAlgebra
using MCMCChains
using MLJ
using DecisionTree
using MLJDecisionTreeInterface
Random.seed!(42)

df = CSV.read("k.csv", DataFrame)
first(df, 5) |> println
describe(df) |> println

# Rename columns for clarity
rename!(df, Symbol("K%") => :K)

# Sort the DataFrame to ensure proper ordering within each player group
sort!(df, [:MLBAMID, :Season])

# Initialize new columns with missing values
df[!, :K_prev] = Vector{Union{Missing, Float64}}(missing, nrow(df))
df[!, :TBF_prev] = Vector{Union{Missing, Int64}}(missing, nrow(df))

# Fill previous season's K% and TBF for each pitcher
for g in groupby(df, :MLBAMID)
    global_indices = findall(x -> x in g.MLBAMID, df.MLBAMID)
    for i in 2:nrow(g)
        curr_idx = global_indices[i]
        prev_idx = global_indices[i - 1]

        df[!, :K_prev][curr_idx] = df[!, :K][prev_idx]
        df[!, :TBF_prev][curr_idx] = df[!, :TBF][prev_idx]
    end
end

# Drop rows that don’t have lagged values (e.g. rookies or first-year records)
df_model = dropmissing(df, [:K_prev, :TBF_prev])

# Add derived features
df_model[!, :ΔK] = df_model.K .- df_model.K_prev         # Change in K% from last season
df_model[!, :is_relief] = df_model.TBF .< 200            # Likely a reliever if under 200 TBF

# Define model inputs
unique_players = unique(df_model.MLBAMID)
player_lookup = Dict(pid => i for (i, pid) in enumerate(unique_players))
player_index = [player_lookup[pid] for pid in df_model.MLBAMID]

# Select feature matrix and target vector
X = DataFrames.select(df_model, [:K_prev, :TBF_prev, :Age, :ΔK, :is_relief])
y = df_model.K
y_vec = y

# Train Ridge model
RidgeRegressor = @load RidgeRegressor pkg=MLJLinearModels

ridge_model = RidgeRegressor(lambda=0.1)
ridge_mach = machine(ridge_model, X_train, y_train)
fit!(ridge_mach)
y_pred_ridge = predict(ridge_mach, X_test) |> MLJ.unwrap

# Fit Random Forest Regressor with MLJ
RandomForest = @load RandomForestRegressor pkg=DecisionTree

model_instance = RandomForest(n_trees=100)
mach = machine(model_instance, X, y)
MLJBase.fit!(mach)

# Make predictions
y_pred = MLJ.predict(mach, X) |> MLJ.unwrap

r2 = rsq(y_pred, y_vec)
rmse = sqrt(mean((y_pred .- y_vec).^2))

println("R² Score: ", round(r2, digits=4))
println("RMSE: ", round(rmse, digits=4))

# -----------------------------------------------
# Predict K% for 2024 season (out-of-sample test)
# -----------------------------------------------

# Split into training (before 2024) and test (2024 season)
df_train = filter(row -> row.Season < 2024, df_model)
df_test = filter(row -> row.Season == 2024, df_model)

# Feature matrix and target vector for train/test
X_train = select(df_train, [:K_prev, :TBF_prev, :Age, :ΔK, :is_relief])
y_train = df_train.K

X_test = select(df_test, [:K_prev, :TBF_prev, :Age, :ΔK, :is_relief])
y_test = df_test.K

# Sanity check: Ensure no overlap in player-season rows (by MLBAMID and Season)
@assert isempty(intersect(
    zip(df_train.MLBAMID, df_train.Season),
    zip(df_test.MLBAMID, df_test.Season)
)) "Train/test data leakage detected!"

# Fit model on training data
model_2024 = model(n_trees=100)
mach_2024 = machine(model_2024, X_train, y_train)
MLJ.fit!(mach_2024)

# Predict and evaluate on 2024 holdout set
y_pred_2024 = MLJ.predict(mach_2024, X_test) |> MLJ.unwrap

r2_2024 = 1 - sum((y_test .- y_pred_2024) .^ 2) / sum((y_test .- mean(y_test)) .^ 2)
rmse_2024 = sqrt(mean((y_test .- y_pred_2024) .^ 2))

println("\n2024 Holdout Performance:")
println("R² Score (2024): ", round(r2_2024, digits=4))
println("RMSE (2024): ", round(rmse_2024, digits=4))

# Store predictions back in df_model for inspection/export
df_model[!, :K_pred_2024] .= missing
df_model[df_model.Season.==2024, :K_pred_2024] = y_pred_2024
