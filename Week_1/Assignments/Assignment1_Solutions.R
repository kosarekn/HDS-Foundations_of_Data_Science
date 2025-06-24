#1)
lst <- list(4, 'j', 'Y', 5, 'f', 'K', 8, 'z', 'T', 'c', 0, 'B', 2, 'm', 'X', 9, 'd', 'V', 3, 'n', 'G', 6, 'h', 'J', 2, 'p', 'O', 1, 'q', 'R', 7, 's', 'D', 2, 'l', 'N', 0, 'w', 'E', 5, 'e', 'U', 4, 'i', 'P', 1, 'a', 'H', 8, 'y', 'S', 3, 'g', 'F', 9, 'b', 'M', 6, 'k', 'L', 7)
#a)
my_types <- c()
for(thing in lst){
  my_types <- append(my_types, class(thing))
}
print(my_types)
#b)
length(which(my_types == "numeric"))
length(which(my_types == "character"))
#c)
idx <- which(lst > 5)
length(idx)
#d)
levels(factor(my_types))
#e)
which(lst == 1)



#2)
#a)
file <- read.delim("/Users/f002yt8/Documents/GitHub/HDS-Foundations_of_Data_Science/Week_1/Data/GSE165252_vst_PERFECT.txt",row.names = 1)
#b) 
ncol(file)
#c)
nrow(file)
#d)
ENSG00000000005_exp <- hist(as.matrix(file["ENSG00000000005.6",]))
plot(ENSG00000000005_exp)
#e)
eso_sub <- file[1:2000,1:3]
write.csv(eso_sub, "/Users/f002yt8/Documents/GitHub/HDS-Foundations_of_Data_Science/Week_1/Data/eso_sub.csv")



#3) Students should have some sort of function with a 
#for loop and if/else statement as below.

less_than <- c()
greater_than <- c()
  
my_first_function <- function(my_vector){
  for (thing in my_vector){
  if (thing <=5){
    less_than <- append(less_than, thing)
  }else{
    greater_than <- append(greater_than, thing)
  }
  }
print(greater_than)
print(less_than)
}

my_vector <- c(1,2,3,4,5,6,7,8,9)
my_first_function(my_vector)