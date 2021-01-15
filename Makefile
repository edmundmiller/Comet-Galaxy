promoter: list_input.pl
	scasp promoter.pl

list_input.pl:
	python data_to_list.py raw_input2.txt
	# python data_to_list.py NC_010473.fa