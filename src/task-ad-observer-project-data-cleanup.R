library(tidyverse)
library(xml2)

setwd("C:/Users/Arees/Documents/GitHub/Test/dep")
PA_Facebook_Data <- read_csv("en-US.csv")

#Using Tidyverse to easily grab the data
Primary_Corpus = select(PA_Facebook_Data, html, 
                        id, political, not_political, political_probability)

#Converts the HTML into plain text using xml12, then save's the text into
#the Dataframe in the new column html_text
Primary_Corpus$html_text = NA
for (i in 1:nrow(Primary_Corpus)){
  text_html = read_html(Primary_Corpus$html[i])
  full_text = xml_text(text_html)
  Primary_Corpus$html_text[[i]] = full_text
}

#Saves the dataframe as a RData file
save(Primary_Corpus, file = "Facebook-Data-Trimmed")
