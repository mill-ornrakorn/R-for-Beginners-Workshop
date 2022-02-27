#===============================================================
#                R for Beginners Workshop
#===============================================================
# SPEAKER : Dr. Kejkaew Thanasuan
# DATE    : 16 June 2020, 9:00 a.m. - 12:30 p.m.
# BY      : Ornrakorn Mekchaiporn
#===============================================================


##=====================##
## Basic R programming ##
##=====================##

# การกำหนดตัวแปรสามารถใช้ <-, = ได้

3+2
5*9
6-6

# ==== vector ====
# ** ใน R เริ่มนับจากเลข 1 นะ **

x <- c(1,2,4)
x

q <- c(x,x,8)
q

q[1:4]    # แสดงตัวที่ 1 ถึง 4
q[-2]     # ลบตำแหน่งที่ 2 ออกไปจากการแสดงผล
q[-1:-4]  # ลบตัวที่ 1 ถึง 3 ออกไปจากการแสดงผล
q[c(2,5)] # เลือกเฉพาะตัวที่ 2 และ 5


##============##
## Activity 1 ##
##============##

# 1. จงประกาศตัวแปร Vector ที่มีสมาชิกดังนี้ 5,8,9,7,10
a <- c(5,8,9,7,10)
a

# 2.เก็บสมาชิกตัวที่ 2 ของตัวแปร Vector ในข้อแรกไว้ ในตัวแปรที่ชื่อว่าy
b <- a[2]
b


# -- adding vector --
d <- c(88,5,12,13)
d
d <- c(d[1:3], 168,d[4]) # เพิ่ม 168 ไป
d

# -- deleting vector --
d_new <- d[-4]
d_new


# -- Calling functions --
# functions ส่วนใหญ่ใน R ไม่ต้องทำวนลูปในการใช้
y <- mean(x)
y

y1 <- sd(x)
y1


# ==== Data Frames ====
name <- c("Jack","Jill")
age <- c(12,10)
df <- data.frame(name,age)
df

df[[1]]  # แสดง Column ที่ 1
df$name  # แสดง Column ชื่อ name
df[,1]   # เลือกทุกตัวของ Column ที่ 1

str(df)  # แสดงข้อมูลของ Data Frames


# -- Example: mtcars -- 
# (data อันนี้มีอยู่แล้วใน R)
head(mtcars)  # แสดงข้อมูล 6 ตัวแรก


# หา ratio ระหว่าง horsepower(hp) กับ Number of cylinders(cyl)
mtcars$ratio =  mtcars$hp / mtcars$cyl
head(mtcars) # ratio ที่ได้จะแสดงเป็น Column ใหม่เลย


# หากต้องการลบ Column ratio
mtcars$ratio = NULL
head(mtcars) # Column ratio จะหายไปแล้ว

# เพิ่ม row โดยใช้ rbind
# tail คือดูข้อมูล 6 ตัวสุดท้าย
tail(rbind(mtcars, list(99,10,200,999,9,9,99,1,1,9,9)))
# ปล. ตัวที่เราเพิ่มยังไม่ได้ตั้งชื่อจึงแสดงเป็นลำดับมาแทน


##============##
## Activity 2 ##
##============##

# อ่าน file: car_ ad 1.csv โดยใช้คำสั่งต่อไปนี้ data <- read.csv("car_ad_1.csv")
# หาราคาเฉลี่ยของรถทั้งหมดโดยใช้ mean function

car_ad_data  <- read.csv('Data/car_ad_1.csv')
head(car_ad_data )

mean(car_ad_data $price)


##=======================##
## Data wrangling: dplyr ##
##=======================##

# dplyr เป็น package ที่ช่วยในการจัดการข้อมูล

# install.packages('dplyr')

library(dplyr)

load('Data/storms.rdata')
load('Data/cases.rdata')
load('Data/pollution.rdata')


# ---- select ---- 
# %>% เป็น pipe operator ที่ช่วยให้สามารถเชื่อมต่อเนื่องกันได้ระหว่างData
# ใน windows มี short cut  คือ ctrl + shift + m

# เลือก column storm และ pressure
# -แบบที่ 1
select(storms, storm, pressure)      

# -แบบที่ 2 -- จะดูง่ายกว่าแบบที่ 1 
storms %>% select(storm, pressure)   # เขียนโดยเอา data set มาไว้ข้างหน้า แล้วเชื่อมด้วย %>%


# การ deselect 
select(storms, -storm) # ไม่แสดง storm

# select เป็น range
select(storms, wind:date) # เลือก wind ถึง date


# ---- filter ---- 

# เลือก wind >= 50
# -แบบที่ 1
filter(storms, wind >= 50)

# -แบบที่ 2 -- จะดูง่ายกว่าแบบที่ 1
storms %>% filter(wind >= 50)


# เลือก wind >= 50 และ ชื่อstor storm ต้องอยู่ในกลุ่มนี้เท่านั้น
filter(storms, wind >= 50, 
       storm %in% c("Alberto", "Alex", "Allison"))


# ---- summarise ---- 

head(pollution)

# สรุป median และ variance ของ amount
pollution %>% summarise(median = median(amount), variance = var(amount))

# สรุป mean, sum และ n ของ amount
pollution %>% summarise(mean = mean(amount), sum = sum(amount), n = n())


##============##
## Activity 3 ##
##============##

# Filter ข้อมูล car-ad โดยเลือกเฉพาะรถ BMW ที่ผลิตในปี 2016
head(car_ad_data)
BMW.2016 <- car_ad_data  %>% filter(car == 'BMW', year == 2016)
BMW.2016 


##=======================##
##    Unit of Analysis   ##
##=======================##


# -- group_by() --  

pollution %>% group_by(city)

# -- group_by() + summarise() --  
pollution %>% group_by(city) %>%
  summarise(mean = mean(amount), sum = sum(amount), n = n())

pollution %>% group_by(city) %>% summarise(mean = mean(amount))

pollution %>% group_by(size) %>% summarise(mean = mean(amount))


##============##
## Activity 4 ##
##============##

# จับกลุ่มข้อมูล car-ad ตาม car brand และสรุปว่ารถแต่ละ brand มีราคาเฉลี่ยเท่าไร

Carbrand_price <- car_ad_data %>% group_by(car) %>% summarise(price_mean = mean(price), n =n())
Carbrand_price 

##=======================##
##       Base Plot       ##
##=======================##
# Base Plot เป็นสิ่งที่มากับตัว R อยู่แล้ว

# -- hist() --  รูปแบบ hist(x, breaks)
hist(car_ad_data$price, breaks = 100)

# -- plot() --  รูปแบบ plot(x, y)
BMW <- car_ad_data %>% filter(car == "BMW")
plot(BMW$price,BMW$mileage) # mileage คือ ระยะที่รถได้วิ่งมาแล้ว จากกราฟมองได้ว่ายิ่งวิ่งมาเยอะ ราคาก็จะลง
                       

# -- points() --  รูปแบบ points(x, y, ...)
# ต้องการเปรียบเทียบระหว่างprice, mileage ของ BMW กับ Toyota
# ใช้ points()
BMW <- car_ad_data   %>% filter(car == "BMW")
plot(BMW$price,BMW$mileage)

Toyota <- car_ad_data  %>%  filter(car == "Toyota")
points(Toyota$price,Toyota$mileage, col=2, pch = 15) # col=2 คือ สีแดง ส่วน pch = 15 คือ สี่เหลี่ยมทึบ


# -- plot line graph --  รูปแบบ plot(..., type="b") กำหนด b เพราะ ให้เป็น Line

# ต้องการดู ราคาBMW ของแต่ละปี
BMW.year <- car_ad_data %>%  
  filter(car == "BMW") %>%  
  group_by(year) %>%  
  summarise (m.price = mean (price))
plot(BMW.year, type="b" )



# ลองเพิ่ม Toyota เพื่อต้องการดูราคา Toyota แต่ละปี

BMW.year <- car_ad_data %>%  
  filter(car == "BMW") %>%  
  group_by(year) %>%  
  summarise (m.price = mean (price))
plot(BMW.year,type="b", xlim = c(1979,2016))  
  # xlim = c(1979,2016) set limit ของ x เริ่มปี 1979 ถึง 2016
  # กำหนดเพราะเนื่องจาก Toyota มีข้อมูลตั้งแต่ 1979 แต่ BMW มีข้อมูลตั้งแต่ 1984 จึงต้องมีการ set limit ของ x

Toyota.year <- car_ad_data %>%  
  filter(car == "Toyota") %>%  
  group_by(year) %>%  
  summarise (m.price = mean(price))
points(Toyota.year,type="b", col=2, pch =15) # col=2 คือ สีแดง ส่วน pch = 15 คือ สี่เหลี่ยมทึบ


##============##
## Activity 5 ##
##============##

# ให้ plot ราคารถเฉลี่ยของ Toyota และ Honda ตั้งแต่ปี2006 - 2016

Honda <- car_ad_data %>%
  filter(car == 'Honda', year >= 2006) %>%
  group_by(year)  %>%
  summarise(m.price = mean(price))

Toyota <- car_ad_data %>%
  filter(car == 'Toyota', year >= 2006) %>%
  group_by(year)  %>%
  summarise(m.price = mean(price))


plot(Honda,type="b", ylim = c(11000,66000))
points(Toyota, type="b", col=2, pch = 16)


