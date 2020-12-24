The goal of this excercise is to analyze further generalized and bigger sized texts (more than 20000 lines) rather than formal and short texts like speech. Web crawled movie review data(review.txt) is used here to analyze.  

Ex02.R analyzes the data without data preprocessing.  
The generated word cloud follow below.

Original word cloud
-------------
![wordcloud_review_ori](./wordcloud_review_original.JPG)

Since the text contained a wide variety of words, word cloud did not clearly show the frequency distribution of the words.  
So, the data preprocessing procedure was needed.  
1. used gsub function to delete the meaningless words(typo, special character) or to unite synonyms into one word (fun, interesting, enjoy -> fun)  
2. registerd a word in dictionary with mergeUserDic such as name of character in movie Fumiko, 후미코 in Korean.
3. deleted a word that has too short or long length (characteristics of Korean)  

The code work is at Ex03.R  
The result of word cloud after 3 steps above follows below.  

Word cloud after 3 steps
----------
![wordcloud_review_freqg5](./wordcloud_review_freqg5.JPG)

Still, some words that had low frequency of usage were hard to identify.  
Therefore, another data preprocessing procedure was needed.  
The procedure used head function to sort top 50 words.  
The result follows below.  

Top 50 word cloud
-------------
![wordcloud_review_top50](./wordcloud_review_top50.JPG)
