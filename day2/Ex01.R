# 1. 파리연설문 내용을 불러와봅시다!
# 현재 폴더에 잘 저장되어 있는지 확인
list.files() #현재 작업 폴더에 있는 모든 파일명 출력
# 명령어 실행시키는 단축키는 ctrl + enter , 커서 명령어 위치

paris <- readLines("대통령파리연설.txt")
# readLines 함수는 txt 파일 읽어옴, 인자 = 파일명
# <- 저장 , paris: 변수

# 저장이 잘 되었는지 확인해봅시다.
paris

#paris를 분석해봅시다! (텍스트마이닝)
# 1. KoNLP 패키지, 라이브러리(기능을 담고 있는 보따리)

# 패키지 설치 -> 로딩
# 수동 설치 했음
library(KoNLP)

#사전 세팅!
useNIADic()
# 한국 정보화진흥원이 개발한 사전!
# 사전에 등록되지 않은 단어는 분석 불가 (띄어쓰기도 포함)

# 명사추출 paris_noun에 저장
paris_noun <- extractNoun(paris)
paris_noun

# 이상한 데이터는 전처리 해줘야됌 ex) 3번째 문장 "동포여러분을", 개인적으로 -> "개", "적"
# [[n]]: n 번째 문장의 [n]: n번째 단어
# 2차원 형태

#1차원으로 변환 (unlist 함수)
paris_unlist <- unlist(paris_noun)
paris_unlist

# 각 단어별 빈도수를 세어봅시다!
paris_cnt <- table(paris_unlist)
paris_cnt

# 빈도수 기준 내림차순 정렬해봅시다!
# 올림차순 sort(paris_cnt)
# T = true
paris_sort <- sort(paris_cnt, decreasing = T)

#그래프(wordcloud)를 그려봅시다!
# 1. wordcloud를 그리는 패키지를 설치합니다.
install.packages("wordcloud2")

# 2. 패키지 설치 -> 로딩
library(wordcloud2)

# 3. 그래프그리기!
# 우측에 plot 창에 생김
wordcloud2(paris_sort)
