

if(!"do_efficient_simulation"%in%ls()) {
  do_efficient_simulation = T;
}
if(!"n_sim"%in%ls()) {
  n_sim = ifelse(do_efficient_simulation,11,11);
}

if(!"n_mc_warmup"%in%ls()) {n_mc_warmup = 1e3;}
if(!"n_mc_samps"%in%ls()) {n_mc_samps = 2e3;}
if(!"stan_path"%in%ls()) {stan_path = "";}


primary_objectives = c(tox_target = 0.25,
                       tox_delta_no_exceed = 0.05,
                       eff_target = 0.20);

tox_eff_curves = list(
  list(tox_curve = c(0.08,0.11,0.17,0.25,0.35),
       eff_curve = c(0.10,0.18,0.25,0.35,0.38), 
       scenario = 1),
  list(tox_curve = c(0.08,0.11,0.17,0.25,0.35),
       eff_curve = c(0.10,0.10,0.10,0.35,0.35),
       scenario = 2),
  list(tox_curve = c(0.03,0.08,0.18,0.30,0.39),
       eff_curve = c(0.10,0.18,0.25,0.35,0.38), 
       scenario = 3),
  list(tox_curve = c(0.03,0.08,0.18,0.30,0.39),
       eff_curve = c(0.10,0.10,0.10,0.35,0.35),
       scenario = 4),
  list(tox_curve = c(0.10,0.15,0.25,0.36,0.47),
       eff_curve = c(0.10,0.18,0.25,0.35,0.38), 
       scenario = 5),
  list(tox_curve = c(0.10,0.15,0.25,0.36,0.47),
       eff_curve = c(0.10,0.10,0.35,0.35,0.35), 
       scenario = 6),
  list(tox_curve = c(0.11,0.22,0.33,0.45,0.56),
       eff_curve = c(0.10,0.18,0.25,0.35,0.38), 
       scenario = 7),
  list(tox_curve = c(0.11,0.22,0.33,0.45,0.56),
       eff_curve = c(0.10,0.35,0.35,0.35,0.35), 
       scenario = 8),
  list(tox_curve = c(0.20,0.25,0.36,0.50,0.75),
       eff_curve = c(0.10,0.18,0.25,0.35,0.38), 
       scenario = 9),
  list(tox_curve = c(0.20,0.25,0.36,0.50,0.75),
       eff_curve = c(0.35,0.35,0.35,0.35,0.35), 
       scenario = 10)
);

sim_label_restart = length(tox_eff_curves);

design_list = list(
  list(##Confirmed
    module1 = list(
      name = "3pl3", 
      starting_dose = 1
    ),
    module2 = list(
      name = "bayes",
      prob_threshold = 0.3,
      prior_mean = rep(0.1, 5),
      prior_n_per = 1,
      include_stage1_data = T
    ),
    module4 = list(
      name = "empiric", 
      n = 35,
      rule = "local",
      first_patient_look = 10,
      thresh_decrease = 0.33
    ),
    module5 = list(
      name = "bayes",
      prob_threshold = 0.38,
      prior_mean = rep(0.1, 5),
      prior_n_per = 1,
      include_stage1_data = T
    )
  ),
  #
  list(##Confirmed
    module1 = list(
      name = "3pl3", 
      starting_dose = 1
    ),
    module4 = list(
      name = "empiric", 
      n = 35,
      rule = "local",
      first_patient_look = 10,
      thresh_decrease = 0.33
    ),
    module5 = list(
      name = "bayes",
      prob_threshold = 0.43,
      prior_mean = rep(0.1, 5),
      prior_n_per = 1,
      include_stage1_data = T
    )
  ),
  #
  list(#
    module1 = list(
      name = "3pl3", 
      starting_dose = 1
    ),
    module4 = list(
      name = "empiric", 
      n = 35,
      rule = "local",
      first_patient_look = 10,
      thresh_decrease = 0.33
    ),
    module5 = list(
      name = "bayes_isoreg",
      prob_threshold = 0.55,
      alpha_scale = 1e-7,
      include_stage1_data = T
    )
  ),
  #
  list(##Confirmed
    module1 = list(
      name = "crm", 
      n = 25,
      starting_dose = 1,
      skeleton = c(0.08,0.11,0.17,0.25,0.35),
      beta_scale = 0.6,
      dose_cohort_size = 3,
      dose_cohort_size_first_only = T,
      earliest_stop = 6
    ),
    module2 = list(
      name = "bayes",
      prob_threshold = 0.35,
      prior_mean = rep(0.1, 5),
      prior_n_per = 1,
      include_stage1_data = T
    ),
    module4 = list(
      name = "continue_crm", 
      n = 35
    ),
    module5 = list(
      name = "bayes",
      prob_threshold = 0.75,
      prior_mean = rep(0.1, 5),
      prior_n_per = 1,
      include_stage1_data = T
    )
  ),
  #
  list(##Confirmed
    module1 = list(
      name = "crm", 
      n = 25,
      starting_dose = 1,
      skeleton = c(0.08,0.11,0.17,0.25,0.35),
      beta_scale = 0.6,
      dose_cohort_size = 3,
      dose_cohort_size_first_only = T,
      earliest_stop = 6
    ),
    module4 = list(
      name = "continue_crm", 
      n = 35
    ),
    module5 = list(
      name = "bayes",
      prob_threshold = 0.83,
      prior_mean = rep(0.1, 5),
      prior_n_per = 1,
      include_stage1_data = T
    )
  ),
  list(##
    module1 = list(
      name = "crm", 
      n = 25,
      starting_dose = 1,
      skeleton = c(0.08,0.11,0.17,0.25,0.35),
      beta_scale = 0.6,
      dose_cohort_size = 3,
      dose_cohort_size_first_only = T,
      earliest_stop = 6
    ),
    module4 = list(
      name = "continue_crm", 
      n = 35
    ),
    module5 = list(
      name = "bayes_isoreg",
      prob_threshold = 0.87,
      alpha_scale = 1e-7,
      include_stage1_data = T
    )
  )
)
design_labels = 1:length(design_list);

if(!"arglist"%in%ls()) {
  arglist = list();
}

random_seeds = sample(.Machine$integer.max - 1e4,length(tox_eff_curves));

for(k in 1:length(tox_eff_curves)) {
  assign(paste("sim",k,".params",sep=""),list(array_id = NA,
                                              n_sim = n_sim,
                                              primary_objectives = primary_objectives,
                                              dose_outcome_curves = tox_eff_curves[[k]],
                                              design_list = design_list,
                                              stan_args = list(
                                                stan_path = stan_path,
                                                n_mc_warmup = n_mc_warmup, 
                                                n_mc_samps = n_mc_samps, 
                                                mc_chains = 2, 
                                                mc_thin = 1, 
                                                mc_stepsize = 0.1, 
                                                mc_adapt_delta = 0.99,
                                                mc_max_treedepth = 18,
                                                ntries = 1
                                              ),
                                              sim_labels = ifelse(exists("array_id"), (1:n_sim) + n_sim * floor((array_id - 1) / sim_label_restart), 1:n_sim),
                                              design_labels = design_labels,
                                              do_efficient_simulation = do_efficient_simulation,
                                              random_seed = random_seeds[k]))
  arglist = c(arglist,list(get(paste("sim",k,".params",sep=""))));
}

