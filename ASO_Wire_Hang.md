
Call:
lm(formula = Time ~ Weight + Sex + ASO_Tg * SLC_Genotype, data = final_df)

Residuals:
    Min      1Q  Median      3Q     Max 
-97.043 -25.041  -0.697  33.763  80.908 

Coefficients:
                               Estimate Std. Error t value
(Intercept)                    225.5600    31.3989   7.184
Weight                          -4.5935     0.8469  -5.424
SexMale                          4.0913    13.4357   0.305
ASO_TgPositive                 -12.6927    22.8735  -0.555
SLC_GenotypeHET                  7.4328    19.7928   0.376
SLC_GenotypeMUT                 -4.1522    23.5449  -0.176
ASO_TgPositive:SLC_GenotypeHET  -7.1018    27.4124  -0.259
ASO_TgPositive:SLC_GenotypeMUT  22.6538    30.4862   0.743
                               Pr(>|t|)    
(Intercept)                    1.03e-09 ***
Weight                         1.02e-06 ***
SexMale                           0.762    
ASO_TgPositive                    0.581    
SLC_GenotypeHET                   0.709    
SLC_GenotypeMUT                   0.861    
ASO_TgPositive:SLC_GenotypeHET    0.796    
ASO_TgPositive:SLC_GenotypeMUT    0.460    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 43.15 on 62 degrees of freedom
Multiple R-squared:  0.439,	Adjusted R-squared:  0.3757 
F-statistic: 6.932 on 7 and 62 DF,  p-value: 4.295e-06

