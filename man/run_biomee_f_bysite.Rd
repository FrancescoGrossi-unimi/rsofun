% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/run_biomee_f_bysite.R
\name{run_biomee_f_bysite}
\alias{run_biomee_f_bysite}
\title{R wrapper for SOFUN biomee}
\usage{
run_biomee_f_bysite(
  sitename,
  params_siml,
  site_info,
  forcing,
  params_tile,
  params_species,
  params_soil,
  init_cohort,
  init_soil,
  makecheck = TRUE
)
}
\arguments{
\item{sitename}{Site name.}

\item{params_siml}{Simulation parameters.
\describe{
  \item{spinup}{A logical value indicating whether this simulation does spin-up.}
  \item{spinupyears}{Number of spin-up years.}
  \item{recycle}{Length of standard recycling period (days).}
  \item{firstyeartrend}{First transient year.}
  \item{nyeartrend}{Number of transient years.}
  \item{outputhourly}{A logical value indicating whether hourly output is
    produced.}
  \item{outputdaily}{A logical value indicating whether daily output is produced.}
  \item{do_U_shaped_mortality}{A logical value indicating whether U-shaped 
    mortality is used.}
  \item{update_annualLAImax}{A logical value indicating whether updating 
    LAImax according to mineral N in soil.}
  \item{do_closedN_run}{A logical value indicating whether doing N closed 
    runs to recover N balance.}
  \item{do_reset_veg}{A logical value indicating whether reseting vegetation 
    for disturbance runs.}
  \item{dist_frequency}{Value indicating the frequency of the disturbance event (in years) 
    (e.g. 100 indicates a disturbance event occurs every 100 years, i.e., at a rate of 0.01)}
  \item{code_method_photosynth}{String specifying the method of photosynthesis 
    used in the model, either "pmodel" or "gs_leuning".}
  \item{code_method_mortality}{String indicating the type of mortality in the 
    model. One of the following: "dbh" is size-dependent mortality, "const_selfthin" 
    is constant self thinning (in development), "cstarvation" is carbon starvation, and
    "growthrate" is growth rate dependent mortality.}
}}

\item{site_info}{Site meta info in a data.frame.
\describe{
  \item{sitename}{Name of the site.}
  \item{lon}{Longitud of the site location.}
  \item{lat}{Latitude of the site location.}
  \item{elv}{Elevation of the site location, in meters.}
}}

\item{forcing}{Forcing data.frame used as input.}

\item{params_tile}{Tile-level model parameters, into a single row data.frame
  with columns:
\describe{
  \item{soiltype}{Integer indicating the type of soil: Sand = 1, LoamySand = 2,
    SandyLoam = 3, SiltLoam = 4, FrittedClay = 5, Loam = 6, Clay = 7.}
  \item{FLDCAP}{Field capacity (vol/vol). Water remaining in a soil after it 
    has been thoroughly saturated and allowed to drain freely.}
  \item{WILTPT}{Wilting point (vol/vol). Water content of a soil at which 
  plants wilt and fail to recover.}
  \item{K1}{Fast soil C decomposition rate (year\eqn{^{-1}}).}
  \item{K2}{Slow soil C decomposition rate (year\eqn{^{-1}}).}
  \item{K_nitrogen}{Mineral Nitrogen turnover rate (year\eqn{^{-1}}).}
  \item{MLmixRatio}{Ratio of C and N returned to litters from microbes.}
  \item{etaN}{N loss rate through runoff (organic and mineral) (year\eqn{^{-1}}).}
  \item{LMAmin}{Minimum LMA, leaf mass per unit area, kg C m\eqn{^{-2}}.}
  \item{fsc_fine}{Fraction of fast turnover carbon in fine biomass.}
  \item{fsc_wood}{Fraction of fast turnover carbon in wood biomass.}
  \item{GR_factor}{Growth respiration factor.}
  \item{l_fract}{Fraction of the carbon retained after leaf drop.}
  \item{retransN}{Retranslocation coefficient of nitrogen.}
  \item{f_initialBSW}{Coefficient for setting up initial sapwood.}
  \item{f_N_add}{Re-fill of N for sapwood.}
  \item{tf_base}{Calibratable scalar for respiration, used to increase LUE
    levels.}
  \item{par_mort}{Canopy mortality parameter.}
  \item{par_mort_under}{Parameter for understory mortality.}
}}

\item{params_species}{A data.frame containing species-specific model parameters,
  with one species per row. The columns of this data.frame are:
\describe{
  \item{lifeform}{Integer set to 0 for grasses and 1 for trees.}
  \item{phenotype}{Integer set to 0 for deciduous and 1 for evergreen.}
  \item{pt}{Integer indicating the type of plant according to photosynthesis: 
    0 for C3; 1 for C4}
  \item{alpha_FR}{Fine root turnonver rate (year\eqn{^{-1}}).}
  \item{rho_FR}{Material density of fine roots (kg C m\eqn{^{-3}}).}
  \item{root_r}{Radious of the fine roots, in m.}
  \item{root_zeta}{e-folding parameter of root vertical distribution, in m.}
  \item{Kw_root}{Fine root water conductivity (mol m\eqn{^{-2}}
    s\eqn{^{-1}} MPa\eqn{^{-1}}).}
  \item{leaf_size}{Characteristic leaf size.}
  \item{Vmax}{Max RuBisCo rate, in mol m\eqn{^{-2}} s\eqn{^{-1}}.}
  \item{Vannual}{Annual productivity per unit area at full sun (kg C 
    m\eqn{^{-2}} year\eqn{^{-2}}).}
  \item{wet_leaf_dreg}{Wet leaf photosynthesis down-regulation.}
  \item{m_cond}{Factor of stomatal conductance.}
  \item{alpha_phot}{Photosynthesis efficiency.}
  \item{gamma_L}{Leaf respiration coefficient, in year\eqn{^{-1}}.}
  \item{gamma_LN}{Leaf respiration coefficient per unit N.}
  \item{gamma_SW}{Sapwood respiration rate, in kg C m\eqn{^{-2}} year\eqn{^{-1}}.}
  \item{gamma_FR}{Fine root respiration rate, kg C kg C\eqn{^{-1}} 
    year\eqn{^{-1}}.}
  \item{tc_crit}{Critical temperature triggerng offset of phenology, in Kelvin.}
  \item{tc_crit_on}{Critical temperature triggerng onset of phenology, in Kelvin.}
  \item{gdd_crit}{Critical value of GDD5 for turning ON growth season.}
  \item{betaON}{Critical soil moisture for phenology onset.}
  \item{betaOFF}{Critical soil moisture for phenology offset.}
  \item{seedlingsize}{Initial size of seedlings, in kg C per individual.}
  \item{LNbase}{Basal leaf N per unit area, in kg N m\eqn{^{-2}}.}
  \item{lAImax}{Maximum crown LAI (leaf area index).}
  \item{Nfixrate0}{Reference N fixation rate (kg N kg C\eqn{^{-1}} root).}
  \item{NfixCost0}{Carbon cost of N fixation (kg C kg N\eqn{^{-1}}).}
  \item{phiCSA}{Ratio of sapwood area to leaf area.}
  \item{mortrate_d_c}{Canopy tree mortality rate (year\eqn{^{-1}}).}
  \item{mortrate_d_u}{Understory tree mortality rate (year\eqn{^{-1}}).}
  \item{maturalage}{Age at which trees can reproduce (years).}
  \item{v_seed}{Fraction of G_SF to G_F.}
  \item{fNSmax}{Multiplier for NSNmax as sum of potential bl and br.}
  \item{LMA}{Leaf mass per unit area (kg C m\eqn{^{-2}}).}
  \item{rho_wood}{Wood density (kg C m\eqn{^{-3}}).}
  \item{alphaBM}{Coefficient for allometry (biomass = alphaBM * DBH ** thetaBM).}
  \item{thetaBM}{Coefficient for allometry (biomass = alphaBM * DBH ** thetaBM).}
  \item{kphio}{Quantum yield efficiency \eqn{\varphi_0}, 
   in mol mol\eqn{^{-1}}.}
  \item{phiRL}{Ratio of fine root to leaf area.}
  \item{LAI_light}{Maximum LAI limited by light.}
}}

\item{params_soil}{A tibble of soil parameters (one row per soil layer).
\describe{
  \item{type}{A string indicating the type of soil.}
  \item{GMD}{Geometric mean particle diameter (mm).}
  \item{GSD}{Geometric standard deviation of particle size.}
  \item{vwc_sat}{Saturated volumetric soil water content (vol/vol).}
  \item{chb}{Soil texture parameter.}
  \item{psi_sat_ref}{Saturation soil water potential (m).}
  \item{k_sat_ref}{Hydraulic conductivity of saturated soil (kg m\eqn{^{-2}} 
    s\eqn{^{-1}}).}
  \item{alphaSoil}{Vertical changes of soil property, where 1 = no change.}
  \item{heat_capacity_dry}{Heat capacity dry air (J m\eqn{^{-3}} K\eqn{^{-1}}).}
}}

\item{init_cohort}{A data.frame of initial cohort specifications.
\describe{
  \item{init_cohort_species}{Indicates different species.}
  \item{init_cohort_nindivs}{Initial individual density, in individuals per 
    m\eqn{^{2}}.}
  \item{init_cohort_bsw}{Initial biomass of sapwood, in kg C per individual.}
  \item{init_cohort_bHW}{Initial biomass of heartwood, in kg C per tree.}
  \item{init_cohort_nsc}{Initial non-structural biomass.}
}}

\item{init_soil}{A data.frame of initial soil pools.
\describe{
  \item{init_fast_soil_C}{Initial fast soil carbon, in kg C m\eqn{^{-2}}.}
  \item{init_slow_soil_C}{Initial slow soil carbon, in kg C m\eqn{^{-2}}.}
  \item{init_Nmineral}{Mineral nitrogen pool, in kg N m\eqn{^{-2}}.}
  \item{N_input}{Annual nitrogen input to soil N pool, in kg N m\eqn{^{-2}} 
    year\eqn{^{-1}}.}
}}

\item{makecheck}{A logical specifying whether checks are performed to verify 
forcings.}
}
\value{
Model output is provided as a list, with elements:
\describe{
  \item{\code{output_hourly_tile}}{A data.frame containing hourly predictions
    .
    \describe{
      \item{year}{Year of the simulation.}
      \item{doy}{Day of the year.}
      \item{hour}{Hour of the day.}
      \item{rad}{Radiation, in W m\eqn{^{-2}}.}
      \item{Tair}{Air temperature, in Kelvin.}
      \item{Prcp}{Precipitation, in mm m\eqn{^{-2}}.}
      \item{GPP}{Gross primary production (kg C m\eqn{^{-2}} hour\eqn{^{-1}}).}
      \item{Resp}{Plant respiration (kg C m\eqn{^{-2}} hour\eqn{^{-1}}).}
      \item{Transp}{Transpiration (mm m\eqn{^{-2}}).}
      \item{Evap}{Evaporation (mm m\eqn{^{-2}}).}
      \item{Runoff}{Water runoff (mm m\eqn{^{-2}}).}
      \item{Soilwater}{Soil water content in root zone (kg m\eqn{^{-2}}).}
      \item{wcl}{Volumetric soil water content for each layer (vol/vol).}
      \item{FLDCAP}{Field capacity (vol/vol).}
      \item{WILTPT}{Wilting point (vol/vol).}
    }}
  \item{\code{output_daily_tile}}{A data.frame with daily outputs at a tile
    level.
    \describe{
      \item{year}{Year of the simulation.}
      \item{doy}{Day of the year.}
      \item{Tc}{Air temperature (Kelvin).}
      \item{Prcp}{Precipitation (mm m\eqn{^{-2}}).}
      \item{totWs}{Soil water content in root zone (kg m\eqn{^{-2}}).}
      \item{Trsp}{Transpiration (mm m\eqn{^{2-}}).}
      \item{Evap}{Evaporation (mm m\eqn{^{-2}}).}
      \item{Runoff}{Water runoff (mm m\eqn{^{-2}}).}
      \item{ws1}{Volumetric soil water content for layer 1.}
      \item{ws2}{Volumetric soil water content for layer 2.}
      \item{ws3}{Volumetric soil water content for layer 3.}
      \item{LAI}{Leaf area index (m\eqn{^2}/m\eqn{^2}).}
      \item{GPP}{Gross primary production (kg C m\eqn{^{-2}} day\eqn{^{-1}}).}
      \item{Rauto}{Plant autotrophic respiration (kg C m\eqn{^{-2}} day\eqn{^{-1}}).}
      \item{Rh}{Heterotrophic respiration (kg C m\eqn{^{-2}} day\eqn{^{-1}}).}
      \item{NSC}{Non-structural carbon (kg C m\eqn{^{-2}}).}
      \item{seedC}{Biomass of seeds (kg C m\eqn{^{-2}}).}
      \item{leafC}{Biomass of leaves (kg C m\eqn{^{-2}}).}
      \item{rootC}{Biomass of fine roots (kg C m\eqn{^{-2}}).}
      \item{SW_C}{Biomass of sapwood (kg C m\eqn{^{-2}}).}
      \item{HW_C}{biomass of heartwood (kg C m\eqn{^{-2}}).}
      \item{NSN}{Non-structural N pool (kg N m\eqn{^{-2}}).}
      \item{seedN}{Nitrogen of seeds (kg N m\eqn{^{-2}}).}
      \item{leafN}{Nitrogen of leaves (kg N m\eqn{^{-2}}).}
      \item{rootN}{Nitrogen of roots (kg N m\eqn{^{-2}}).}
      \item{SW_N}{Nitrogen of sapwood (kg N m\eqn{^{-2}}).}
      \item{HW_N}{Nitrogen of heartwood (kg N m\eqn{^{-2}}).}
      \item{McrbC}{Microbial carbon (kg C m\eqn{^{-2}}).}
      \item{fastSOM}{Fast soil carbon pool (kg C m\eqn{^{-2}}).}
      \item{slowSOM}{Slow soil carbon pool (kg C m\eqn{^{-2}}).}
      \item{McrbN}{Microbial nitrogen (kg N m\eqn{^{-2}}).}
      \item{fastSoilN}{Fast soil nitrogen pool (kg N m\eqn{^{-2}}).}
      \item{slowSoilN}{Slow soil nitrogen pool (kg N m\eqn{^{-2}}).}
      \item{mineralN}{Mineral nitrogen pool (kg N m\eqn{^{-2}}).}
      \item{N_uptk}{Nitrogen uptake (kg N m\eqn{^{-2}}).}
    }}
  \item{\code{output_daily_cohorts}}{A data.frame with daily predictions
    for each canopy cohort.
    \describe{
      \item{year}{Year of the simulation.}
      \item{doy}{Day of the year.}
      \item{hour}{Hour of the day.}
      \item{cID}{An integer indicating the cohort identity.}
      \item{PFT}{An integer indicating the Plant Functional Type.}
      \item{layer}{An integer indicating the crown layer, numbered from top
        to bottom.}
      \item{density}{Number of trees per area (trees ha\eqn{^{-1}}).}
      \item{f_layer}{Fraction of layer area occupied by this cohort.}
      \item{LAI}{Leaf area index (m\eqn{^2}/m\eqn{^2}).}
      \item{gpp}{Gross primary productivity (kg C tree\eqn{^{-1}} day\eqn{^{-1}}).}
      \item{resp}{Plant autotrophic respiration (kg C tree\eqn{^{-1}} day\eqn{^{-1}}).}
      \item{transp}{Transpiration (mm tree\eqn{^{-1}} day\eqn{^{-1}}).}
      \item{NPPleaf}{Carbon allocated to leaves (kg C tree\eqn{^{-1}} day\eqn{^{-1}}).}
      \item{NPProot}{Carbon allocated to fine roots (kg C tree\eqn{^{-1}} day\eqn{^{-1}}).}
      \item{NPPwood}{Carbon allocated to wood (kg C tree\eqn{^{-1}} day\eqn{^{-1}}).}
      \item{NSC}{Nonstructural carbohydrates of a tree in this cohort (kg C 
        tree\eqn{^{-1}}).}
      \item{seedC}{Seed biomass of a tree in this cohort (kg C tree\eqn{^{-1}}).}
      \item{leafC}{Leaf biomass of a tree in this cohort (kg C tree\eqn{^{-1}}).}
      \item{rootC}{Fine root biomass of a tree in this cohort (kg C tree\eqn{^{-1}}).}
      \item{SW_C}{Sapwood biomass of a tree in this cohort (kg C tree\eqn{^{-1}}).}
      \item{HW_C}{Heartwood biomass of a tree in this cohort (kg C tree\eqn{^{-1}}).}
      \item{NSN}{Nonstructural nitrogen of a tree in this cohort (kg N tree\eqn{^{-1}}).}
      \item{seedN}{Seed nitrogen of a tree in this cohort (kg N tree\eqn{^{-1}}).}
      \item{leafN}{Leaf nitrogen of a tree in this cohort (kg N tree\eqn{^{-1}}).}
      \item{rootN}{Fine root nitrogen of a tree in this cohort (kg N tree\eqn{^{-1}}).}
      \item{SW_N}{Sapwood nitrogen of a tree in this cohort (kg N tree\eqn{^{-1}}).}
      \item{HW_N}{Heartwood nitrogen of a tree in this cohort (kg N tree\eqn{^{-1}}).}
    }}
  \item{\code{output_annual_tile}}{A data.frame with annual outputs at tile level.
  \describe{
    \item{year}{Year of the simulation.}
    \item{CAI}{Crown area index (m\eqn{^2}/m\eqn{^2}).}
    \item{LAI}{Leaf area index (m\eqn{^2}/m\eqn{^2}).}
    \item{Density}{Number of trees per area (trees ha\eqn{^{-1}}).}
    \item{DBH}{Diameter at tile level (cm).}
    \item{Density12}{Tree density for trees with DBH > 12 cm (individuals 
      ha\eqn{^{-1}}).}
    \item{DBH12}{Diameter at tile level considering trees with DBH > 12 cm
      (cm).}
    \item{QMD}{Quadratic mean diameter at tile level considering trees with 
      DBH > 12 cm (cm).}
    \item{NPP}{Net primary productivity (kg C m\eqn{^{-2}} yr\eqn{^{-1}}).}
    \item{GPP}{Gross primary productivity (kg C m\eqn{^{-2}} yr\eqn{^{-1}}).}
    \item{Rauto}{Plant autotrophic respiration (kg C m\eqn{^{-2}} yr\eqn{^{-1}}).}
    \item{Rh}{Heterotrophic respiration (kg C m\eqn{^{-2}} yr\eqn{^{-1}}).}
    \item{rain}{Annual precipitation (mm m\eqn{^{-2}} yr\eqn{^{-1}}).}
    \item{SoilWater}{Soil water content in root zone (kg m\eqn{^{-2}}).}
    \item{Transp}{Transpiration (mm m\eqn{^{-2}} yr\eqn{^{-1}}).}
    \item{Evap}{Evaporation (mm m\eqn{^{-2}} yr\eqn{^{-1}}).}
    \item{Runoff}{Water runoff (mm m\eqn{^{-2}} yr\eqn{^{-1}}).}
    \item{plantC}{Plant biomass (kg C m\eqn{^{-2}}).}
    \item{soilC}{Soil carbon (kg C m\eqn{^{-2}}).}
    \item{plantN}{Plant nitrogen (kg N m\eqn{^{-2}}).}
    \item{soilN}{Soil nitrogen (kg N m\eqn{^{-2}}).}
    \item{totN}{Total nitrogen in plant and soil (kg N m\eqn{^{-2}}).}
    \item{NSC}{Nonstructural carbohydrates (kg C m\eqn{^{-2}}).}
    \item{SeedC}{Seed biomass (kg C m\eqn{^{-2}}).}
    \item{leafC}{Leaf biomass (kg C m\eqn{^{-2}}).}
    \item{rootC}{Fine root biomass (kg C m\eqn{^{-2}}).}
    \item{SapwoodC}{Sapwood biomass (kg C m\eqn{^{-2}}).}
    \item{WoodC}{Heartwood biomass (kg C m\eqn{^{-2}}).}
    \item{NSN}{Nonstructural nitrogen (kg N m\eqn{^{-2}}).}
    \item{SeedN}{Seed nitrogen (kg N m\eqn{^{-2}}).}
    \item{leafN}{Leaf nitrogen (kg N m\eqn{^{-2}}).}
    \item{rootN}{Fine root nitrogen (kg N m\eqn{^{-2}}).}
    \item{SapwoodN}{Sapwood nitrogen (kg N m\eqn{^{-2}}).}
    \item{WoodN}{Heartwood nitrogen (kg N m\eqn{^{-2}}).}
    \item{McrbC}{Microbial carbon (kg C m\eqn{^{-2}}).}
    \item{fastSOM}{Fast soil carbon pool (kg C m\eqn{^{-2}}).}
    \item{SlowSOM}{Slow soil carbon pool (kg C m\eqn{^{-2}}).}
    \item{McrbN}{Microbial nitrogen (kg N m\eqn{^{-2}}).}
    \item{fastSoilN}{Fast soil nitrogen pool (kg N m\eqn{^{-2}}).}
    \item{slowsoilN}{Slow soil nitrogen pool (kg N m\eqn{^{-2}}).}
    \item{mineralN}{Mineral nitrogen pool (kg N m\eqn{^{-2}}).}
    \item{N_fxed}{Nitrogen fixation (kg N m\eqn{^{-2}}).}
    \item{N_uptk}{Nitrogen uptake (kg N m\eqn{^{-2}}).}
    \item{N_yrMin}{Annual available nitrogen (kg N m\eqn{^{-2}}).}
    \item{N_P25}{Annual nitrogen from plants to soil (kg N m\eqn{^{-2}}).}
    \item{N_loss}{Annual nitrogen loss (kg N m\eqn{^{-2}}).}
    \item{totseedC}{Total seed carbon (kg C m\eqn{^{-2}}).}
    \item{totseedN}{Total seed nitrogen (kg N m\eqn{^{-2}}).}
    \item{Seedling_C}{Total carbon from all compartments but seeds 
      (kg C m\eqn{^{-2}}).}
    \item{Seeling_N}{Total nitrogen from all compartments but seeds
      (kg N m\eqn{^{-2}}).}
    \item{MaxAge}{Age of the oldest tree in the tile (years).}
    \item{MaxVolume}{Maximum volumne of a tree in the tile (m\eqn{^3}).}
    \item{MaxDBH}{Maximum DBH of a tree in the tile (m).}
    \item{NPPL}{Growth of a tree, including carbon allocated to leaves
      (kg C m\eqn{^{-2}} year\eqn{^{-1}}).}
    \item{NPPW}{Growth of a tree, including carbon allocated to sapwood
      (kg C m\eqn{^{-2}} year\eqn{^{-1}}).}
    \item{n_deadtrees}{Number of trees that died (trees m\eqn{^{-2}} year\eqn{^{-1}}).}
    \item{c_deadtrees}{Carbon biomass of trees that died (kg C 
      m\eqn{^{-2}} year\eqn{^{-1}}).}
    \item{m_turnover}{Continuous biomass turnover (kg C m\eqn{^{-2}} year\eqn{^{-1}}).}
    \item{c_turnover_time}{Carbon turnover rate, calculated as the ratio
      between plant biomass and NPP (year\eqn{^{-1}}).}
  }}
  \item{\code{output_annual_cohorts}}{A data.frame of annual outputs at the
    cohort level.
  \describe{
    \item{year}{Year of the simulation.}
    \item{cID}{An integer indicating the cohort identity.}
    \item{PFT}{An integer indicating the Plant Functional Type.}
    \item{layer}{An integer indicating the crown layer, numbered from top to 
      bottom.}
    \item{density}{Number of trees per area (trees ha\eqn{^{-1}}).}
    \item{f_layer}{Fraction of layer area occupied by this cohort.}
    \item{dDBH}{Diameter growth of a tree in this cohort (cm year\eqn{^{-1}}).}
    \item{dbh}{Tree diameter (cm).}
    \item{height}{Tree height (m).}
    \item{age}{Age of the cohort (years).}
    \item{Acrow}{Crown area of a tree in this cohort (m\eqn{^2}).}
    \item{wood}{Sum of sapwood and heartwood biomass of a tree in this cohort
     (kg C tree\eqn{^{-1}}).}
    \item{nsc}{Nonstructural carbohydrates in a tree (kg C tree\eqn{^{-1}}).}
    \item{NSN}{Nonstructural nitrogen of a tree (kg N tree\eqn{^{-1}}).}
    \item{NPPtr}{Total growth of a tree, including carbon allocated to seeds, 
      leaves, fine roots, and sapwood (kg C tree\eqn{^{-1}} year\eqn{^{-1}}).}
    \item{seed}{Fraction of carbon allocated to seeds to total growth.}
    \item{NPPL}{Fraction of carbon allocated to leaves to total growth.}
    \item{NPPR}{Fraction of carbon allocated to fine roots to total growth.}
    \item{NPPW}{Fraction of carbon allocated to sapwood to total growth.}
    \item{GPP_yr}{Gross primary productivity of a tree (kg C tree\eqn{^{-1}} 
      year\eqn{^{-1}}).}
    \item{NPP_yr}{Net primary productivity of a tree (kg C tree\eqn{^{-1}} 
      year\eqn{^{-1}}).}
    \item{Rauto}{Plant autotrophic respiration (kg C tree\eqn{^{-1}} yr\eqn{^{-1}}).}
    \item{N_uptk}{Nitrogen uptake (kg N tree\eqn{^{-1}} yr\eqn{^{-1}}).}
    \item{N_fix}{Nitrogen fixation (kg N tree\eqn{^{-1}} yr\eqn{^{-1}}).}
    \item{maxLAI}{Maximum leaf area index for a tree (m\eqn{^2} m\eqn{^{-2}}).}
    \item{Volume}{Tree volume (m\eqn{^3}).}
    \item{n_deadtrees}{Number of trees that died (trees yr\eqn{^{-1}}).}
    \item{c_deadtrees}{Carbon biomass of trees that died (kg C yr\eqn{^{-1}}).}
    \item{deathrate}{Mortality rate of this cohort (yr\eqn{^{-1}}).}
  }}
}
}
\description{
Call to the biomee Fortran model
}
\examples{
\donttest{
# Example BiomeE model run

# Use example drivers data
drivers <- biomee_gs_leuning_drivers

# Run BiomeE for the first site
mod_output <- run_biomee_f_bysite(
 sitename = drivers$sitename[1],
 params_siml = drivers$params_siml[[1]],
 site_info = drivers$site_info[[1]],
 forcing = drivers$forcing[[1]],
 params_tile = drivers$params_tile[[1]],
 params_species = drivers$params_species[[1]],
 params_soil = drivers$params_soil[[1]],
 init_cohort = drivers$init_cohort[[1]],
 init_soil = drivers$init_soil[[1]]
)
}
}
