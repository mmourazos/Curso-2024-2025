import argparse
from math import log

parser = argparse.ArgumentParser(
    prog="get_log_dataset",
    description="Generates a dataset with the log values desplaced by x and y",
)
parser.add_argument(
    "-i", "--init", type=int, default=1, help="Initial value of the dataset"
)
parser.add_argument(
    "-d", "--end", type=int, default=100, help="End value of the dataset"
)
parser.add_argument("-s", "--step", type=int, default=10, help="Step of the x values")
parser.add_argument(
    "-dx", "--desp_x", type=int, default=0, help="Value to desplace the log rightwards"
)
parser.add_argument(
    "-dy",
    "--desp_y",
    type=int,
    default=0,
    help="Value to desplace the log value upwards",
)

args = parser.parse_args()

init = args.init + args.desp_x
end = args.end + args.desp_x
desp_x = args.desp_x
desp_y = args.desp_y

values = []

for x in range(int(init), int(end), args.step):
    x = x + desp_x
    y = log(x + desp_x)
    print(f"value: log({x}) = {y}.")
    values.append(y)

print(values)
