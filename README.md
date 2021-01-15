# Genome Analyzer

## Usage

1. Clone the git repository to your local machine.
```
git clone https://github.com/Emiller88/Comet-Galaxy.git
```

2. Run the `data_to_list.py` script to generate input for the s(CASP) program. (Note: You can supply your own genome by replacing raw_input2.txt with the file name of any local text file)
```
python data_to_list.py raw_input2.txt
```

3. Run the analyzer!
```
scasp promoter.pl
```

## Output

![Example output](/image/sample.png)
