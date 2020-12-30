#1. hflights 패키지 설치
install.packages("hflights")
#2. hflights패키지 로딩
library(hflights)

# 데이터 파악 단계
#3. 총 데이터의 개수와 속성이 몇개인지 출력해보기!
dim(hflights)

# 결항/미결항 각각의 건수를 출력해봅시다.
table(hflights$Cancelled)

# 5.결항 사유 별 몇건일까?
table(hflights$CancellationCode)

# 데이터 추출하기
# 1. 11월 데이터만 추출해봅시다

install.packages("dplyr")
library(dplyr)
hflights %>% filter(Month == 11)

# 2. 11월 6일 데이터만 추출해봅시다!
names(hflights) # 컬럼명
hflights %>% filter(Month == 11) %>% filter(DayofMonth == 6)

# 3. 11월(Month) 6일(DayofMonth) 데이터에 대해
#월(Month),일(DayofMonth),출발시간(DepTime),출발지(Origin),도착지(Dest)만 출력하세요

hflights %>% filter(Month == 11) %>% filter(DayofMonth == 6) %>% 
  select(Month, DayofMonth, DepTime, Origin, Dest)

# 4. 11월(Month) 6일(DayofMonth) 데이터에 대해 출발시간(DepTime)기준 오름차순 정렬하여
# 월(Month),일(DayofMonth),출발시간(DepTime),출발지(Origin),도착지(Dest)만 출력하세요.

hflights %>% filter(Month == 11) %>% filter(DayofMonth == 6) %>% 
  select(Month, DayofMonth, DepTime, Origin, Dest) %>% 
  arrange(DepTime)

# 5. 결항사유(CancellationCode) 별 데이터의 개수를 출력하세요.
table(hflights$CancellationCode)


# 6. 결항사유(CancellationCode)가 B(날씨)인 데이터만 출력하시오.
hflights %>% filter(CancellationCode == "B")

# 8.비행기 고유번호 (TailNum)별 평균 비행거리(Distance)를 출력하세요
names(hflights)
hflights %>% group_by(TailNum) %>% summarise(mean_D = mean(Distance))

# 9.비행기 고유번호 (TailNum)별 평균 비행거리(Distance)를 계산하여
# 평균비행거리 기준 내림차순 정렬하여 상위 20개의 데이터만 출력하세요.
hflights %>% group_by(TailNum) %>% summarise(mean_D = mean(Distance)) %>% 
  arrange(desc(mean_D)) %>% head(20)

# 10. 월(Month)별 결항(Cancelled)건수를 세어 보세요!
hflights %>% filter(Cancelled == 1) %>% group_by(Month) %>% summarise(n = n())

# 몇월 몇일의 결항 건수가 가장 많았을까?
hflights %>% group_by(Month,DayofMonth) %>% summarise(n = n())

# 월별, 일별 결항건수를 세어서 결항건수 기준으로 내림차순 정렬
# 몇월 몇일에 가장 결항건수가 많았는지
hflights %>% filter(Cancelled == 1) %>% group_by(Month,DayofMonth) %>% summarise(n = n()) %>% 
  arrange(desc(n))
