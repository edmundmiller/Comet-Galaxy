import argparse

parser = argparse.ArgumentParser(description="Convert raw text input to s(CASP) list.")
parser.add_argument("fileName", help="Input file name", metavar="NAME", nargs=1)
args = parser.parse_args()
file_name = args.fileName[0]

with open(file_name, "r") as in_file:
    in_str = in_file.read()
    in_str = in_str.lower()
    in_str = in_str.replace("\n", "")
    in_str = in_str.replace("\r", "")
    in_str = in_str.replace(" ", "")
    in_list = list(in_str)

with open("list_input.pl", "w") as out_file:
    out_file.write("sequence(")
    out_file.write(in_list.__str__())
    out_file.write(").")
