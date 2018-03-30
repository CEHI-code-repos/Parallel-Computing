library(parallel)
numCores <- detectCores()
clust <- makeCluster(numCores)
cbgs <- readOGR(dsn = "/Users/manchongleong/Desktop/Crate/Projects/NIH/Env_Mixtures/Racial_isolation_index_calculation/Data",
                   layer = "NC_surrounding_bg_carto_2010")
# Import dbf files.
dbfBgs <- read.dbf("/Users/manchongleong/Desktop/Crate/Projects/NIH/Env_Mixtures/Racial_isolation_index_calculation/Data/cen2010_NC_surrounding_BG_RI.dbf")
# Create a variable with the same name as cbgs.
dbfBgs$GEOID10 <- dbfBgs$stfid10_bg
# Merge two dataframe.
mergeCbgs <- merge(cbgs, dbfBgs, by = "GEOID10")


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# # # Step 1.2 Create adjacency matrix # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # # #


summary(mergeCbgs)
dim(mergeCbgs)
# Follow the example code to create a variable named FullFips.
mergeCbgs$FullFips <- mergeCbgs$GEOID10
# plot(mergeCbgs, lwd=.1, main='Plot of Census Bgs')

# Constructs neighbors from a polygon list.
neighbor <- poly2nb(mergeCbgs)

