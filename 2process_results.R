library(lubridate);
library(dfcrm);
library(rstan);
library(binom);
library(tidyverse);
library(cowplot);
library(RColorBrewer);

if(!require(seamlesssim)) {
  devtools::install_github("elizabethchase/seamlesssim")
  library(seamlesssim); 
}

#script <- RCurl::getURL("https://raw.githubusercontent.com/psboonstra/seamlesssim/master/R/twostage_results.R", ssl.verifypeer = FALSE)
#eval(parse(text = script))

write_to_folder = "out";

source("0gen_params_paper.R");

sim_results <- 
  twostage_results(csv = TRUE,
                   stage2folder = write_to_folder,
                   patientdatfolder = write_to_folder,
                   dose_outcome_curves_list = dose_outcome_curves_list,
                   primary_objectives = primary_objectives,
                   design_labels = design_labels)


# Figure 2 from manuscript
plot_grid(sim_results$plots$acc_dose_rec_plot[[1]], 
          sim_results$plots$gen_params_plot[[1]], 
          ncol = 2, nrow=1, rel_widths = c(5,3)) 

# Figure 3 from manuscript
plot_grid(sim_results$plots$acc_dose_rec_plot[[2]], 
          sim_results$plots$gen_params_plot[[1]], 
          ncol = 2, nrow=1, rel_widths = c(5,3)) 

# Figure 4 from manuscript
plot_grid(sim_results$plots$patient_plot[[1]], 
          sim_results$plots$gen_params_plot[[1]] + 
            scale_color_brewer(palette = "Blues"), 
          ncol = 2, nrow=1, rel_widths = c(5,3), 
          align = 'h', axis = 'tb') 

# Figure 5 from manuscript
plot_grid(sim_results$plots$patient_plot[[2]], 
          sim_results$plots$gen_params_plot[[1]] + 
            scale_color_brewer(palette = "Blues"), 
          ncol = 2, nrow=1, rel_widths = c(5,3), 
          align = 'h', axis = 'tb') 

