#!/bin/bash
#SBATCH --job-name=my_bash_job       
#SBATCH --output=job_output_%j.txt   
#SBATCH --ntasks=1                   
#SBATCH --time=00:10:00              
#SBATCH --partition=standard           
#SBATCH --mem=1G

## My bash code
FILE_PATH="/dartfs-hpc/rc/home/8/f002yt8/pseudo_rnaseq_counts.csv"

head -n 100 "$FILE_PATH" | cut -d',' -f1-2 >> "/dartfs-hpc/rc/home/8/f002yt8/pseudo_renseq_counts_sub.csv"

mkdir "outputs"

mv "/dartfs-hpc/rc/home/8/f002yt8/pseudo_renseq_counts_sub.csv" "/dartfs-hpc/rc/home/8/f002yt8/outputs/pseudo_renseq_counts_sub.csv"

cd "outputs"

Rscript "/dartfs-hpc/rc/home/8/f002yt8/my_R_script.R"