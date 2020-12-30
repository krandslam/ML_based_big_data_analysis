# 지금부터는 정형데이터 전처리 방법에 대하여 배워보겠습니다!

# csv_exam.csv 파일을 프로젝트 폴더에 넣어줍니다!
# 아이콘은 엑셀인데 확장자는 csv???
# csv =>  comma seperated values 
# 쉼표로 구분되어 있는 텍스트 형태의 데이터!
# 파일 전송, 분석용 데이터로 많이 제공

list.files()
exam <- read.csv("csv_exam.csv")
exam

# 정형데이터 살펴보기!
# 각 컬럼 (열) 별 요약 통계량 산출
# summary-> min: 최소 / max: 최대 / 1st Q: 하위 25% / median: 중앙 / mean: 평균 3 / 3rd Q: 75%
# 2. 최빈값 (많이 등장하는 값)
# 3. 표준편차(평균에 대한 신뢰도), 분산 (평균으로부터 얼마나 떨어져 있는지)
# ex) A반 성적 5,6,5,6,5,6 -> 원값 - 데이터 -0.5, 0.5,-0.5, 0.5, -0.5, 0.5 -> (원값 - 데이터)^2의 평균 = 분산 -> 루트(분산) = 표준편차
# B반 성적 1,10,1,10,1,10 -> 원값 - 데이터 -4.5, 4.5, -4.5, 4.5, -4.5, 4.5 -> 
# A반 표준편차 0.5 -> 평균 +- 표준편차 (범위)
# B반 표준편차 4.5
summary(exam)

# 데이터 전처리 및 분석을 위해 dplyr 패키지 설치
install.packages("dplyr") #문자열 매칭
library(dplyr) # 설치하면 변수 

# 컴퓨터가 다룰 수 있는 데이터 형태(타입) -> 문자 vs 숫자
a <- 123 # 숫자 123
b <- a

c <- "a" #문자열 a

# 조건에 맞는 데이터만 추출하는 함수 -> filter
# 수학 점수가 70점 이상인 학생을 뽑아봅시다

exam %>% filter (math >= 70)

# 과학 점수가 80점 미만인 학생들

exam %>% filter (science < 80)

# 과학점수와 수학점수 모두 80점이 넘는 학생들

exam %>% filter (math > 80) %>% filter (science > 80)
exam %>% filter (math > 80 & science > 80)
exam %>% filter (math > 80 , science > 80)

# 1반인 학생들

exam %>% filter (class == 1)

# 3반이 아닌 학생들
exam %>% filter (class != 3)

# 수학점수가 60점 이상 70점 미만인 학생들
exam %>% filter (math >= 60 & math < 70)

# 1반이거나 2반이거나 4반인 학생들
exam %>% filter (class == 1 | class == 2 | class == 4)

exam %>% filter (class != 3, class != 5)

# 교집합 연산 / c: combine, %in%: 해당하는거 선택
exam %>% filter (class %in% c(1,2,4)) 

# mpg 자동차 정보에 대한 데이터가 있습니다
# 실습을 진행해봅시다

library(ggplot2)
# ggplot2란? => 데이터 시각화를 위한 패키지
# 이 패키지에 포함되어 있는 mpg 데이터를 가지고 실습을 진행

mpg

# 데이터 파악하기
# 1. 갯수 파악하기
dim(mpg)

# 234대 자동차 11개 속성 조사
#데이터 열이란? 여러대의 자료 조사했다 (표본이 많다)
# 행이란? 한대의 차에 대해 많은 속성을 조사했다

# 2. 속성별 자료형(숫자, 문자) 파악하기
str(mpg)
# num: 정수 + 실수

# 3. 속성별 통계량 파악하기
summary(mpg)

# 3-1 str data -> count freq
table(mpg$manufacturer) # mpg data's manf cnt 

# 자동차 배기량(displ)에 따라 고속도로 연비(hwy) 다른지 알아봅니다!

# 1. 배기량(displ)이 4 이하인 자동차, 배기량이 5이상인 자동차 각각 출력
displ_4 <- mpg %>% filter(displ <= 4)
displ_5 <- mpg %>% filter(displ >= 5)

# 2. 평균 hwy
mean(displ_4$hwy)
mean(displ_5$hwy)

#결론 배기량이 4 이하인 자동차가 5이상인 자동차보다 연비가 더 높습니다!

# 현대 vs 쉐보레 평균 (cty)
hy <- mpg %>% filter(manufacturer == "hyundai")
ch <- mpg %>% filter(manufacturer == "chevrolet")

mean(hy$cty)
mean(ch$cty)

# 일제 차량의 평균 cty를 계산해봅시다

table(mpg$manufacturer)

jp <- mpg %>% filter(manufacturer == "honda" | manufacturer == "nissan" | manufacturer == "subaru" | manufacturer == "toyota ")
mean(jp$cty)

# 원하는 속성만 추출하기 => select
# class의 english 속성만 출력하기
exam %>% select(class, english)

# 전체 학생의 성적중에서
# 영어 점수가 80점 이상인 학생들의 ID와 class 출력

exam %>% filter(english >= 80) %>% select(id,class)

# 해당 속성 제외하는법
exam %>% select(-science)

# 3. 데이터 정렬하기!
# sort => 1차원 데이터 (기준이 없을때)
# 수학점수 기준 => arrange

exam %>% arrange(math)

exam %>% arrange(desc(math))

# 1반, 3반, 5반 학생중에서
# 수학 점수가 60점 넘는 학생들의
# id, math 점수만 출력
# 수학 점수 기준 내림차순 정렬해서 출력

exam %>% filter(class == 1 | class == 3 | class == 5) %>%
filter(math > 60) %>%
select(id, math) %>% 
arrange(desc(math))

# arrange 정렬 시 기준 2개이상 줄 수 있음
# 1. 반별 2. math 점수 순
exam %>% arrange(class,desc(math))

# 학생별 평균 점수를 추가해보기!
exam <- exam %>% mutate(avg = (math + english + science)/3)
exam

#학생 별로 전교생의 평균보다 높으면 PASS, 낮으면 fail 부여하는 속성

# 전교생의 평균?

mean(exam$avg)
exam <- exam %>% mutate(PF = ifelse(avg >= mean(avg),"pass","fail"))

# pass, fail 몇명이나 있는지 확인
table(exam$PF)

# A/B/C 등급으로 나눠보자!

summary(exam)
# 73점 이상 => A등급, 63점 이상 => b등급, 나머지 => C등급

exam <- exam %>% mutate(level = ifelse(avg >= 73, "A", ifelse(avg >= 63,"B","C")))
table(exam$level)
exam %>% arrange(level)

exam

# 그룹별로 묶어준 후 통계량 산출
# 1. 반별 수학점수 평균표 생성

exam %>% group_by(class) %>% summarise(mean_math = mean(math))

# 2. 반별 평균표 생성!

exam %>% group_by(class) %>% summarise(mean_avg = mean(avg))

# 3. 반별 평균표를 평균 기준 내림차순 정렬!

exam %>% group_by(class) %>% summarise(mean_avg = mean(avg)) %>% arrange(desc(mean_avg))

# 4. 반별로 수학, 영어, 과학이 전부 표기된 평균표를 만들고 싶어요

exam %>% group_by(class) %>% 
  summarise(mean_math = mean(math), mean_eng = mean(english), mean_sci = mean(science))

# 5. 등급별 최소 평균점수표 산출

exam %>% group_by(level) %>% summarise(min_avg = min(avg))

exam
