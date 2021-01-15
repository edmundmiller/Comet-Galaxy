# Automated Genome Feature Discovery

## Overview

Automated Genome Feature Discovery is a s(CASP) program that searches for promoters, which identify regions of transcription, in a DNA sequence.

DNA sequences can be modeled as a string of characters consisting of 'A', T', 'C', and 'G'. Broadly speaking, a transcription region consists of a translation section, which is prefixed by a start codon (usually ATG) and suffixed by a stop codon (varies). Upstream of the translation section, there is typically one or more AT-rich sequences which aid in transcription.

Depicted below is a model transcription region where the character 'X' represents a wildcard and 'Y' represents the payload. In this example, there are two AT-rich sequences: one (the Pribnow box) appearing 10 characters before the translation section and another appearing 35 characters before the translation section. This structure is typical for bacteria.

![Promoter Example](/image/genome.png)

The AT-rich sequences rarely appear exactly as shown in the model. In fact, the model shows the most likely character for each position, but in reality each position is based on an observed probability distribution.

## Quick Start

```sh
git clone https://github.com/Emiller88/Comet-Galaxy.git
make
```

## Usage

1. Clone the git repository to your local machine.

```
git clone https://github.com/Emiller88/Comet-Galaxy.git
```

2. Run the `data_to_list.py` script to generate input for the s(CASP) program. (Note: You can supply your own genome by replacing raw_input2.txt with the file name of any local text file)

```
python data_to_list.py raw_input2.txt
```

3. Run the program!

```
scasp promoter.pl
```

## Output

![Example output](/image/sample.png)

## Design

The s(CASP) program is an implementation of rules for identifying promoters in DNA sequences. Our team first compiled these rules in common English as seen in [this document](https://docs.google.com/document/d/153i7ato675mp_b7ePRx1TM4wlDa5qI-FfYx4xTki2Gs/edit?usp=sharing). These English rules were then converted to s(CASP) code.
