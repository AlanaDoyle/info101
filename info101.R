library(ggplot2)
library(marinecs100b)
remotes::install_github("MarineCS-100B/marinecs100b")
6# Questionable organization choices ---------------------------------------

# P1 Call the function dir() at the console. This lists the files in your
# project's directory. Do you see woa.csv in the list? (If you don't, move it to
# the right place before proceeding.)
dir()

# P2 Critique the organization of woa.csv according to the characteristics of
# tidy data.
read.csv("woa.csv")

#Does not follow make a rectangle condition. Multiple lines of headers.
#Readable- Names have spaces, lables that look like variables
#Inconsistency- need to use "NA" instead of blank variables

# Importing data ----------------------------------------------------------

# P3 P3 Call read.csv() on woa.csv. What error message do you get? What do you
# think that means?
#Error in read.table(file = file, header = header, sep = sep, quote = quote,  :
#                      more columns than column names

#Unlabeled columns and data not labled correctly.

# P4 Re-write the call to read.csv() to avoid the error in P3.

woa.csv <- read.csv("woa.csv", skip = 1)

View(woa.csv)
# Fix the column names ----------------------------------------------------

# P5 Fill in the blanks below to create a vector of the depth values.

depths <- c(
  seq(0, 100, by = 5),
  seq(125, 550, by = 25),
  seq(600, 2000, by = 50),
  seq(2100, 5500, by = 100)
)

# P6 Create a vector called woa_colnames with clean names for all 104 columns.
# Make them the column names of your WOA data frame.
woa_colnames <- paste0("depth_",depths)
woa_colnames <- c("latitude", "longitude", paste0("depth_", depths))


# Analyzing wide-format data ----------------------------------------------

# P7 What is the mean water temperature globally in the twilight zone (200-1000m
# depth)?
twilight_rows <- woa.csv[ , 27:49]
sum_twilight_rows <- sum(twilight_rows, na.rm = TRUE)
twilight_non_na <- sum(!is.na(twilight_rows))
mean_temp <- sum_twilight_rows / twilight_non_na

#6.573

# Analyzing long-format data ----------------------------------------------

# P8 Using woa_long, find the mean water temperature globally in the twilight zone.
twilight_temps_long <- woa_long[woa_long$depth_m  >= 200 & woa_long$depth_m <= 1000, "temp_c" ]
mean(twilight_temps_long)

#6.573
# P9 Compare and contrast your solutions to P8 and P9.
#We got the same answer from both methods

# P10 Create a variable called mariana_temps. Filter woa_long to the rows in the
# location nearest to the coordinates listed in the in-class instructions.
mariana_temps <- woa_long[woa_long$latitude == 11.5 & woa_long$longitude == 142.5, ]

View(mariana_temps)
# P11 Interpret your temperature-depth profile. What's the temperature at the surface? How about in the deepest parts? Over what depth range does temperature change the most?

#Temp at the surface is 28 degrees Celsius and at the deepest point it is 2 degrees Celsius. The largest temperature change is over 1000 to 0 meters deep.
# ggplot is a tool for making figures, you'll learn its details in COMM101
ggplot(mariana_temps, aes(temp_c, depth_m)) +
  geom_path() +
  scale_y_reverse()
