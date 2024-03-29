library(readtext)

DATA_DIR <- system.file("/citing-weinberg/weinberger_positive_cases", package = "readtext")
readtext(paste0(DATA_DIR, "/word/*.docx"))

stringr::str_extract(testText, ".{0,50}Romero.{0,200}")

fileList <- list.files(path = "/Volumes/BlackSams/CartoCollective/CourtCases/Barcelo/citing-weinberg/weinberg-legacy", pattern = "\\.txt")


###Creating patterns###

court <- "(United States District Court)"
month <- c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")

#####
####Identifying the court where each case was heard#######

df=NULL
df1=NULL
df2=NULL
df3=NULL
all=NULL
for(g in fileList){
  linesRead <- readLines(g, skipNul = FALSE)
  textRead <- paste(readLines(g, skipNul = FALSE), collapse=" ")
  caseLine <- as.data.frame(linesRead[4]) #Extracts the name of the case
  courtLine <- as.data.frame(linesRead[5]) #Extracts the court in which the case was heard
  df1 <- merge(caseLine, courtLine) #merging case and court dataframes
  terms <- stringr::str_extract(textRead, "Core Terms.{0,120}") #Parses the document for "Core Terms" and extracts the following 120 characters, which generally includes all of the keywords of the case.
  termsFrame <- as.data.frame(terms) 
  df2 <- merge(df1, termsFrame)
  overview <- stringr::str_extract(textRead, "Overview.{0,120}") #Does the same thing as the Core Terms operation but with the case overview
  overviewFrame <- as.data.frame(overview)
  df3 <- merge(df1, overviewFrame)
  romero <- stringr::str_extract(textRead, ".{0,300}Romero.{0,300}") #Same thing as Core Terms and Overview, but with the term Romero. This extracts the text before and after "Romero" is mentioned, providing some context for how the case was cited.
  romeroFrame <- as.data.frame(romero)
  all <- merge(df2, romeroFrame)
  df <- rbind(df, all)
}


termsList <- for(g in fileList){
  linesRead <- readLines(g)
  textRead <- paste(readLines(g), collapse=" ")
  terms <- stringr::str_extract(textRead, "Core Terms.{0,120}")
  termsFrame <- as.data.frame(terms)

###Works for geocoding court districts####
###Uses the 'Court' column in the dataframe created above, and then uses those names as the address used to geocode each case.###

courtNames <- data.frame(Address = df$`Court`,
                   stringsAsFactors = FALSE)

courtAddress <- mutate_geocode(courtNames, location = Address, output = "latlona")

courtsGeo <- merge(df, courtAddress) # This adds the lat/lon data to the overdall data frame
#########



for(g in fileList){
  linesRead <- readLines(g)
  fileName <- paste0("withRomero_", g)
  capture.output(for(i in linesRead){
    extracted <- stringr::str_extract(i, ".{0,500}Romero.{0,500}")
    print(extracted, na.print = "")
    extracted = NULL
  }, file = fileName)
  linesRead = NULL
  fileName = NULL
}

substr(x, 1, 3)

###Finding References to Romero###

for(g in fileList){
  linesRead <- readLines(g)
  textRead <- paste(readLines(g), collapse=" ")
  fileName <- paste0("Romero_", g)
  overview <- stringr::str_extract(textRead, "United{0,400}")
  lines <- for(i in linesRead){
                romero <- stringr::str_extract(i, ".{0,700}Romero.{0,700}")
                paste(readLines(romero), collapse=" ")
                print(romero)
                romero = NULL
                }
  capture.output(paste0(overview, "            |  REFERENCES TO ROMERO-BARCELO   |            ", lines), file = fileName)
  linesRead = NULL
  textRead = NULL
  fileName = NULL
}


###Finding just the first instance of Romero###

for(g in fileList){
  textRead <- paste(readLines(g), collapse=" ")
  fileName <- paste0("CaseInfo_", g)
  date <- stringr::str_extract(textRead, ".{0,20}Decided")
  court <- stringr::str_extract(textRead, "United States District Court.{0,50}")
  terms <- stringr::str_extract(textRead, "Core Terms.{0,75}")
  romeroQuote <- for(i in textRead){
    romero <- stringr::str_extract(i, ".{0,400}Romero.{0,400}")
  }
  capture.output(paste0(court, " | ", date, " | ", terms, " | ", romeroQuote), file = fileName)
  linesRead = NULL
  textRead = NULL
  fileName = NULL
  date <- NULL
  court <- NULL
  terms <- NULL
  romeroQuote <- NULL
}




for(g in fileList){
  linesRead <- readLines(g)
  textRead <- paste(readLines(g), collapse=" ")
  fileName <- paste0("CaseInfo_", g)
  capture.output(for(i in textRead){
    romeroQuote <- stringr::str_extract_all(i, ".{0,500}Romero\\n.")
    date <- stringr::str_extract(textRead, "(?<=\\s).{13}Decided")
    court <- stringr::str_extract(textRead, "United States District Court.{0,50}")
    terms <- stringr::str_extract(textRead, "Core Terms.{0,120}")
    print(cat(paste(court, date, terms, romeroQuote, sep=":\n")))
    romeroQuote = NULL
  }, file = fileName)
  linesRead = NULL
  textRead = NULL
  fileName = NULL
}

for(g in fileList){
  linesRead <- readLines(g)
  textRead <- paste(readLines(g), collapse=" ")
  fileName <- paste0("CaseInfo_", g)
  for(i in linesRead){
    romeroQuote <- stringr::str_extract_all(i, ".{0,500}Romero")
    print(romeroQuote)
  }
}

###Finding the Court it is a part of###

for(g in fileList){
  textRead <- paste(readLines(g), collapse=" ")
  fileName <- paste0("Court_", g)
  court <- stringr::str_extract(textRead, "United States District Court.{0,50}")
  capture.output(print(court), file = fileName)
  linesRead = NULL
  textRead = NULL
  fileName = NULL
}


  
linesRead <- readLines("Wisconsin v. Weinberger, 745 F.2d 412.txt")
lines <- capture.output(for(i in linesRead){
  romero <- stringr::str_extract(i, ".{0,700}Romero.{0,700}")
  print(romero, na.print = "")
})







capture.output(for(i in testLines){
  extracted <- stringr::str_extract(i, "Romero.\\n")
  print(extracted, na.print = "")
  extracted = NULL
}

ind <- grep("just", myString)
substr(myString, ind-4, ind+4)
