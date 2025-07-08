dat <- read.csv("/dartfs-hpc/rc/home/8/f002yt8/outputs/pseudo_renseq_counts_sub.csv", header = TRUE)

total_sum <- sum(dat[[2]], na.rm = TRUE)

print(total_sum)
