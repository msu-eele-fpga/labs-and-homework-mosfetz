
# HW7

## Overview
We explored using different Linux commands in this HW

## Deliverables

### Problem 1
`$ wc lorem-ipsum.txt -w`

![alt](assets/hw7/problem%201.jpg)
### Problem 2
`wc lorem-ipsum.txt -m`

![alt](assets/hw7/p2.jpg)
### Problem 3
` wc lorem-ipsum.txt -l`

![alt](assets/hw7/p3.jpg)
### Problem 4
`sort -n  file-sizes.txt`

![alt](assets/hw7/p4.jpg)
### Problem 5
`sort -r file-sizes.txt`

![alt](assets/hw7/p5.jpg)
### Problem 6
`cut -f 3 -d "," log.csv`

![alt](assets/hw7/p6.jpg)
### Problem 7
`cut -d "," -f 2-3 log.csv`

![alt](assets/hw7/p7.jpg)
### Problem 8
`cut -d "," -f 1,4  log.csv`

![alt](assets/hw7/p8.jpg)
### Problem 9
`head -n -5 gibberish.txt`

![alt](assets/hw7/p9.jpg)
### Problem 10
` tail -n -2 gibberish.txt`

![alt](assets/hw7/p10.jpg)
### Problem 11
` tail -n -20 log.csv`

![alt](assets/hw7/p11.jpg)
### Problem 12
`grep and gibberish.txt`

![alt](assets/hw7/p12.jpg)
### Problem 13
`grep -o -n we gibberish.txt`

![alt](assets/hw7/p13.jpg)
### Problem 14
`grep -P -o '[Tt]o \w+' gibberish.txt`

![alt](assets/hw7/p14.jpg)
### Problem 15
`grep -c FPGAs fpgas.txt`

![alt](assets/hw7/p15.jpg)
### Problem 16
`grep -P 'FPGAs are (hot|not)|Software engineers cower|Few have climbed the tower|Years gone by, nary a smile,|First d
esign to compile' fpgas.txt`

![alt](assets/hw7/p16.jpg)
### Problem 17
`grep -r -c -P '\-\-' --include="*.vhd"`

![alt](assets/hw7/p17.jpg)
### Problem 18
`ls >ls-output.txt`
`cat ls-output.txt`

![alt](assets/hw7/p18.jpg)
### Problem 19
`sudo dmesg | grep Mic`

![alt](assets/hw7/p19.jpg)
### Problem 20
`find -iname '*.vhd'|wc -l`

![alt](assets/hw7/p20.jpg)
### Problem 21
`grep -r -P '\-\-' --include="*.vhd" hdl | wc -l`

![alt](assets/hw7/p21.jpg)
### Problem 22
`grep -n FPGAs fpgas.txt | cut -f 1 -d ':'`

![alt](assets/hw7/p22.jpg)
### Problem 23
`du -h * | sort -h`

![alt](assets/hw7/p23.jpg)


