The goal of this excercise is to analyze further generalized and bigger sized texts (more than 20000 lines) rather than formal and short texts like speech.  
Web crawled movie review data(review.txt) is used here to analyze.  

Ex02.R analyzes the data without data preprocessing.  
The generated word cloud follow below.

Original word cloud
-------------
![wordcloud_review_ori](./wordcloud_review_original.JPG)

Since the text contained a wide variety of words, word cloud did not clearly show the frequency distribution of the words.
So, the data preprocessing procedure was needed.  
1. used gsub function to delete the meaningless words(typo, special character) or united synonyms into one word (fun, interesting, enjoy -> fun)  
2. registerd a word in dictionary with mergeUserDic such as name of character in movie Fumiko, 후미코 in Korean.
3. deleted a word that has too short or long length (characteristics of Korean)  

The result of word cloud after 3 steps above follows below.  

Word cloud after 3 steps
----------
![wordcloud_review_freqg5](./wordcloud_review_freqg5.JPG)

