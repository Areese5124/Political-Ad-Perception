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
targ_temp_Neg <-textProcessor(documents=PC_Not_Political$html_text, metadata=PC_Not_Political)
targ_out_Neg <- prepDocuments(temp_Neg$documents, temp_Neg$vocab, temp_Neg$meta)
#STM Model for Neg
targ_model_Neg.stm <- stm(out_Neg$documents, out_Neg$vocab, K = 10, prevalence = 
                       ~political_probability
                     , data = out_Neg$meta)

#Preprocessing for Pos
targ_temp_pos <-textProcessor(documents=PC_Political$html_text, metadata=PC_Political)
targ_out_pos <- prepDocuments(temp_pos$documents, temp_pos$vocab, temp_pos$meta)
#STM Model for Pos
targ_model_pos.stm <- stm(out_pos$documents, out_pos$vocab, K = 10, prevalence = 
                       ~political_probability
                     , data = out_pos$meta)

### Visualizing and Labeling the Data:
##For Neg: The following two lines are used to delve deeper into the model
#labelTopics(model_Neg.stm)
#findThoughts(model_Neg.stm, texts=out_Neg$meta$message, topics=10, n=3)  
Targ_Neg_Names = c("Democrat Polls:",
                   "Sandy Hook:",
                   "Refugee Arabic:",
                   "Political Medical:",
                   "Biden Victory Fund:",
                   "Spanish Democrat:",
                   "Penzy Statement:",
                   "DEM Fem-candidate:",
                   "Sandy Hook:",
                   "Penzy's Hope Box:" )
Targ_Neg_Plot = plot(targ_model_Neg.stm, n=2, labeltype="frex", topic.names=Targ_Neg_Names)

##For Pos Model
#labelTopics(targ_model_pos.stm)
#findThoughts(targ_model_pos.stm, texts=target_out_pos$meta$message, topics=10, n=3)
Targ_Pos_Names = c("NRDC Anti-oil Ads:",
                   "Corybooker Ad:",
                   "Florida Tax:",
                   "Gun Control:",
                   "NJ H/O Solar Reimb:",
                   "Nike Kaepernic:",
                   "GOP Fem-candidate Spanish:",
                   "Brett Kav SA:",
                   "Federal Economic Policy:",
                   "Bernie Fundraising:")
Targ_Pos_Plot = plot(targ_model_pos.stm, n=2, labeltype="frex", topic.names=Targ_Pos_Names)

