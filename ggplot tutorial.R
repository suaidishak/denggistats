library(ggplot2)
library(ggthemes)
library(extrafont)

charts.data <- read.csv("data/copper_data_for_chapters_1_to_4.csv")


p1 <- ggplot() + geom_line(aes(y = export, x = year, colour = product),
                           data = charts.data, stat="identity")

p1 <- ggplot() + geom_line(aes(y = export, x = year, colour = product), size=1.5,
                           data = charts.data, stat="identity")

res2 <- as.data.frame(res[Collection_Type == "Sales" & Product_Name == "PRIMAX 97"])

res2$Data_Collection_Date <- as.factor(res2$Data_Collection_Date)
p2 <-  ggplot() + geom_line(aes(y = Sales_Stock_Count, x = Data_Collection_Date, colour = Product_Name), size=1.5,
                            data = res2)

p7 <- ggplot(res2, aes(x = State)) +
        geom_histogram(aes(y = ..density..)) +
p7
