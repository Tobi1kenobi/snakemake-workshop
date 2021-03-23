import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from pysam import VariantFile
import argparse

parser = argparse.ArgumentParser()

parser.add_argument(
        '-v', '--vcf',
        action='store',
        dest='vcf',
        required=True,
        help='VCF file input'
    )

parser.add_argument(
        '-o', '--output',
        action='store',
        dest='output',
        required=True,
        help='Output file path.'
    )

options = parser.parse_args()

quals = [record.qual for record in VariantFile(options.vcf)]
plt.hist(quals)

plt.savefig(options.output)
