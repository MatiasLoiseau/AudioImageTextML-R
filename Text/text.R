setwd("~/workspace/AudioImageTextML-R/Text")

library(tm)
library(wordcloud)

# Read the text from a file
raw_text <- readLines("i_have_a_dream.txt", encoding = "UTF-8")

# Create a Corpus from the vector of paragraphs
docs <- VCorpus(VectorSource(raw_text))

# Apply transformations:
# a) Convert to lowercase
docs <- tm_map(docs, content_transformer(tolower))

# b) Remove punctuation
docs <- tm_map(docs, removePunctuation)

# c) Remove numbers
docs <- tm_map(docs, removeNumbers)

# d) Remove extra white spaces
docs <- tm_map(docs, stripWhitespace)

# e) Remove stopwords (English stopwords)
docs <- tm_map(docs, removeWords, stopwords("english"))

# Display the word cloud and the most frequent word
# Create a term-document matrix (Document-Term Matrix)
dtm <- DocumentTermMatrix(docs)

# Calculate the frequency of each word
freq <- colSums(as.matrix(dtm))

# Sort by descending frequency
freq_sorted <- sort(freq, decreasing = TRUE)

# Most frequent word
most_frequent_word <- names(freq_sorted)[1]
cat("The most frequent word in the text is:", most_frequent_word, "\n")

# Display the word cloud
set.seed(123) # for reproducibility
wordcloud(names(freq), freq, min.freq = 2, colors = brewer.pal(8, "Dark2"), random.order = FALSE)

# Create the bag-of-words of the paragraphs
# The DTM is our bag-of-words, where:
# - Rows correspond to documents (paragraphs)
# - Columns correspond to terms (words)

dimensions <- dim(dtm)
cat("Number of rows (documents/paragraphs):", dimensions[1], "\n")
cat("Number of columns (terms):", dimensions[2], "\n")
