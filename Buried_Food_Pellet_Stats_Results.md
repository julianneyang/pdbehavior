

Summary for all data:

Call:
lm(formula = Total_Time ~ Weight + Sex + ASO_Tg + SLC_Genotype, 
    data = data)

Residuals:
    Min      1Q  Median      3Q     Max 
-409.53 -157.79  -41.26  133.55  449.06 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)  
(Intercept)      -84.688    139.825  -0.606   0.5467  
Weight             7.383      4.143   1.782   0.0791 .
SexMale           24.477     64.106   0.382   0.7038  
ASO_TgPositive    62.508     50.433   1.239   0.2194  
SLC_GenotypeHET  165.861     63.765   2.601   0.0114 *
SLC_GenotypeMUT   52.061     73.241   0.711   0.4796  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 212.9 on 69 degrees of freedom
Multiple R-squared:  0.1996,	Adjusted R-squared:  0.1416 
F-statistic: 3.441 on 5 and 69 DF,  p-value: 0.007799



Summary for all days, Tg Neg:

Call:
lm(formula = Total_Time ~ Weight + Sex + SLC_Genotype, data = subset(data, 
    ASO_Tg == "Negative"))

Residuals:
    Min      1Q  Median      3Q     Max 
-315.81 -128.19  -24.49  123.52  416.06 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)  
(Intercept)     -207.077    187.200  -1.106   0.2762  
Weight            13.712      5.207   2.633   0.0125 *
SexMale          -69.421     77.766  -0.893   0.3781  
SLC_GenotypeHET  113.570     86.056   1.320   0.1955  
SLC_GenotypeMUT  -27.315    106.746  -0.256   0.7995  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 200.5 on 35 degrees of freedom
Multiple R-squared:  0.2565,	Adjusted R-squared:  0.1715 
F-statistic: 3.019 on 4 and 35 DF,  p-value: 0.03067



Summary for Day 1, Tg Pos:

Call:
lm(formula = Total_Time ~ Weight + Sex + SLC_Genotype, data = subset(data, 
    ASO_Tg == "Positive"))

Residuals:
    Min      1Q  Median      3Q     Max 
-328.74 -176.13  -35.48  141.96  387.97 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)  
(Intercept)      228.039    207.680   1.098   0.2809  
Weight            -3.543      6.676  -0.531   0.5995  
SexMale          188.661    106.114   1.778   0.0856 .
SLC_GenotypeHET  237.765     93.702   2.537   0.0166 *
SLC_GenotypeMUT  135.307     99.905   1.354   0.1857  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 219.6 on 30 degrees of freedom
Multiple R-squared:  0.2752,	Adjusted R-squared:  0.1786 
F-statistic: 2.848 on 4 and 30 DF,  p-value: 0.04103



Summary for all days, Females Tg Neg:

Call:
lm(formula = Total_Time ~ Weight + SLC_Genotype, data = subset(data, 
    ASO_Tg == "Negative" & Sex == "Female"))

Residuals:
    Min      1Q  Median      3Q     Max 
-280.56  -91.36  -64.38   80.10  356.31 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)  
(Intercept)     -303.225    312.766  -0.969   0.3477  
Weight            16.179      8.824   1.833   0.0866 .
SLC_GenotypeHET   93.540    121.787   0.768   0.4544  
SLC_GenotypeMUT   72.251    137.911   0.524   0.6080  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 182.7 on 15 degrees of freedom
Multiple R-squared:  0.2129,	Adjusted R-squared:  0.05554 
F-statistic: 1.353 on 3 and 15 DF,  p-value: 0.295



Summary for Day 1, Females Tg Pos:

Call:
lm(formula = Total_Time ~ Weight + SLC_Genotype, data = subset(data, 
    ASO_Tg == "Positive" & Sex == "Female"))

Residuals:
    Min      1Q  Median      3Q     Max 
-231.81 -130.08    2.18   67.24  378.20 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)  
(Intercept)      -97.345    218.528  -0.445   0.6620  
Weight             7.027      7.073   0.994   0.3352  
SLC_GenotypeHET  205.629    104.912   1.960   0.0676 .
SLC_GenotypeMUT  188.840    100.961   1.870   0.0798 .
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 177 on 16 degrees of freedom
Multiple R-squared:  0.2787,	Adjusted R-squared:  0.1435 
F-statistic: 2.061 on 3 and 16 DF,  p-value: 0.1459

