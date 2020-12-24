# 1. 필요한 패키지 (함수들을 담고 있는 보따리) 로딩
# 패키지 설치는 최초 1번만 해도 됌! 로딩은 studio 켤때마다 진행
library(KoNLP)
library(wordcloud2)

# 2. 데이터 불러오기
list.files() # 현재 폴더안의 모든 파일 출력

review <- readLines("review.txt")
review

# 3. 명사추출

#사전 세팅!
useNIADic()
review_noun <- extractNoun(review)
review_noun

# 4. 1차원 벡터로 변경!
review_unlist <- unlist(review_noun)
review_unlist

# 5. 단어별 빈도수 계산하기
review_cnt <- table(review_unlist)
review_cnt

# 6. 정렬해서 확인해보기!
review_sort <- sort(review_cnt, decreasing = T)
review_sort

# 필요없는 단어의 기준!!!
# 1. 10회 이하로 나온 단어
# 2. 조사들 (은, 는, 이, 가) => 한글자 이하 단어들
# 3. 다섯글자 이상의 단어들
# 4. 재밌었어요 => 재미
# 5. 자음,모음만 있는 것들 (ㅋㅋㅋㅋ ㅠㅠㅠ)

# 필요한 단어 (사전에 등록해줘야 하는 단어!!!)
# 후미코(등장인물)

# Text전처리
# 필요없는 단어는 언제 지워야할까요?
# => 다음 빈도수 계산하기 전에! 단어 지우고 나서 빈도수를 다시 계산해주어야 합니다!

# 2. 한글자 이하 단어들 삭제해봅시다.
# nchar(): 문자열 길이
review_unlist <- review_unlist[nchar(review_unlist) > 1]
review_unlist

# 3. 다섯글자 이상의 단어들 삭제
review_unlist <- review_unlist[nchar(review_unlist) < 5]
review_unlist

# 4. 재미있었, 재밋어요, 재밌었고 => 재밌음
review_unlist <- gsub("재미있었", "재밌음", review_unlist)
review_unlist <- gsub("재밌네요", "재밌음", review_unlist)
review_unlist <- gsub("재밌었어", "재밌음", review_unlist)
review_unlist <- gsub("재밌어요", "재밌음", review_unlist)
review_unlist <- gsub("재밌다", "재밌음", review_unlist)
review_unlist <- gsub("재밌었고", "재밌음", review_unlist)
review_unlist <- gsub("재밌었던", "재밌음", review_unlist)
review_unlist <- gsub("재밌네", "재밌음", review_unlist)
review_unlist <- gsub("재밌었다", "재밌음", review_unlist)
review_unlist <- gsub("재밌는데", "재밌음", review_unlist)
review_unlist <- gsub("재밌게", "재밌음", review_unlist)
review_unlist <- gsub("재밌고", "재밌음", review_unlist)
review_unlist <- gsub("재밌", "재밌음", review_unlist)
review_unlist <- gsub("재밌음음", "재밌음", review_unlist)
review_unlist <- gsub("해서", "", review_unlist)
review_unlist <- gsub("하지", "", review_unlist)
review_unlist <- gsub("들이", "", review_unlist)

# 일정한 패턴이 있는 경우 제거!
# 모든 자음, 모든 모음, 모든 숫자, 모든 영어, 특수문자
review_unlist <- gsub("[ㄱ-ㅎ]","",review_unlist)
review_unlist <- gsub("[ㅏ-ㅣ]","",review_unlist)
review_unlist <- gsub("[0-9]","",review_unlist)
review_unlist <- gsub("[A-z]","",review_unlist)
review_unlist <- gsub("[!-/]","",review_unlist)

# 사전에 신규단어 등록해보기! (후미코) ncn: 명사
mergeUserDic(data.frame(c("후미코"), c("ncn")))

# 5. 단어별 빈도수 계산하기
review_cnt <- table(review_unlist)

#그래프(wordcloud)를 그려봅시다!
install.packages("wordcloud2")
library(wordcloud2)

# 빈도수 5 이하는 날려버립시다!!!!!!!
review_cnt <- review_cnt[review_cnt > 5]

review_sort <- sort(review_cnt, decreasing = T)
review_sort

#top 50 보는 방법!
review_top50 <- head(review_sort,50)
review_top50

wordcloud2(review_sort)
wordcloud2(review_top50)

