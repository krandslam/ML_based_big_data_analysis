#현재 작업 폴더에 있는 모든 파일명 출력
list.files()

# 데이터 불러오기
review <- readLines("review.txt")
review

# 패키지 로딩
library(KoNLP)

# 사전 세팅
useNIADic()

# 명사추출
review_noun <- extractNoun(review)
review_noun

#1차원으로 변환
review_unlist <- unlist(review_noun)
review_unlist

# 각 단어별 빈도수를 세어봅시다!
review_cnt <- table(review_unlist)
review_cnt

# 빈도수 기준 내림차순 정렬해봅시다!
review_sort <- sort(review_cnt, decreasing = T)

#그래프(wordcloud)를 그려봅시다!
# 1. wordcloud를 그리는 패키지를 설치합니다.
install.packages("wordcloud2")

# 2. 패키지 설치 -> 로딩
library(wordcloud2)

wordcloud2(review_sort)
