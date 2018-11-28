
# plot_octets()

Plots a heatmap with first two octets of an IP address.

Created during hackathon @ Centr 13th R&D workshop, 27-28.11.2018, Leiden, NL

# Usage

```R

require(dplyr)
require(sparklyr)
require(ggplot2)

sc <- sparklyr::spark_connect(...)

tbl_in <- spark_read_csv(sc, "tbl_in","hdfs:///tmp/sources.csv",delimiter = ";") # a CSV file with "src" and "count" columns

plot_octets(tbl_in)

```