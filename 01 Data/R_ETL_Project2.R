#Before running this R file make sure you set you working directory to where the CSV file located.

file_path <- "HI.csv"

df <- read.csv(file_path, stringsAsFactors = FALSE)

Newdf <- subset(df, select = c("whrswk","hhi","whi","hhi2","education","race","hispanic","experience","kidslt6","kids618","husby","region"))

#head(Newdf)

# Replace "." (i.e., period) with "_" in the column names.
names(Newdf) <- gsub("\\.+", "_", names(Newdf))

str(Newdf) # Uncomment this and  run just the lines to here to get column types to use for getting the list of measures.


measures <- c("whrswk", "experience", "kidslt6", "kids618", "husby")

# Get rid of special characters in each column.
# Google ASCII Table to understand the following:
for(n in names(Newdf)) {
    Newdf[n] <- data.frame(lapply(Newdf[n], gsub, pattern="[^ -~]",replacement= ""))
}

dimensions <- setdiff(names(Newdf), measures)
#dimensions
if( length(measures) > 1 || ! is.na(dimensions)) {
  for(d in dimensions) {
    # Get rid of " and ' in dimensions.
    Newdf[d] <- data.frame(lapply(Newdf[d], gsub, pattern="[\"']",replacement= ""))
    # Change & to and in dimensions.
    Newdf[d] <- data.frame(lapply(Newdf[d], gsub, pattern="&",replacement= " and "))
    # Change : to ; in dimensions.
    Newdf[d] <- data.frame(lapply(Newdf[d], gsub, pattern=":",replacement= ";"))
  }
}


# Get rid of all characters in measures except for numbers, the - sign, and period.dimensions
if( length(measures) > 1 || ! is.na(measures)) {
  for(m in measures) {
    Newdf[m] <- data.frame(lapply(Newdf[m], gsub, pattern="[^--.0-9]",replacement= ""))
  }
}

write.csv(Newdf, paste(gsub(".csv", "", file_path), ".reformatted.csv", sep=""), row.names=FALSE, na = "")

tableName <- gsub(" +", "_", gsub("[^A-z, 0-9, ]", "", gsub(".csv", "", file_path)))
sql <- paste("CREATE TABLE", tableName, "(\n-- Change table_name to the table name you want.\n")
if( length(measures) > 1 || ! is.na(dimensions)) {
  for(d in dimensions) {
    sql <- paste(sql, paste(d, "varchar2(4000),\n"))
  }
}
if( length(measures) > 1 || ! is.na(measures)) {
  for(m in measures) {
    if(m != tail(measures, n=1)) sql <- paste(sql, paste(m, "number(38,4),\n"))
    else sql <- paste(sql, paste(m, "number(38,4)\n"))
  }
}
sql <- paste(sql, ");")
cat(sql)
