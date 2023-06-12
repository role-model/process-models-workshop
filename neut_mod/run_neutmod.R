#### Source code ####

source(here::here("neut_mod", "neutral_mod.R"))


#### Play with parameters ####

toy_sim <- untb(Jm = 10000, Sm = 1000, J = 100, m =.01, nu = .01, niter = 1000)

toy_summary <- untb_hill(toy_sim)

#### Run with a bunch of parameters ####

nrep = 10000

allNus <- runif(nrep, 0, 0.6)
allMs <- runif(nrep, 0, 0.6)

sims <- list()
hills <- list()

for(i in 1:nrep) {
  
  sims[[i]] <- untb(Jm = 10000,
                    Sm = 1000,
                    J = 100,
                    m = allMs[i],
                    nu = allNus[i],
                    niter = 1000)
  
  hills[[i]] <- untb_hill(sims[[i]])
}


all_hills <- do.call(rbind, hills)

all_hills$Nu = allNus
all_hills$M = allMs

#### Visualize (or do interactively/adaptively) ####

library(ggplot2)

theme_set(theme_bw())

ggplot(all_hills, aes(M, Nu, color = hill0)) +
  geom_point() +
  scale_color_viridis_c()


ggplot(all_hills, aes(M, Nu, color = hill1)) +
  geom_point() +
  scale_color_viridis_c()


ggplot(all_hills, aes(M, Nu, color = hill2)) +
  geom_point() +
  scale_color_viridis_c()


ggplot(all_hills, aes(M, hill0, color = Nu)) +
  geom_point()

ggplot(all_hills, aes(M, hill1, color = Nu)) +
  geom_point()

ggplot(all_hills, aes(M, hill2, color = Nu)) +
  geom_point() 


ggplot(all_hills, aes(Nu, hill0, color = M)) +
  geom_point()

ggplot(all_hills, aes(Nu, hill1, color = M)) +
  geom_point()

ggplot(all_hills, aes(Nu, hill2, color = M)) +
  geom_point()


#### Random forest inference ####

library(randomForest)
