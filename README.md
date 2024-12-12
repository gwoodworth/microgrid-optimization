# microgrid-optimization
Repository for my final project in a graduate math class, Optimization, at UAF in Fall 2024.
## Introduction 
This repository contains code for optimizing load setpoints for generators on a microgrid containing diesel generators and a solar PV array. This optimiztion problem is formulated as a linear programming problem. Simplex method is used. 

## Contents
There are seven helper functions, a script that runs the optimization, and two data sets. The data is from an example grid posted at https://github.com/gears1763-2/PGMcpp.
### /data
- electrical_load_generic_peak-500kW_1yr_dt-1hr: one year of hourly electrical demand in kW
- normalized_solar_production: one year of hourly normalize solar production

Note: If $s$ is solar output in kW, $q$, $0\le q\le 1$ is normalized solar production and $r$ is the rated capacity of the solar PV array in kW, then $$s = q\cdot r.$$
### /functions
- finda: finds constraint matrix $A$ for the problem in Standard Form SF
- findb: finds b vector (right hand side of constraints) in SF
- findc: finds c vector where objective function $z= c^Tx$ in SF. 
    - also computes $p$, the y-intercept of the inital objective function that is not in standard form.
- genSlopeYint: produces slope and y-intercept of for each generator
- phaseone: computes an initial basic feasible solution BFS 
    - from https://github.com/bueler/opt/tree/main/assets/codes/F24
- sfsimplex: solves SF linear program using Simplex method 
    - from https://github.com/bueler/opt/tree/main/assets/codes/F24
- preprocess: preprocesses demand and solar PV array output
    - see Constraints below. 
- genCurves: creates vector valued function representing generator fuel curves
    - unused function, might be useful for other optimization techniques in future
### /scripts
- optimize: main script that finds an optimum solution  
    - should be turned into a function soon... 
    - requires user to set parameters by hand to load data correctly
    - see below for problem statement
## Problem 
### Objective Function 
Let $K$ be the number of diesel generators and $L$ be the number of time steps we are optimizing over. The fuel consumption of each generator, $L/kWh$, is determined by a generic, linear fuel curve, $g_k(x_i)$ where $i=l+L(k-1)$ and $x_i$ is the setpoint of generator $k$ at timestep $l$. The objective function is the sum of fuel use by all generators $K$ over all time steps $L$. Then the objective is $$\text{minimize }\;f(x)=\sum_{l=1}^L\sum_{k=1}^Kg_k(x_{l+L(k-1)})=\sum_{l=1}^L\sum_{k=1}^Kg_k(x_i).$$ Note: The slopes and $y$-intercepts of the fuel curves are nonlinear functions of the rated maximum capacity of a generator. Specifically, given generator $k$ with maximum rated capacity $M_k$ in kW, $$g_k(x)=0.4234(M_k)^{-0.1012}x+0.0940\cdot (M_k)^{-0.2735}.$$  

### Constraints
Let $D$ and $S$ be the electrical demand profile and the solar PV array output, respectively, each in kW and of length $L$. In this problem, the demand on the microgrid must be met exactly. In order to simplify the issue of curtailing the output of the solar PV array, we preprocess $D-S$ using $D'=$ max $(D-S,0)$.  Thus, we represent meeting the remainder of the demand using $L$ constraints $$\sum_{k=1}^Kg_k(x_i)=D_i'$$
where $\;\;i=l+L(k-1)$ for $\;l\in\{1,\dots,L\}.$ 

Each generator $k$ has a maximum output of $M_k$, which we represent with the following $n=K\cdot L$ constraints $$x_i\le M_k$$ where $\;\;i=l+L(k-1)$ for $\;l\in\{1,\dots,L\}.$ Also, for all $i=1,\dots,n$, we have $$0\le x_i.$$

Hence, we have $m=L+n$ general constraints and $n$ variables. In solving the problem, we convert to standard form, which will add $n$ variables. See project write up for details (coming soon...).

