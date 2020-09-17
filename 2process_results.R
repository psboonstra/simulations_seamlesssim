library(tidyverse);
library(cowplot);

if(!require(seamlesssim)) {
  devtools::install_github("elizabethchase/seamlesssim")
  library(seamlesssim); 
}

write_to_folder = "out";

source("0gen_params_paper.R");

sim_results <- 
  twostage_results(csv = TRUE,
                   stage2folder = write_to_folder,
                   patientdatfolder = write_to_folder,
                   dose_outcome_curves_list = dose_outcome_curves_list,
                   primary_objectives = primary_objectives,
                   design_labels = design_labels)


fig_height_inches = 9

# Figure 2 from manuscript
plot_grid(sim_results$plots$acc_dose_rec_plot[[1]], 
          sim_results$plots$gen_params_plot_redgreen[[1]], 
          ncol = 2, nrow=1, rel_widths = c(5,3)) 
ggsave("set1_RP2D.png", width = 0.8 * fig_height_inches, height = fig_height_inches, units = "in")

# Figure 3 from manuscript
plot_grid(sim_results$plots$acc_dose_rec_plot[[2]], 
          sim_results$plots$gen_params_plot_redgreen[[1]], 
          ncol = 2, nrow=1, rel_widths = c(5,3)) 
ggsave("set2_RP2D.png", width = 0.8 * fig_height_inches, height = fig_height_inches, units = "in")

# Figure 4 from manuscript
plot_grid(sim_results$plots$dose_over_time_plot[[1]], 
          sim_results$plots$gen_params_plot_blue[[1]], 
          ncol = 2, nrow=1, rel_widths = c(5,3), 
          align = 'h', axis = 'tb') 
ggsave("set1_subjAssignment.png", width = 0.8 * fig_height_inches, height = fig_height_inches, units = "in")

# Figure 5 from manuscript
plot_grid(sim_results$plots$dose_over_time_plot[[2]], 
          sim_results$plots$gen_params_plot_blue[[1]],
          ncol = 2, nrow=1, rel_widths = c(5,3), 
          align = 'h', axis = 'tb') 
ggsave("set2_subjAssignment.png", width = 0.8 * fig_height_inches, height = fig_height_inches, units = "in")
