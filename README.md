
# `simulations_seamlesssim` summary

The repository located at https://github.com/psboonstra/simulations_seamlesssim contains instructions and code for running the simulation study and creating the figures presented in Boonstra, Braun, and Chase (2020). It makes use of the `seamlesssim` R package, which is available in a separate repository (https://github.com/elizabethchase/seamlesssim). **The `seamlesssim` package is standalone, whereas the scripts in the `simulations_seamlesssim` (this repository) are only useful if you want to rerun the simulation study in Boonstra, Braun, and Chase (2020)** You must first install and load the `seamlesssim` R package by running the following commands in your local R session with an active internet connection (it will take a few minutes to compile) :

```r
if(require(devtools)) {
  install.packages("devtools")
}
devtools::install_github("elizabethchase/seamlesssim")
library(seamlesssim);
```
Then, follow the instructions below to recreate the simulation study. 

## Instructions for re-creating the simulation study

### Step 0: `0gen_params_paper.R`

This script creates the generating data models (called scenarios in the manuscript), the designs to run against each scenario, and other details regarding the simulation study. This will be called internally in the next step, so you can leave this alone if you just want to re-create the simulation study exactly as in the manuscript. 

### Step 1: `1run_simulator.R`

This script loads the necessary packages and installs the `seamlesssim` package if not already installed. It then sources `0gen_params_paper.R` and runs the simulator. 

If you are running this on your local machine, which you would indicate by setting the logical flag `running_on_slurm = FALSE` line 17, you will need to run this script "by hand", that is, run the whole script once for each generating data model you want to investigate. However, you can also set `running_on_slurm = TRUE`, which allows you to run this script on multiple cores of a high-performance computing cluster running the SLURM scheduler. To do so, drop the R scripts in this repo into your home directory on the cluster, then from the terminal run the command `sbatch 1run_simulator.txt` to the terminal, which calls a batch script having the same name. If you changed nothing in Step 0, you will be running 91 instances of each of the 10 scenarios, for 910 unique jobs submitted to the scheduler. Each job runs 11 unique simulations (i.e. random seeds), so that in total you are running 91*11=1001 simulations for each of the 10 scenarios. 

After all of the jobs complete, download the `out` folder to your local machine and proceed to the last step. 

### Step 2:  `2process_results.R`

Open R on your machine and run the script `2process_results.R`. This will create the figures that are presented in the manuscript. 