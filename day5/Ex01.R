# 사과 품종 예측해보기기
apple <- read.csv("apple.csv")
apple

# 데이터 파악하기!!!
dim(apple)
names(apple) #속성명 파악해보기
str(apple) # 컬럼 타입 숫자 / 문자 Factor: 범주형
summary(apple) # 컬럼별 통계량

# 1. 품종별 평균 weight?
install.packages("dplyr")
library(dplyr)
apple %>% group_by(model) %>% summarise(mean_w = mean(weight)) %>% 
  arrange(desc(mean_w))

# weight: 미 > 로 > 홍로 > 아 > 홍옥 
# => 400 가까이 = 미시마, 로얄후지 / 300 가까이: 홍로, 아오리 / 300 미만: 홍옥

#2.  품종별 평균 당도
# => 15이상 미시마 / 14 가까이: 홍로, 로얄후지 / 13 가까이: 아오리, 홍옥

apple %>% group_by(model) %>% summarise(mean_s = mean(sugar)) %>% 
  arrange(desc(mean_s))

#3. 품종별 평균 산도
# => 0.6이상 홍옥 / 0.4 가까이 로얄후지, 미시마 / 0.3 가까이: 아오리, 홍로
apple %>% group_by(model) %>% summarise(mean_a = mean(acid)) %>% 
  arrange(desc(mean_a))

# 미시마: 무게 400 당도 15 산도 0.4 홍
# 로얄후지: 무게 400 당도 14 산도 0.4 적
# 홍로: 무게 300 당도 14 산도 0.3 홍
# 아오리: 무게 300 당도 13 산도 0.3 홍
# 홍옥: 무게 300미만 당도 13 산도 0.6이상 적

#품종별 색깔이 몇개씩 있는지
apple %>% group_by(model,color) %>% summarise(n=n())

# 사과 품종별 특징을 분석하여 품종을 예측하는 분류모델을 만들어 봅시다
# 사람이 하기 힘드니까 컴퓨터를 이용

# 머신러닝 과정중
# 1. 문제정의
# 2. 데이터 수집 (apple, Filedata)
# 3. 데이터 전처리
# 4. 탐색적 데이터 분석 (EDA) ->  4개의 특징(x)가 품종(y)에 영향을 미치는가? yes

# 5. 모델 선정 (decision tree)
# 6. 학습
# 7. 평가

# 사과 데이터 학습시키기
# 1. train과 test data 나누기

install.packages("caret") # 데이터를 랜덤으로 분할해주는 패키지
library(caret)

#인자: 기준, 몇퍼센트, 1차원: F
train_index <- createDataPartition(apple$model,p = 0.8, list = F)
train_index

# 인덱스를 기준으로 train 데이터와 test 데이터 나누기
apple_train <- apple[train_index,] # train_index에 해당하는 행 추출
apple_test <- apple[-train_index,] # train 제외 나머지

table(apple_train$model)


# 2. 분류 모델 만들기!!
install.packages("rpart")
library(rpart)
# 인자: 예측하려는거~. => 모든 y를 고려한 x , train data, control: hyperparameter (양 옆 쪼개지는거)
apple_rpart_result <- rpart(model~., data = apple_train, control = rpart.control(minsplit = 2))
apple_rpart_result

# 3. 분류 모델 시각화
install.packages("rpart.plot")
library(rpart.plot)
rpart.plot(apple_rpart_result, cex = 0.7)

# 4. 예측하기
# type: 분류모델

plotcp(apple_rpart_result) # 적절한 트리 개수 => cp 찾기
apple_result_tree <- prune(apple_rpart_result, cp = 0.018) #가지치기
expect <- predict(apple_result_tree, apple_test, type="class") # 예측

actual <- apple_test$model

# 5. 평가하기 -> kappa 계수
install.packages("e1071")
library(e1071)
confusionMatrix(actual, expect, mode = "everything")
  
