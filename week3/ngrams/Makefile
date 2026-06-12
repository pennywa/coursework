# target to make the file report
all: 05_final_report.html  05_final_report.pdf
# discrepency? asking for pdf but why is it html here
# I'm just going to put both 

googlebooks-eng-all-1gram-20120701-1.gz: 01_download_1grams.sh # add filenames for data and/or code this output depends on here
	# add code to run script to download the 1grams data here
	./01_download_1grams.sh

year_counts.tsv: 02_filter_1grams.sh googlebooks-eng-all-1gram-20120701-1.gz # add filenames for data and/or code this output depends on here 
	# add code to run script to filter the 1grams data here
	./02_filter_1grams.sh

googlebooks-eng-all-totalcounts-20120701.txt: 03_download_totals.sh # add filenames for data and/or code this output depends on here
	# add code to run script to download the total counts data here
	./03_download_totals.sh

total_counts.csv: 04_reformat_totals.sh googlebooks-eng-all-totalcounts-20120701.txt # add filenames for data and/or code this output depends on here
	# add code to run script to reformat the total counts data here
	./04_reformat_totals.sh

05_final_report.html: 05_final_report.Rmd year_counts.tsv total_counts.csv # add filenames for data and/or code this output depends on here
	Rscript -e "rmarkdown::render('05_final_report.Rmd')"