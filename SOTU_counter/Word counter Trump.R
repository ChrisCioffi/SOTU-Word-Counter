library(tidyverse)
library(tidytext)
library(tidyr)
#modified from tutorial http://yulijia.net/en/howto/r-language/2011/08/06/how-to-calculate-word-frequencies-with-r.html
sentences<-scan("trump_18.txt","character",sep="\n");
#Replace full stop and comma
#makes all letters lowercase
sentences <- tolower(sentences)
#removes all words shorter than 2 lengths
#Split sentence
words<-strsplit(sentences," ")

#below is from https://stackoverflow.com/questions/8898521/finding-2-3-word-phrases-using-r-tm-package on 2-3 word phrases. 

#this is also interesting. It finds instances where one word comes together. But can be easily changed to find two words. 



#Suppose I have a dataframe CommentData that contains comment column and I want to find occurrence of two words together. Then try
#builds data frame of sentences.
test <- data.frame(sentences)

one_bigram_filtered <- test %>%
  unnest_tokens(bigram, sentences, token= "ngrams", n=1) %>%
  separate(bigram, c("word1"), sep=" ") %>%
#  Removes stop words. Taking them out yields different results. In this case, leaving them seemed preferable.
# filter(!word1 %in% stop_words$word,
#         !word2 %in% stop_words$word,
#         !word3 %in% stop_words$word) %>%
  count(word1,sort=TRUE)
#changing n= value and adding in the corresponding "word#" will yield different lengths of phrases.
#The above code creates tokens, and then remove stop words that doesn't help in analysis(eg. the,an,to etc.) Then you count occurrence of these words. You will be then using unite function to combine individual words and record their occurrence.


#for two words 


bigram_filtered <- test %>%
  unnest_tokens(bigram, sentences, token= "ngrams", n=2) %>%
  separate(bigram, c("word1", "word2"), sep=" ") %>%
  #  Removes stop words (the, in, a, etc). Taking them out yields different results. In this case, leaving them in yielded more multiple phrase matches. 
#   filter(!word1 %in% stop_words$word,
#          !word2 %in% stop_words$word) %>%
  count(word1,word2, sort=TRUE)
#changing n= value and adding in the corresponding "word#" will yield different lengths of phrases.
#The above code creates tokens, and then remove stop words that doesn't help in analysis(eg. the,an,to etc.) Then you count occurrence of these words. You will be then using unite function to combine individual words and record their occurrence.

bigrams_united <- bigram_filtered %>%
  unite(bigram, word1, word2, sep=" ")
bigrams_united

#For three words

three_gram_filtered <- test %>%
  unnest_tokens(bigram, sentences, token= "ngrams", n=3) %>%
  separate(bigram, c("word1", "word2", "word3"), sep=" ") %>%
  #  Removes stop words (the, in, a, etc). Taking them out yields different results. In this case, leaving them in yielded more multiple phrase matches. 
#   filter(!word1 %in% stop_words$word,
#           !word2 %in% stop_words$word,
#           !word3 %in% stop_words$word) %>%
  count(word1, word2, word3, sort=TRUE)
#changing n= value and adding in the corresponding "word#" will yield different lengths of phrases.
#The above code creates tokens, and then remove stop words that doesn't help in analysis(eg. the,an,to etc.) Then you count occurrence of these words. You will be then using unite function to combine individual words and record their occurrence.

three_gram_united  <- three_gram_filtered %>%
  unite(bigram, word1, word2, word3, sep=" ")
bigrams_united
