setwd("/Users/boheechoi/Desktop/quiz/data/")

#bring the raw data ...
file_list1 <- list.files(path="/Users/boheechoi/Desktop/quiz/data/", pattern = "住所*")
file_list2 <- list.files(path="/Users/boheechoi/Desktop/quiz/data", pattern = "出身*")

#read the raw data ...
data_address <- rbindlist(lapply(file_list1, fread)) #nrow(data_address)=49530
data_info <- rbindlist(lapply(file_list2, fread)) #nrow(data_hometown)=49530

address_header <- colnames(data_address)
info_header <- colnames(data_info)
# address_header  :  "氏名"  "氏名（カタカナ）"  "full_address" 
# info_header     :  "氏名"  "氏名（カタカナ）"  "生年月日"      "出身地" 

#inner join the two data on name columns
total_dt <- merge(data_address, data_info, by = address_header[1:2])
total_dt_header <- colnames(total_dt)
# total_dt_header :  "氏名"  "氏名（カタカナ）"  "full_address"   "生年月日"    "出身地" 
#end of merging 

#add a new column "age" to the data table
today <- as.Date("2017-12-17")
total_dt$生年月日 <- as.Date(total_dt$生年月日)
total_dt$age <- as.integer(as.numeric(today - total_dt$生年月日)/365)

#get the average of age per town
library(dplyr)
total_dt1 <- total_dt %>%
  group_by(出身地) %>%
  summarise(avg_age = mean(age)) 

#order in an descending order
total_dt1$avg_age <- total_dt1$avg_age[order(total_dt1$avg_age)] 

#draw the first graph : 出身都道府県別平均年齢
library(ggplot2)
theme_set(theme_gray(base_size=12, base_family="HiraKakuProN-W3")) #showing japanese on ggplot2

p1 <- ggplot(total_dt1, aes(y=avg_age, x=出身地)) + 
  geom_bar(stat="identity", fill="blue") + 
  coord_flip() +
  ylab("age") +
  ggtitle("出身都道府県別平均年齢（as of 17 Dec. 2017, N=49,530）")


#draw the second graph : 都道府県別同一域内にとどまっている割合
library(stringr) 
# 1) add a new logical column- TRUE: the person stayed, FALSE: the person moved out of the hometown
#nrow(total_dt) = 49530
total_dt$is_address_matched <- apply(total_dt, 1, function(x) grepl(x[5], x[3], fixed=T))

# 2) gather the number of people who stayed and moved
eval_stay_dt <- total_dt %>%
  group_by(出身地) %>%
  summarise(total_N = n(), stayed_N =sum(is_address_matched))

eval_stay_dt$stay_perc <- (eval_stay_dt$stayed_N/eval_stay_dt$total_N)*100
eval_stay_dt$出身地 <- factor(eval_stay_dt$出身地, 
                           levels = eval_stay_dt$出身地[order(eval_stay_dt$stay_perc)])

p2 <- ggplot(eval_stay_dt, aes(出身地, stay_perc)) +
  geom_bar(stat="identity", fill="blue") +
  coord_flip() + 
  ylab("stay (%)")
  ggtitle("都道府県別同一域内にとどまっている割合（as of 17 Dec. 2017, N=49,530）")


##the 3rd graph of the correlationship between the percentage and age per town
eval_stay_age_dt <- merge(eval_stay_dt, total_dt1)

p3 <- ggplot(eval_stay_age_dt, aes(y=stay_perc, x=avg_age)) + 
  geom_point(color = "blue") + 
  scale_x_continuous(limits = c(0, 50)) +
  ggtitle("都道府県別平均年齢と同一域内にとどまっている割合の関係（as of 17 Dec. 2017, N=49,530）") +
  ylab("stay (%)") + xlab("age")
