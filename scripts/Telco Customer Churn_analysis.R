library(ggplot2)
library(dplyr)
library(tidyr)
library(corrplot)
library(gridExtra)
library(scales)
library(tidyverse)

Telco_Customer_Churn

#info abt the dataset
telco_data <- Telco_Customer_Churn
telco_data
dim(telco_data)
head(telco_data)
str(telco_data)


#data cleaning
##check missing values
colSums(is.na(telco_data))

##check for empty srings in totalcharges
sum(telco_data$TotalCharges == "")

##convert totalcharges to numeric, handling empty strings
telco_data$TotalCharges <- as.numeric(telco_data$TotalCharges)


##check for rows with NA in totalchrges after coversion
na_total_charges <- sum(is.na(telco_data$TotalCharges))
print("NA values Totalchrges after conversion:", na_total_charges) #11


#for customers with 0 tenure and NA totalcharges, replace with MonthlyChrges
#this is likely new customers where totalchrges= monthlycharges
telco_data$TotalCharges[is.na(telco_data$TotalCharges) & telco_data$tenure == 0] <-
  telco_data$MonthlyCharges[is.na(telco_data$TotalCharges) & telco_data$tenure == 0]

#check remaining NA values
#NA values inn TotalCharges after fix:
sum(is.na(telco_data$TotalCharges))

#convert categorical variables to factors

categorical_cols <- c("gender", "Partner", "Dependents", "PhoneService", "MultipleLines", 
                      "InternetService", "OnlineSecurity", "OnlineBackup", "DeviceProtection",
                      "TechSupport", "StreamingTV", "StreamingMovies", "Contract", 
                      "PaperlessBilling", "PaymentMethod", "Churn")

telco_data[categorical_cols] <- lapply(telco_data[categorical_cols], as.factor)

#convert seniorCitizen to factor with meaningful labels
telco_data$SeniorCitizen <- factor(telco_data$SeniorCitizen,
                                   levels = c(0, 1),
                                   labels = c("No", "Yes"))
##data types after cleaning
str(telco_data)


#summary statistics for numerical variables
numerical_summary <- telco_data %>%
  select(tenure, MonthlyCharges, TotalCharges) %>%
  summary()
print(numerical_summary)


##churn distribution
churn_table <- table(telco_data$Churn)
print(churn_table)
#churn rate
round(churn_table["Yes"] / sum(churn_table) * 100, 2)




##----exploratory data analysis (EDA)---##
#churn distribution
plot1 <- ggplot(telco_data, aes(x = Churn, fill = Churn)) +
  geom_bar(alpha = 0.8) +
  geom_text(stat = 'count', aes(label = after_stat(count)), vjust = -0.5) +
  scale_fill_manual(values = c("No" = "#3498db", "Yes" = "#e74c3c")) +
  labs(title = "Customer Churn Distribution", 
       x = "churn Status",
       y = "Number of Customers") +
  theme_light()+
  theme(legend.position = "none")
ggsave("plots/01_churn_distribution.png", plot1, width =8, height =6)
print("Plot 1: churn Distribution saved")


#churn by gender
plot2 <- ggplot(telco_data, aes(x= gender, fill = Churn)) +
  geom_bar(position = "fill", alpha = 0.8) +
  scale_fill_manual(values = c("No" = "#3498db" , "Yes" = "#e74c3c"))+
  labs(title = "Churn Rate by Gender",
       x = "Gender",
       y = "Proportion") +
  theme_minimal() +
  scale_y_continuous(labels = percent_format())

ggsave("plots/02_churn_by_gender.png", plot2, width = 8, height = 6)
print("Plot 2: Churn by Gender saved")

#churn by senior citizen status
plot3 <-ggplot(telco_data, aes(x = SeniorCitizen, fill = Churn)) +
  geom_bar(position = "fill", alpha = 0.8) +
  scale_fill_manual(values = c("No" = "#3498db" , "Yes" = "#e74c3c")) +
  labs(title = "Churn Rate by Senior Citizen Status",
       x = "Senior Citizen",
       y = "Proportion") +
  theme_minimal() + 
  scale_y_continuous(labels = percent_format())

ggsave("plots/03_churn_by_senior.png", plot3, width = 8, height = 6)
print("Plot 3: Churn by Senior Citizen saved")


#churn by contract type
plot4  <- ggplot(telco_data, aes(x = Contract, fill = Churn)) +
  geom_bar(position = "fill", alpha = 0.8) +
  scale_fill_manual(values = c("No" = "#3498db", "Yes" = "#e74c3c")) +
  labs(title = "Churn Rate by Contract Type", 
       x = "Contract Type",
       y = "Proportion") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_y_continuous(labels = percent_format())

ggsave("plots/04_churn_by_contract.png", plot4, width = 10, height = 6)
print("Plot 4: Churn by Contract saved")


#churn by Internet service
plot5 <- ggplot(telco_data, aes(x = InternetService, fill = Churn)) +
  geom_bar(position = "fill", alpha = 0.8) +
  scale_fill_manual(values = c("No" = "#3498db", "Yes" = "#e74c3c")) +
  labs(title = "Churn Rate by Internet Service",
       x = "Internet Service",
       y = "Proportion") +
  theme_minimal() +
  scale_y_continuous(labels = percent_format())
ggsave("plots/05_churn_by_internet.png", plot5, width = 8, height = 6)
print("Plot 5: Churn by Internet Service saved")


#churn by payment method
plot6 <- ggplot(telco_data, aes(x = PaymentMethod, fill = Churn)) +
  geom_bar(position = "fill", alpha = 0.8) +
  scale_fill_manual(values = c("No" = "#3498db", "Yes" = "#e74c3c")) +
  labs(title = "Churn Rate by Payment Method",
       x = "Payment Method",
       y = "proportion") +
  theme_minimal()+ 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_y_continuous(labels = percent_format())

ggsave("plots/06_churn_by_paymenyMethod.png", plot6, width = 12, height = 6)
print("Plot6: Churn by payment Method saved")


#Box plot for numerical variables
plot7 <- ggplot(telco_data, aes(x= Churn, y= tenure, fill = Churn))+
  geom_boxplot(alpha = 0.7) +
  scale_fill_manual(values = c("No" = "#3498db", "Yes" = "#e74c3c")) +
  labs(title = "Tenure Distribution by Churn status",
       x = "Churn Status",
       y = "Tenure (months)") +
  theme_minimal()

ggsave("plots/07_tenure_by_churn.png", plot7, width = 8, height = 6)
print("Plot7: Tenure by Churn saved")


#monthly charges by churn
plot8 <- ggplot(telco_data, aes(x = Churn, y = MonthlyCharges, fill = Churn))+
  geom_boxplot(alpha = 0.7)+
  scale_fill_manual(values = c("No" = "#3498db", "Yes" = "#e74c3c"))+
  labs(title= "Monthly Charges Distribution by Churn Status",
       x = "Churn Status",
       y = "Monthly Charges ($)")+
  theme_minimal()
ggsave("plots/08_monthly_charges_by_churn.png", plot8, width = 8, height = 6)
print("Plot8: Monthly Charges by Churn saved")


#total charges distributed by churn
plot9 <- ggplot(telco_data, aes( x= Churn , y= TotalCharges, fill = Churn))+
  geom_boxplot(alpha = 0.7) +
  scale_fill_manual(values = c("No" = "#3498db", "Yes" = "#e74c3c"))+
  labs(title = "Total Charges Distribution by Churn Status",
                    x = "Churn Status",
                    y = "Total Charges ($)") +
  theme_light()
ggsave("plots/09_totalcharges_by_churn.png", plot9, width = 8, height = 6)
print("Plot9: Total Changes by churn saved")


##correlation Matrix
correlation_data <- telco_data %>%
  select(tenure, MonthlyCharges, TotalCharges) %>%
  cor()
png("plots/10_correlation_matrix.png", width = 800, height = 600)
corrplot(correlation_data, method = "color", type = "upper",
         addCoef.col = "black", tl.col = "black",
         title = "Correlation Matrix: Numerical Variables", 
         mar = c(0,0,1,0))
dev.off()
print("plot10: correlation matrix saved")


#tenure group analysis
telco_data$tenure_group <- cut(telco_data$tenure,
                               breaks = c(-Inf, 12, 24, 48, Inf),
                               labels = c("0-12 months", "13-24 months", "24-48 months", "49+ months"))

plot11 <- ggplot(telco_data, aes(x= tenure_group, fill = Churn))+
  geom_bar(position = "fill",alpha=0.8)+
  scale_fill_manual(values = c("No"= "#3498db", "Yes" = "#e74c3c"))+
  labs(title = "Churn Rate by Tenure Group",
       x= "Tenure Group",
       y="Propotion")+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  scale_y_continuous(labels = percent_format())
ggsave("plots/11_Churn_by_tenure_group.png", width = 10, height = 6)
print("Plot11: Churn by Tenure Group saved")


#churn rates by different factors
churn_by_internet <- telco_data %>%
  group_by(InternetService) %>%
  summarise(
    Total = n(),
    Churned = sum(Churn == "Yes"),
    Churn_rate = round(Churned / Total *100, 2)
  )
###churn rate by internet service
print(churn_by_internet)


churn_by_contract <- telco_data %>%
  group_by(Contract) %>%
  summarise(
    Total = n(),
    Churned = sum(Churn == "Yes"),
    Churn_rate = round(Churned / Total *100, 2)
  )
###churn rate by contract
print(churn_by_contract)

churn_by_payment <- telco_data %>%
  group_by(PaymentMethod) %>%
  summarise(
    Total = n(),
    Churned = sum(Churn == "Yes"),
    Churn_rate = round(Churned / Total *100, 2)
  )
### churn by payment method
print(churn_by_payment)


#tenure group analysis
churn_by_tenure_group <- telco_data %>%
  group_by(tenure_group) %>%
  summarise(
    Total = n(),
    Churned = sum(Churn == "Yes"),
    Churn_rate = round(Churned / Total *100, 2)
  )
###churn rate by tenure group  
print(churn_by_tenure_group)



#statistical Test
##chi-square test for Contract type and churn
contract_churn_test <- chisq.test(table(telco_data$Contract, telco_data$Churn))
#Chi-square statistic
round(contract_churn_test$statistic, 4)
#P-value
format.pval(contract_churn_test$p.value, digits = 4)


##chi-square test for Internet service and churn
internet_churn_test <-chisq.test(table(telco_data$InternetService, telco_data$Churn))
#chi-square statistic
round(internet_churn_test$statistic,4)
#p-value
format.pval(internet_churn_test$p.value, digits=4)


#T-test for tenure difference between churned and non-churned
tenure_churn_test <- t.test(tenure ~ Churn, data = telco_data)
round(tenure_churn_test$statistic, 4)
format.pval(tenure_churn_test$p.value, digits = 4)


#T-test for monthlycharges difference between churned and non-churned
charges_churn_test <- t.test(MonthlyCharges ~Churn, data = telco_data)
round(charges_churn_test$statistic, 4)
format.pval(charges_churn_test$p.value, digits = 4)

#OverAll Statistics
total_customers <- nrow(telco_data)
total_churned <- sum(telco_data$Churn == "Yes")
overall_churn_rate <- round(total_churned / total_customers * 100,2)

cat("Overall Statistics: ")
cat("Total Customers: ",total_customers)
cat("Total Churned: ", total_churned)
cat("Overall Churn Rate: ", overall_churn_rate)


#average tenure and charges by churn status
cat("Average Metrics by churn status: ")
avg_metrics <- telco_data %>%
  group_by(Churn) %>%
  summarise(
    Avg_Tenure = round(mean(tenure),1),
    Avg_Monthly_charges = round(mean(MonthlyCharges), 2),
    Avg_Total_Charges = round(mean(TotalCharges), 2),
    count= n()
  )
print(avg_metrics)


#high risk segments
cat("High-Risk Segments")

#Contract type risk
churn_by_contract
high_risk_contract <- churn_by_contract$Contract[which.max(churn_by_contract$Churn_rate)]

high_risk_rate <- max(churn_by_contract$Churn_rate)

cat("Highest churn contract type: ", high_risk_contract, "(", high_risk_rate, ")")


#internet service risk
churn_by_internet
high_risk_internet <- churn_by_internet$InternetService[which.max(churn_by_internet$Churn_rate)]
high_risk_internet_rate <- max(churn_by_internet$Churn_rate)
cat("Highest churn internet service: ", high_risk_internet ,"(", high_risk_internet_rate, ")")


#payment method risk
churn_by_payment
high_risk_payment <- churn_by_payment$PaymentMethod[which.max(churn_by_payment$Churn_rate)]
high_risk_payment_rate <- max(churn_by_payment$Churn_rate)
cat("Highest churn payment method: ", high_risk_payment, "(", high_risk_payment_rate, ")")


##Tenure analysis
cat("Tenure Analysis: ")
tenure_quantiles <- quantile(telco_data$tenure, probs = c(0.25,0.5,0.75))
cat("Tenure quantiles: ")
cat("Q1:", tenure_quantiles[1], "months")
cat("Q2 (Median):", tenure_quantiles[2], "months")
cat("Q3:", tenure_quantiles[3], "months")
