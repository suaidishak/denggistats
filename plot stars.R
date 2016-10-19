res$Station_Region <- factor(res$Station_Region)
res$Product_Name <- factor(res$Product_Name)
res$Collection_Type <- res$Collection_Type
res$State <- factor(res$State)
res$City <- factor(res$City)
res$Postcode <- factor(res$Postcode)
res$Data_Collection_Date <- factor(res$Data_Collection_Date)


qplot(mpg, data=mtcars, geom="density", fill=gear, alpha=I(.5), 
      main="Distribution of Gas Milage", xlab="Miles Per Gallon", 
      ylab="Density")

qplot(Data_Collection_Date, data = res[Collection_Type == "Sales"], geom = "density", fill = Sales_Stock_Count, colour = Product_Name,alpha =I(0.1),
      main = "Sales of STARS", xlab = "Date", ylab = "Sales")

qplot(x=Data_Collection_Date, y=Sales_Stock_Count ,data = res, geom = "density", fill = Product_Name, alpha =I(0.1),
      main = "Sales of STARS", xlab = "Date", ylab = "Sales")

qplot(x=Station_Region, y=log(sum(Sales_Stock_Count)),data= res[Collection_Type=="Sales"],
      geom = "density",
      color = Station_Region)

qplot(Product_Name,V1, data = res1,geom = "boxplot",fill= Station_Region)
