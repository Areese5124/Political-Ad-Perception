library(tidyverse)
library(stm)
library(SnowballC)

setwd("C:/Users/Arees/Documents/GitHub/Test/dep")
load("~/GitHub/Test/dep/Facebook-Data-Trimmed")

#Dividing the Dataset into Political versus Not Political
Primary_Corpus$Political_or_not <- ifelse(Primary_Corpus$political > 
                                            Primary_Corpus$not_political, 
                                          "Political", "Not Political")
PC_Political <- filter(Primary_Corpus,Political_or_not == "Political")
PC_Not_Political <- filter(Primary_Corpus,Political_or_not == "Not Political")

#STM Creation
#Preprocessing for Neg
temp_Neg <-textProcessor(documents=PC_Not_Political$html_text, metadata=PC_Not_Political)
out_Neg <- prepDocuments(temp_Neg$documents, temp_Neg$vocab, temp_Neg$meta)
#STM Model for Neg
model_Neg.stm <- stm(out_Neg$documents, out_Neg$vocab, K = 10,
                     data = out_Neg$meta)

#Preprocessing for Pos
temp_pos <-textProcessor(documents=PC_Political$html_text, metadata=PC_Political)
out_pos <- prepDocuments(temp_pos$documents, temp_pos$vocab, temp_pos$meta)
#STM Model for Pos
model_pos.stm <- stm(out_pos$documents, out_pos$vocab, K = 10,
                     data = out_pos$meta)

### Visualizing and Labeling the Data:
##For Neg: The following two lines are used to delve deeper into the model
#labelTopics(model_Neg.stm)
#findThoughts(model_Neg.stm, texts=out_Neg$meta$message, topics=10, n=3)

Neg_Names = c("Sandy Hook:","Trump's Environmental Practices:"
              ,"Biden Victory Fund:", "Importance of Voting:", 
              "Bahama's Hurricane Relief:", "Boyscout SA Compensation:"
              ,"Gun Control:","AOC Fundraising:","Save The Bees:","Penzy Ad:")
Neg_Plot = plot(model_Neg.stm, n=2, labeltype="frex", topic.names=Neg_Names)

##For Pos: The following two lines are used to delve deeper into the model
#labelTopics(model_pos.stm)
#findThoughts(model_pos.stm, texts=out_pos$meta$message, topics=10, n=3)
Pos_Names = c("AOC Fundraising:","Warren Fundraising:","Florida Tax:",
              "Florida Senate Race:","Hagan Congress:",
              "Trump Policies:","Sandy Hook:","Sandy Hook:",
              "DEM Political:","Nike Kaepernic:")
Pos_Plot = plot(model_pos.stm, n=2, labeltype="frex", topic.names=Pos_Names)
##
