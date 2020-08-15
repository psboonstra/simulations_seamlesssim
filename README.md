# Executive summary 

This code demonstrates the use of the seamless trial simulator proposed in Boonstra, Braun, and Chase (2020) by recreating the numerical results in that same paper. 


## Instructions

Step 0. `0run_simulator.R`

This script loads the necessary packages and installs the `seamlesssim` package
if not already installed. It then sources a helper script called `gen_params_paper.R` to load the generating data models (called scenarios in
the manuscript) and runs the simulator. 

If you are running this on your local machine, which you would indicate by 
setting the logical flag `running_on_slurm = FALSE`, you will need to run this script "by hand", once for each generating data model. However, you can also set
`running_on_slurm = TRUE`, which allows you to run this script on multiple cores
of a cluster using the SLURM scheduler. To do so, log in to your cluster, proceed
to the relevant directly, and send the command `sbatch 0run_simulator.txt` to the terminal, which calls a batch script with the same name. If you change nothing, 
you will run 91 instances of each of the 10 scenarios, for 910 unique jobs. 
Each job runs 11 for 11 simulations, so that in total you are running 91*11=1001
simulations for each of the 10 scenarios. 

After all of the jobs complete, download the out folder to your local machine
and proceed to the next step. 

1. Open R on your machine and run the script `1process_results.R`. This will
create the figures that are presented in the manuscript. 