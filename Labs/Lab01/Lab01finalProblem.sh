#!/bin/bash

# Subsetting Data - Adding header line and last 10 lines of data from columns 2 -4

# Subset

cut -f 2-4 -d , PredPreyData.csv > PredPreyData_cut.csv

head -n 1 PredPreyData_cut.csv > PredPreyData_abridged11.csv | tail PredPreyData_cut.csv >> PredPreyData_abridged11.csv




