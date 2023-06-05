

Summary for SLC_Genotype*ASO_Tg Interaction:
Call:
lm(formula = Average_Latency ~ Day + ASO_Tg * SLC_Genotype + 
    Weight + Sex, data = data)

Residuals:
    Min      1Q  Median      3Q     Max 
-62.188 -20.604  -0.283  16.568  89.742 

Coefficients:
                               Estimate Std. Error t value
(Intercept)                    171.7369    12.2951  13.968
DayTwo                          16.2198     4.7068   3.446
DayThree                        12.6927     4.7068   2.697
ASO_TgPositive                   1.6003     8.4565   0.189
SLC_GenotypeHET                  4.7599     7.1306   0.668
SLC_GenotypeMUT                -11.1259     8.7409  -1.273
Weight                          -3.1210     0.3284  -9.502
SexMale                         -6.2116     5.0425  -1.232
ASO_TgPositive:SLC_GenotypeHET   4.8595    10.0513   0.483
ASO_TgPositive:SLC_GenotypeMUT  38.5121    11.4659   3.359
                               Pr(>|t|)    
(Intercept)                     < 2e-16 ***
DayTwo                         0.000684 ***
DayThree                       0.007558 ** 
ASO_TgPositive                 0.850088    
SLC_GenotypeHET                0.505150    
SLC_GenotypeMUT                0.204444    
Weight                          < 2e-16 ***
SexMale                        0.219349    
ASO_TgPositive:SLC_GenotypeHET 0.629254    
ASO_TgPositive:SLC_GenotypeMUT 0.000926 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 28.82 on 215 degrees of freedom
Multiple R-squared:  0.5122,	Adjusted R-squared:  0.4918 
F-statistic: 25.08 on 9 and 215 DF,  p-value: < 2.2e-16

