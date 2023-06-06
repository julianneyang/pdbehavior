

Summary for all data:

Call:
lm(formula = Total_Time ~ Weight + Sex + ASO_Tg + SLC_Genotype, 
    data = data)

Residuals:
    Min      1Q  Median      3Q     Max 
-410.31 -157.17  -40.69  134.91  448.56 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)  
(Intercept)      -87.170    138.325  -0.630   0.5307  
Weight             7.405      4.186   1.769   0.0813 .
SexMale           23.421     64.476   0.363   0.7175  
ASO_TgPositive    63.933     50.953   1.255   0.2138  
SLC_GenotypeHET  167.652     63.823   2.627   0.0106 *
SLC_GenotypeMUT   52.074     73.306   0.710   0.4799  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 212.9 on 69 degrees of freedom
Multiple R-squared:  0.1994,	Adjusted R-squared:  0.1414 
F-statistic: 3.438 on 5 and 69 DF,  p-value: 0.007844



Summary for interaction:

Call:
lm(formula = Total_Time ~ Weight + Sex + ASO_Tg * SLC_Genotype, 
    data = data)

Residuals:
    Min      1Q  Median      3Q     Max 
-415.14 -145.62  -32.89  119.24  438.53 

Coefficients:
                               Estimate Std. Error t value
(Intercept)                     -18.527    154.405  -0.120
Weight                            7.022      4.229   1.660
SexMale                          23.031     64.930   0.355
ASO_TgPositive                  -33.991    108.893  -0.312
SLC_GenotypeHET                 106.221     91.819   1.157
SLC_GenotypeMUT                 -31.450    112.555  -0.279
ASO_TgPositive:SLC_GenotypeHET  115.791    129.428   0.895
ASO_TgPositive:SLC_GenotypeMUT  145.178    147.644   0.983
                               Pr(>|t|)
(Intercept)                       0.905
Weight                            0.102
SexMale                           0.724
ASO_TgPositive                    0.756
SLC_GenotypeHET                   0.251
SLC_GenotypeMUT                   0.781
ASO_TgPositive:SLC_GenotypeHET    0.374
ASO_TgPositive:SLC_GenotypeMUT    0.329

Residual standard error: 214.3 on 67 degrees of freedom
Multiple R-squared:  0.2123,	Adjusted R-squared:   0.13 
F-statistic:  2.58 on 7 and 67 DF,  p-value: 0.02038



Summary for Tg Neg:

Call:
lm(formula = Total_Time ~ Weight + Sex + SLC_Genotype, data = subset(data, 
    ASO_Tg == "Negative"))

Residuals:
    Min      1Q  Median      3Q     Max 
-319.85 -132.73  -18.77  115.84  418.72 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)  
(Intercept)     -205.314    184.576  -1.112    0.274  
Weight            14.099      5.251   2.685    0.011 *
SexMale          -77.814     78.034  -0.997    0.326  
SLC_GenotypeHET  103.156     85.821   1.202    0.237  
SLC_GenotypeMUT  -29.421    106.560  -0.276    0.784  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 199.9 on 35 degrees of freedom
Multiple R-squared:  0.2606,	Adjusted R-squared:  0.1761 
F-statistic: 3.084 on 4 and 35 DF,  p-value: 0.02822



Summary for Tg Pos:

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



Summary for Females Tg Neg:

Call:
lm(formula = Total_Time ~ Weight + SLC_Genotype, data = subset(data, 
    ASO_Tg == "Negative" & Sex == "Female"))

Residuals:
    Min      1Q  Median      3Q     Max 
-287.92  -98.15  -45.04   65.85  382.09 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)  
(Intercept)      -425.32     387.65  -1.097   0.2925  
Weight             20.78      10.78   1.929   0.0759 .
SLC_GenotypeHET    72.00     149.56   0.481   0.6382  
SLC_GenotypeMUT   100.35     179.82   0.558   0.5863  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 189.8 on 13 degrees of freedom
Multiple R-squared:  0.2501,	Adjusted R-squared:  0.07707 
F-statistic: 1.445 on 3 and 13 DF,  p-value: 0.2749



Summary for Females Tg Pos:

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



Summary for Males Tg Neg:

Call:
lm(formula = Total_Time ~ Weight + SLC_Genotype, data = subset(data, 
    ASO_Tg == "Negative" & Sex == "Male"))

Residuals:
    Min      1Q  Median      3Q     Max 
-268.67 -159.67  -16.52  136.80  391.35 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)  
(Intercept)     -326.769    257.437  -1.269   0.2197  
Weight            15.197      6.384   2.381   0.0279 *
SLC_GenotypeHET  133.298    105.538   1.263   0.2219  
SLC_GenotypeMUT -168.805    150.393  -1.122   0.2757  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 204.3 on 19 degrees of freedom
Multiple R-squared:  0.3605,	Adjusted R-squared:  0.2595 
F-statistic:  3.57 on 3 and 19 DF,  p-value: 0.03348



Summary for Males Tg Pos:

Call:
lm(formula = Total_Time ~ Weight + SLC_Genotype, data = subset(data, 
    ASO_Tg == "Positive" & Sex == "Male"))

Residuals:
    Min      1Q  Median      3Q     Max 
-421.90 -206.18   18.85  145.30  352.04 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)  
(Intercept)       955.69     503.97   1.896   0.0845 .
Weight            -16.55      12.35  -1.340   0.2073  
SLC_GenotypeHET   257.60     160.29   1.607   0.1363  
SLC_GenotypeMUT    45.26     201.59   0.225   0.8265  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 259.7 on 11 degrees of freedom
Multiple R-squared:  0.3028,	Adjusted R-squared:  0.1127 
F-statistic: 1.593 on 3 and 11 DF,  p-value: 0.2471

