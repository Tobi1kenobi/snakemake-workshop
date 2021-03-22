words.file <- snakemake@input[["only_words"]]
out.file <- snakemake@output[["barplot"]]

# Read in words list, get frequency table
words.df <- read.table(words.file)
words.counts <- table(words.df)

# Make bar plot and save to plots folder
png(out.file, width = 500, height = 500)
barplot(words.counts)
dev.off()