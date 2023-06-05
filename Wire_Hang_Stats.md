

Summary for all data:

Call:
lm(formula = Time ~ Weight + Sex + ASO_Tg + SLC_Genotype, data = final_df)

Residuals:
    Min      1Q  Median      3Q     Max 
-92.813 -26.304   0.196  31.431  79.485 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)    
(Intercept)     222.8352    27.5750   8.081 2.32e-11 ***
Weight           -4.5462     0.8392  -5.417 9.76e-07 ***
SexMale           3.1622    13.3513   0.237    0.814    
ASO_TgPositive  -10.0240    10.6747  -0.939    0.351    
SLC_GenotypeHET   5.4858    13.5217   0.406    0.686    
SLC_GenotypeMUT   8.8876    15.0312   0.591    0.556    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 42.96 on 64 degrees of freedom
Multiple R-squared:  0.4261,	Adjusted R-squared:  0.3813 
F-statistic: 9.504 on 5 and 64 DF,  p-value: 8.162e-07



Summary for all days, Tg Neg:

Call:
lm(formula = Time ~ Weight + Sex + SLC_Genotype, data = subset(final_df, 
    ASO_Tg == "Negative"))

Residuals:
     Min       1Q   Median       3Q      Max 
-112.974  -27.248    4.392   33.829   65.136 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)    
(Intercept)      269.434     41.474   6.496 2.60e-07 ***
Weight            -6.104      1.177  -5.186 1.16e-05 ***
SexMale           19.543     18.090   1.080    0.288    
SLC_GenotypeHET    7.840     20.661   0.379    0.707    
SLC_GenotypeMUT   -5.977     24.812  -0.241    0.811    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 45.03 on 32 degrees of freedom
Multiple R-squared:  0.4942,	Adjusted R-squared:  0.4309 
F-statistic: 7.816 on 4 and 32 DF,  p-value: 0.0001636



Summary for Day 1, Tg Pos:

Call:
lm(formula = Time ~ Weight + Sex + SLC_Genotype, data = subset(final_df, 
    ASO_Tg == "Positive"))

Residuals:
    Min      1Q  Median      3Q     Max 
-70.603 -26.434  -2.267  23.013  73.034 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)    
(Intercept)      155.752     36.121   4.312 0.000181 ***
Weight            -2.517      1.172  -2.148 0.040537 *  
SexMale          -22.399     19.245  -1.164 0.254302    
SLC_GenotypeHET   -3.860     17.247  -0.224 0.824543    
SLC_GenotypeMUT   13.170     17.846   0.738 0.466641    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 38.88 on 28 degrees of freedom
Multiple R-squared:  0.4376,	Adjusted R-squared:  0.3573 
F-statistic: 5.447 on 4 and 28 DF,  p-value: 0.002257



Summary for all days, Females Tg Neg:

Call:
lm(formula = Time ~ Weight + SLC_Genotype, data = subset(final_df, 
    ASO_Tg == "Negative" & Sex == "Female"))

Residuals:
    Min      1Q  Median      3Q     Max 
-74.475 -17.163   1.185  24.759  42.783 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)    
(Intercept)     361.6543    71.0705   5.089 0.000267 ***
Weight          -10.0583     2.0058  -5.015 0.000302 ***
SLC_GenotypeHET  50.3309    27.9909   1.798 0.097344 .  
SLC_GenotypeMUT   0.8726    32.8884   0.027 0.979268    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 35.49 on 12 degrees of freedom
Multiple R-squared:  0.7271,	Adjusted R-squared:  0.6588 
F-statistic: 10.66 on 3 and 12 DF,  p-value: 0.001061



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



Summary for all days, Males Tg Neg:

Call:
lm(formula = Time ~ Weight + SLC_Genotype, data = subset(final_df, 
    ASO_Tg == "Negative" & Sex == "Male"))

Residuals:
    Min      1Q  Median      3Q     Max 
-94.313 -25.576  -1.031  21.213  75.045 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)    
(Intercept)      261.718     58.544   4.470 0.000336 ***
Weight            -4.850      1.444  -3.359 0.003720 ** 
SLC_GenotypeHET  -19.938     26.388  -0.756 0.460246    
SLC_GenotypeMUT  -23.204     35.898  -0.646 0.526670    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 46.47 on 17 degrees of freedom
Multiple R-squared:  0.4287,	Adjusted R-squared:  0.3279 
F-statistic: 4.253 on 3 and 17 DF,  p-value: 0.02055



Summary for Day 1, Males Tg Pos:

Call:
lm(formula = Time ~ Weight + SLC_Genotype, data = subset(final_df, 
    ASO_Tg == "Positive" & Sex == "Male"))

Residuals:
    Min      1Q  Median      3Q     Max 
-42.521 -16.908  -1.258  11.689  42.434 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)  
(Intercept)      146.119     54.219   2.695   0.0208 *
Weight            -2.554      1.343  -1.901   0.0838 .
SLC_GenotypeHET   -7.511     16.919  -0.444   0.6657  
SLC_GenotypeMUT  -33.300     21.249  -1.567   0.1454  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 27.15 on 11 degrees of freedom
Multiple R-squared:  0.4165,	Adjusted R-squared:  0.2573 
F-statistic: 2.617 on 3 and 11 DF,  p-value: 0.1035



Summary for all data, ASO_Tg*SLC_Genotype:

Call:
lm(formula = Time ~ Weight + Sex + ASO_Tg * SLC_Genotype, data = final_df)

Residuals:
    Min      1Q  Median      3Q     Max 
-97.043 -25.041  -0.697  33.763  80.908 

Coefficients:
                               Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    225.5600    31.3989   7.184 1.03e-09 ***
Weight                          -4.5935     0.8469  -5.424 1.02e-06 ***
SexMale                          4.0913    13.4357   0.305    0.762    
ASO_TgPositive                 -12.6927    22.8735  -0.555    0.581    
SLC_GenotypeHET                  7.4328    19.7928   0.376    0.709    
SLC_GenotypeMUT                 -4.1522    23.5449  -0.176    0.861    
ASO_TgPositive:SLC_GenotypeHET  -7.1018    27.4124  -0.259    0.796    
ASO_TgPositive:SLC_GenotypeMUT  22.6538    30.4862   0.743    0.460    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 43.15 on 62 degrees of freedom
Multiple R-squared:  0.439,	Adjusted R-squared:  0.3757 
F-statistic: 6.932 on 7 and 62 DF,  p-value: 4.295e-06

