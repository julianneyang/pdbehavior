 #### Body Weight Stats
##### WT vs MUT
```R 
Welch Two Sample t-test
data:  Weight..g. by Genotype
t = -1.7597, df = 19.507, p-value = 0.09413
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -6.8381393  0.5856393
sample estimates:
mean in group MUT  mean in group WT 
         25.83000          28.95625 
```
```R
Wilcoxon rank sum test with continuity correction
data:  Weight..g. by Genotype
W = 56.5, p-value = 0.225
alternative hypothesis: true location shift is not equal to 0
```

##### WT vs HET
```R
Welch Two Sample t-test
data:  Weight..g. by Genotype
t = -0.96785, df = 27.39, p-value = 0.3416
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -4.119509  1.477598
sample estimates:
mean in group HET  mean in group WT 
         27.63529          28.95625 
```
```R
Wilcoxon rank sum test with continuity correction
data:  Weight..g. by Genotype
W = 112, p-value = 0.3972
alternative hypothesis: true location shift is not equal to 0
```

#### Open Field Stats
##### Center Time
###### WT vs MUT
```R
Welch Two Sample t-test
data:  Center_Time by Genotype
t = -0.71663, df = 18.752, p-value = 0.4824
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -91.27853  44.74671
sample estimates:
mean in group MUT  mean in group WT 
         238.8091          262.0750 
```

```R
Wilcoxon rank sum test with continuity correction
data:  Center_Time by Genotype
W = 76, p-value = 0.5703
alternative hypothesis: true location shift is not equal to 0
```
###### WT vs HET
```R
Welch Two Sample t-test
data:  Center_Time by Genotype
t = 0.20709, df = 27.173, p-value = 0.8375
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -57.93672  70.94922
sample estimates:
mean in group HET  mean in group WT 
         268.5813          262.0750 
```
```R
Wilcoxon rank sum exact test
data:  Center_Time by Genotype
W = 131, p-value = 0.926
alternative hypothesis: true location shift is not equal to 0
```

##### Distance
###### WT vs MUT
```R
Welch Two Sample t-test
data:  Distance by Genotype
t = -0.14523, df = 19.425, p-value = 0.886
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -4.816201  4.190349
sample estimates:
mean in group MUT  mean in group WT 
         15.21064          15.52356 
```

```R
Wilcoxon rank sum exact test
data:  Distance by Genotype
W = 87, p-value = 0.9807
alternative hypothesis: true location shift is not equal to 0
```

###### WT vs HET
```R
Welch Two Sample t-test
data:  Distance by Genotype
t = 0.21257, df = 28.763, p-value = 0.8332
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -2.953991  3.638991
sample estimates:
mean in group HET  mean in group WT 
         15.86606          15.52356 
```

```R
Wilcoxon rank sum exact test
data:  Distance by Genotype
W = 126, p-value = 0.9556
alternative hypothesis: true location shift is not equal to 0
```

#### FP output Stats
##### 5 minutes: WT vs MuT
```R
Wilcoxon rank sum test with continuity correction

data:  X5_min by Genotype
W = 36.5, p-value = 0.01769
alternative hypothesis: true location shift is not equal to 0
```
```R
Welch Two Sample t-test

data:  X5_min by Genotype
t = -3.101, df = 21.949, p-value = 0.005222
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -3.6923544 -0.7326456
sample estimates:
mean in group MUT  mean in group WT 
           0.6000            2.8125  
```

##### 5 minutes: WT vs HET

```R
Welch Two Sample t-test

data:  X5_min by Genotype
t = -3.764, df = 18.581, p-value = 0.001356
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -3.892287 -1.107713
sample estimates:
mean in group HET  mean in group WT 
           0.3125            2.8125 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X5_min by Genotype
W = 44.5, p-value = 0.000542
alternative hypothesis: true location shift is not equal to 0
```

##### 10 minutes: WT vs MUT

```R
Welch Two Sample t-test

data:  X10_min by Genotype
t = -2.168, df = 22.975, p-value = 0.04077
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -3.88406088 -0.09093912
sample estimates:
mean in group MUT  mean in group WT 
           1.7000            3.6875 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X10_min by Genotype
W = 45.5, p-value = 0.06986
alternative hypothesis: true location shift is not equal to 0
```

##### 10 minutes: WT vs HET

```R
Welch Two Sample t-test

data:  X10_min by Genotype
t = -2.5021, df = 29.344, p-value = 0.01816
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -3.9746448 -0.4003552
sample estimates:
mean in group HET  mean in group WT 
           1.5000            3.6875 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X10_min by Genotype
W = 67, p-value = 0.01795
alternative hypothesis: true location shift is not equal to 0
```

##### 15 minutes: WT vs MUT

```R
Welch Two Sample t-test

data:  X15_min by Genotype
t = -2.045, df = 22.2, p-value = 0.05289
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -4.00205721  0.02705721
sample estimates:
mean in group MUT  mean in group WT 
           2.2000            4.1875 
```

```R
Wilcoxon rank sum test with continuity correction

data:  X15_min by Genotype
W = 46, p-value = 0.07508
alternative hypothesis: true location shift is not equal to 0
```


##### 15 minutes: WT vs HET

```R
Welch Two Sample t-test

data:  X15_min by Genotype
t = -1.9846, df = 29.683, p-value = 0.0565
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -3.67854049  0.05354049
sample estimates:
mean in group HET  mean in group WT 
           2.3750            4.1875 

```
```R
Wilcoxon rank sum test with continuity correction

data:  X15_min by Genotype
W = 79, p-value = 0.06405
alternative hypothesis: true location shift is not equal to 0
```


#####30 minutes: WT vs MUT

```R
Welch Two Sample t-test

data:  X30_min by Genotype
t = -1.5351, df = 19.093, p-value = 0.1412
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -4.6078464  0.7078464
sample estimates:
mean in group MUT  mean in group WT 
             3.30              5.25 

```

```R
Wilcoxon rank sum test with continuity correction

data:  X30_min by Genotype
W = 52.5, p-value = 0.1524
alternative hypothesis: true location shift is not equal to 0
```

##### 30 minutes: WT vs HET

```R
Welch Two Sample t-test

data:  X30_min by Genotype
t = -1.4516, df = 29.985, p-value = 0.157
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -3.9112307  0.6612307
sample estimates:
mean in group HET  mean in group WT 
            3.625             5.250 

```
```R
Wilcoxon rank sum test with continuity correction

data:  X30_min by Genotype
W = 90.5, p-value = 0.1603
alternative hypothesis: true location shift is not equal to 0

```

##### 45 minutes: WT vs MUT

```R
Welch Two Sample t-test

data:  X45_min by Genotype
t = -1.1819, df = 20.22, p-value = 0.2509
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -4.732753  1.307753
sample estimates:
mean in group MUT  mean in group WT 
           4.6000            6.3125 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X45_min by Genotype
W = 58, p-value = 0.2555
alternative hypothesis: true location shift is not equal to 0
```


##### 45 minutes: WT vs HET

```R
Welch Two Sample t-test

data:  X45_min by Genotype
t = -1.4355, df = 29.947, p-value = 0.1615
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -4.6941008  0.8191008
sample estimates:
mean in group HET  mean in group WT 
           4.3750            6.3125 

```
```R

    Wilcoxon rank sum test with continuity correction

data:  X45_min by Genotype
W = 89, p-value = 0.1449
alternative hypothesis: true location shift is not equal to 0
```


##### 60 minutes: WT vs MUT

```R
Welch Two Sample t-test

data:  X60_min by Genotype
t = -1.1642, df = 22.57, p-value = 0.2565
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -4.828013  1.353013
sample estimates:
mean in group MUT  mean in group WT 
           5.2000            6.9375 

```
```R
Wilcoxon rank sum test with continuity correction

data:  X60_min by Genotype
W = 62, p-value = 0.3538
alternative hypothesis: true location shift is not equal to 0
```


##### 60 minutes: WT vs HET

```R
Welch Two Sample t-test

data:  X60_min by Genotype
t = -1.4804, df = 29.973, p-value = 0.1492
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -5.3540307  0.8540307
sample estimates:
mean in group HET  mean in group WT 
           4.6875            6.9375 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X60_min by Genotype
W = 86.5, p-value = 0.1206
alternative hypothesis: true location shift is not equal to 0
```

##### Females 5 minutes: WT vs MUT

```R
Welch Two Sample t-test

data:  X5_min by Genotype
t = -5.1393, df = 5.3172, p-value = 0.003053
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -6.249428 -2.131524
sample estimates:
mean in group MUT  mean in group WT 
        0.1428571         4.3333333 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X5_min by Genotype
W = 0.5, p-value = 0.002535
alternative hypothesis: true location shift is not equal to 0

```

##### Females 5 minutes: WT vs HET
```R
Wilcoxon rank sum test with continuity correction

data:  X5_min by Genotype
W = 28, p-value = 0.1326
alternative hypothesis: true location shift is not equal to 0
```
```R
	Welch Two Sample t-test

data:  X5_min by Genotype
t = -5.398, df = 5, p-value = 0.002947
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -6.396927 -2.269740
sample estimates:
mean in group HET  mean in group WT 
         0.000000          4.333333 
```

##### Males 5 minutes:WT vs MUT

```R
	Welch Two Sample t-test

data:  X5_min by Genotype
t = -0.19967, df = 5.4708, p-value = 0.8489
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -3.161131  2.694464
sample estimates:
mean in group MUT  mean in group WT 
         1.666667          1.900000 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X5_min by Genotype
W = 16, p-value = 0.9302
alternative hypothesis: true location shift is not equal to 0
```

##### Males 5 minutes: WT vs HET
```R
Welch Two Sample t-test

data:  X5_min by Genotype
t = -1.5738, df = 13.018, p-value = 0.1395
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -3.1896865  0.5007976
sample estimates:
mean in group HET  mean in group WT 
        0.5555556         1.9000000 
```
```R

data:  X5_min by Genotype
W = 28, p-value = 0.1326
alternative hypothesis: true location shift is not equal to 0

```
##### Females 10 Minutes: WT vs MUT
```R
Welch Two Sample t-test

data:  X10_min by Genotype
t = -3.1198, df = 10.363, p-value = 0.01044
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -6.639624 -1.122281
sample estimates:
mean in group MUT  mean in group WT 
         1.285714          5.166667 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X10_min by Genotype
W = 3.5, p-value = 0.01393
alternative hypothesis: true location shift is not equal to 0
```
##### Females 10 minutes:WT vs HET
```R
Welch Two Sample t-test

data:  X10_min by Genotype
t = -2.422, df = 10.973, p-value = 0.03394
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -6.3179855 -0.3010622
sample estimates:
mean in group HET  mean in group WT 
         1.857143          5.166667 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X10_min by Genotype
W = 6.5, p-value = 0.04168
alternative hypothesis: true location shift is not equal to 0
```

##### Males 10 minutes: WT vs MUT
```R
Welch Two Sample t-test

data:  X10_min by Genotype
t = -0.11198, df = 5.7765, p-value = 0.9146
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -3.074433  2.807767
sample estimates:
mean in group MUT  mean in group WT 
         2.666667          2.800000 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X10_min by Genotype
W = 14.5, p-value = 1
alternative hypothesis: true location shift is not equal to 0
```

##### Males 10 minutes: WT vs HET
```R
Welch Two Sample t-test

data:  X10_min by Genotype
t = -1.4817, df = 16.917, p-value = 0.1568
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -3.8251813  0.6696258
sample estimates:
mean in group HET  mean in group WT 
         1.222222          2.800000 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X10_min by Genotype
W = 27.5, p-value = 0.1417
alternative hypothesis: true location shift is not equal to 0
```

##### Females 15 minutes: WT vs MUT
```R
Welch Two Sample t-test

data:  X15_min by Genotype
t = -2.9554, df = 10.459, p-value = 0.01376
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -6.9561873 -0.9961937
sample estimates:
mean in group MUT  mean in group WT 
         1.857143          5.833333 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X15_min by Genotype
W = 5, p-value = 0.02536
alternative hypothesis: true location shift is not equal to 0
```
##### Females 15 minutes: WT vs HET
```R
Welch Two Sample t-test

data:  X15_min by Genotype
t = -2.5207, df = 10.972, p-value = 0.02849
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -6.9138027 -0.4671497
sample estimates:
mean in group HET  mean in group WT 
         2.142857          5.833333 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X15_min by Genotype
W = 6.5, p-value = 0.04285
alternative hypothesis: true location shift is not equal to 0
```

##### Males 15 minutes: WT vs MUT
```R
Welch Two Sample t-test

data:  X15_min by Genotype
t = -0.144, df = 4.008, p-value = 0.8924
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -4.05302  3.65302
sample estimates:
mean in group MUT  mean in group WT 
              3.0               3.2 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X15_min by Genotype
W = 14.5, p-value = 1
alternative hypothesis: true location shift is not equal to 0

```

##### Males 15 minutes: WT vs HET
```R
Welch Two Sample t-test

data:  X15_min by Genotype
t = -0.59276, df = 16.956, p-value = 0.5612
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -2.938666  1.649777
sample estimates:
mean in group HET  mean in group WT 
         2.555556          3.200000 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X15_min by Genotype
W = 38, p-value = 0.5897
alternative hypothesis: true location shift is not equal to 0
```
##### Females 30 minutes: WT vs MUT
```R
Welch Two Sample t-test

data:  X30_min by Genotype
t = -2.4201, df = 10.987, p-value = 0.03403
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -8.0020993 -0.3788531
sample estimates:
mean in group MUT  mean in group WT 
         3.142857          7.333333 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X30_min by Genotype
W = 7, p-value = 0.05247
alternative hypothesis: true location shift is not equal to 0
```
##### Females 30 minutes: WT vs HET
```R
Welch Two Sample t-test

data:  X30_min by Genotype
t = -2.664, df = 10.754, p-value = 0.02242
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -7.6623515 -0.7186009
sample estimates:
mean in group HET  mean in group WT 
         3.142857          7.333333 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X30_min by Genotype
W = 5.5, p-value = 0.03118
alternative hypothesis: true location shift is not equal to 0
```

##### Males 30 minutes: WT vs MUT
```R
Welch Two Sample t-test

data:  X30_min by Genotype
t = -0.17001, df = 3.0167, p-value = 0.8758
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -6.553703  5.887037
sample estimates:
mean in group MUT  mean in group WT 
         3.666667          4.000000 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X30_min by Genotype
W = 14, p-value = 0.9322
alternative hypothesis: true location shift is not equal to 0
```
##### Males 30 minutes: WT vs HET
```R
Welch Two Sample t-test

data:  X30_min by Genotype
t = 0, df = 14.881, p-value = 1
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -3.127488  3.127488
sample estimates:
mean in group HET  mean in group WT 
                4                 4 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X30_min by Genotype
W = 44, p-value = 0.9671
alternative hypothesis: true location shift is not equal to 0
```

##### Females 45 minutes: WT vs MUT
```R
Welch Two Sample t-test

data:  X45_min by Genotype
t = -2.7292, df = 10.612, p-value = 0.02019
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -9.0072137 -0.9451673
sample estimates:
mean in group MUT  mean in group WT 
         3.857143          8.833333 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X45_min by Genotype
W = 7, p-value = 0.0528
alternative hypothesis: true location shift is not equal to 0
```
##### Females 45 minutes: WT vs HET
```R
Welch Two Sample t-test

data:  X45_min by Genotype
t = -2.406, df = 10.969, p-value = 0.03492
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -8.9827757 -0.3981767
sample estimates:
mean in group HET  mean in group WT 
         4.142857          8.833333 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X45_min by Genotype
W = 7, p-value = 0.05149
alternative hypothesis: true location shift is not equal to 0

```
##### Males 45 minutes: WT vs MUT
```R
Welch Two Sample t-test

data:  X45_min by Genotype
t = 0.58724, df = 2.7649, p-value = 0.6015
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -7.190708 10.257375
sample estimates:
mean in group MUT  mean in group WT 
         6.333333          4.800000 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X45_min by Genotype
W = 18.5, p-value = 0.6111
alternative hypothesis: true location shift is not equal to 0
```
##### Males 45 minutes: WT vs HET
```R
Welch Two Sample t-test

data:  X45_min by Genotype
t = -0.14013, df = 14.895, p-value = 0.8904
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -3.964930  3.476041
sample estimates:
mean in group HET  mean in group WT 
         4.555556          4.800000 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X45_min by Genotype
W = 41.5, p-value = 0.8055
alternative hypothesis: true location shift is not equal to 0

```

##### Females 60 minutes: WT vs MUT
```R
Welch Two Sample t-test

data:  X60_min by Genotype
t = -2.5641, df = 9.0126, p-value = 0.03045
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -9.186282 -0.575623
sample estimates:
mean in group MUT  mean in group WT 
         4.285714          9.166667 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X60_min by Genotype
W = 8, p-value = 0.07176
alternative hypothesis: true location shift is not equal to 0
```
##### Females 60 minutes: WT vs HET
```R
Welch Two Sample t-test

data:  X60_min by Genotype
t = -2.0967, df = 10.949, p-value = 0.06006
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -9.7146959  0.2385054
sample estimates:
mean in group HET  mean in group WT 
         4.428571          9.166667 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X60_min by Genotype
W = 7.5, p-value = 0.0604
alternative hypothesis: true location shift is not equal to 0
```
##### Males 60 minutes: WT vs MUT
```R
Welch Two Sample t-test

data:  X5_min by Genotype
t = -0.19967, df = 5.4708, p-value = 0.8489
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -3.161131  2.694464
sample estimates:
mean in group MUT  mean in group WT 
         1.666667          1.900000 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X5_min by Genotype
W = 16, p-value = 0.9302
alternative hypothesis: true location shift is not equal to 0
```
##### Males 60 minutes: WT vs HET
```R
Welch Two Sample t-test

data:  X5_min by Genotype
t = -1.5738, df = 13.018, p-value = 0.1395
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -3.1896865  0.5007976
sample estimates:
mean in group HET  mean in group WT 
        0.5555556         1.9000000 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X5_min by Genotype
W = 28, p-value = 0.1326
alternative hypothesis: true location shift is not equal to 0
```

#### OLM Stats
##### Percent Time Investigating
###### WT vs MUT: Training
```R
Welch Two Sample t-test
data:  Percent_Time_Investigated by Genotype
t = -0.51935, df = 23.955, p-value = 0.6083
alternative hypothesis: true difference in means between group WT and group MUT is not equal to 0
95 percent confidence interval:
 -12.548326   7.503154
sample estimates:
 mean in group WT mean in group MUT 
         48.03112          50.55370 
```

```R
Wilcoxon rank sum exact test
data:  Percent_Time_Investigated by Genotype
W = 68, p-value = 0.4742
alternative hypothesis: true location shift is not equal to 0
```

###### WT vs MUT: Testing
```R
Welch Two Sample t-test
data:  Percent_Time_Investigated by Genotype
t = 0.53033, df = 23.99, p-value = 0.6008
alternative hypothesis: true difference in means between group WT and group MUT is not equal to 0
95 percent confidence interval:
 -9.121966 15.430797
sample estimates:
 mean in group WT mean in group MUT 
         51.97313          48.81872 
```

```R
Wilcoxon rank sum exact test
data:  Percent_Time_Investigated by Genotype
W = 94, p-value = 0.5744
alternative hypothesis: true location shift is not equal to 0
```
###### WT vs HET: Training
```R
Welch Two Sample t-test
data:  Percent_Time_Investigated by Genotype
t = -0.76837, df = 22.182, p-value = 0.4504
alternative hypothesis: true difference in means between group WT and group HET is not equal to 0
95 percent confidence interval:
 -11.935081   5.479811
sample estimates:
 mean in group WT mean in group HET 
         48.03112          51.25875 
```
```R
Wilcoxon rank sum test with continuity correction
data:  Percent_Time_Investigated by Genotype
W = 78, p-value = 0.2475
alternative hypothesis: true location shift is not equal to 0
```
###### WT vs HET: Testing
```R
Welch Two Sample t-test
data:  Percent_Time_Investigated by Genotype
t = -1.5448, df = 24.008, p-value = 0.1355
alternative hypothesis: true difference in means between group WT and group HET is not equal to 0
95 percent confidence interval:
 -19.497387   2.804207
sample estimates:
 mean in group WT mean in group HET 
         51.97313          60.31972 
```
```R
Wilcoxon rank sum test with continuity correction
data:  Percent_Time_Investigated by Genotype
W = 75, p-value = 0.1979
alternative hypothesis: true location shift is not equal to 0
```
###### Linear Mixed-Effects Model
```R
Data: data_box_plot 
       AIC      BIC    logLik
  630.9811 644.9655 -309.4906

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev: 0.002652787 13.05602

Fixed effects:  Percent_Investigation_Time ~ Sex + Genotype 
               Value Std.Error DF   t-value p-value
(Intercept) 49.50007  2.981069 39 16.604804  0.0000
SexMale      0.83677  2.983653 37  0.280450  0.7807
GenotypeHET  5.81102  3.431777 37  1.693298  0.0988
GenotypeMUT -0.11813  3.731955 37 -0.031655  0.9749
 Correlation: 
            (Intr) SexMal GntHET
SexMale     -0.601              
GenotypeHET -0.570  0.025       
GenotypeMUT -0.624  0.189  0.448

Standardized Within-Group Residuals:
       Min         Q1        Med         Q3        Max 
-2.4836355 -0.6341935 -0.1164272  0.6357866  2.2252180 

Number of Observations: 80
Number of Groups: 40 
```
