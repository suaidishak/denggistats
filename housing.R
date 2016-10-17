housing <- read.csv("data/landdata-states-2016q1.csv",stringsAsFactors = F)
head(housing[1:5])

housing$Year <- as.numeric(substr(housing$Date, 1, 4))
housing$Qrtr <- as.numeric(substr(housing$Date, 6, 6))
housing$Date <- housing$Year + housing$Qrtr/4


ggplot(housing, aes(x=Home.Value)) + geom_histogram()

plot(Home.Value ~ Date,
     data=subset(housing, STATE == "MA"))
points(Home.Value ~ Date, col="red",
       data=subset(housing, STATE == "TX"))
legend(19750, 400000,
       c("MA", "TX"), title="State",
       col=c("black", "red"),
       pch=c(1, 1))

ggplot(subset(housing, STATE %in% c("MA", "TX")),
       aes(x=Date,
           y=Home.Value,
           color=STATE))+
        geom_point()
hp2001Q1 <- subset(housing, Date == 2001.25) 

ggplot(hp2001Q1,
       aes(y = Structure.Cost, x = Land.Value)) +
        geom_point()

ggplot(hp2001Q1,
       aes(y = Structure.Cost, x = log(Land.Value))) +
        geom_point()

hp2001Q1$pred.SC <- predict(lm(Structure.Cost ~ log(Land.Value), data = hp2001Q1))

p1 <- ggplot(hp2001Q1, aes(x = log(Land.Value), y = Structure.Cost))

p1 + geom_point(aes(color = Home.Value)) +
        geom_line(aes(y = pred.SC))

p1 +
        geom_point(aes(color = Home.Value)) +
        geom_smooth()

p1 + 
        geom_text(aes(label=STATE), size = 3)

## install.packages("ggrepel") 
library("ggrepel")
p1 + 
        geom_point() + 
        geom_text_repel(aes(label=STATE), size = 3)

p5 <- ggplot(housing, aes(x = Date, y = Home.Value))
p5 + geom_line(aes(color = STATE))

p5 + geom_line() +
                facet_wrap(~STATE, ncol = 10)

p5 + theme_linedraw()

p5 + theme_light()

p5 + theme_minimal() +
        theme(text = element_text(color = "red"))

theme_new <- theme_bw() +
        theme(plot.background = element_rect(size = 1, color = "blue", fill = "black"),
              text=element_text(size = 12, family = "Serif", color = "ivory"),
              axis.text.y = element_text(colour = "purple"),
              axis.text.x = element_text(colour = "red"),
              panel.background = element_rect(fill = "pink"),
              strip.background = element_rect(fill = muted("orange")))

p5 + theme_new

housing.byyear <- aggregate(cbind(Home.Value, Land.Value) ~ Date, data = housing, mean)
ggplot(housing.byyear,
       aes(x=Date)) +
        geom_line(aes(y=Home.Value), color="red") +
        geom_line(aes(y=Land.Value), color="blue")

library(tidyr)
home.land.byyear <- gather(housing.byyear,
                           value = "value",
                           key = "type",
                           Home.Value, Land.Value)
ggplot(home.land.byyear,
       aes(x=Date,
           y=value,
           color=type)) +
        geom_line()

