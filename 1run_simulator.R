library(lubridate);
library(dfcrm);
library(rstan);
library(binom);
library(tidyverse);

# Load the two-stage simulator functions
if(!require(seamlesssim)) {
  devtools::install_github("elizabethchase/seamlesssim")
  library(seamlesssim); 
}

# Enable multicore use
options(mc.cores = parallel::detectCores());

# You can run on slurm or on your own machine!
running_on_slurm = TRUE;
# Leave this at zero: this is for offsetting the labels when you are 
# running more than one batch on a cluster
array_id_offset = 0;
write_to_folder = "out/";

if(running_on_slurm) {
  rstan_options(auto_write = FALSE);
  array_id <- array_id_offset + as.numeric(Sys.getenv('SLURM_ARRAY_TASK_ID'));  
} else {
  rstan_options(auto_write = TRUE);
  array_id = 9;
  n_sim = 2;
}

# Load the simulation settings ----
protect_objects = ls()
source("gen_params_paper.R");
rm(list = setdiff(ls(all = T), c("arglist",protect_objects)));

# Run simulations ----
curr_args = arglist[[1 + ((array_id-1) %% length(arglist))]];
curr_args$array_id = array_id;
curr_args$random_seed = curr_args$random_seed + array_id

begin = Sys.time();
foo = do.call(twostage_simulator, args = curr_args);
Sys.time() - begin;


# Save the results ----
file_name = paste0(write_to_folder,"PatientData",array_id,".csv");
write.csv(foo$patient_data, file = file_name, quote = F, row.names = F);
file_name = paste0(write_to_folder,"Stage1Data",array_id,".csv");
write.csv(foo$sim_data_stage1, file = file_name, quote = F, row.names = F);
file_name = paste0(write_to_folder,"Stage2Data",array_id,".csv");
write.csv(foo$sim_data_stage2, file = file_name, quote = F, row.names = F);
