Summary for all data, Tg + vs Tg -:

Call:
lm(formula = Average_Latency ~ Treatment + Weight + SLC_Genotype + 
    Sex, data = data)

Residuals:
     Min       1Q   Median       3Q      Max 
-100.013  -48.101   -9.508   40.711  164.338 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)  
(Intercept)       80.225     94.824   0.846   0.4000  
TreatmentSALINE   -3.429     13.939  -0.246   0.8063  
Weight             4.081      4.144   0.985   0.3275  
SLC_GenotypeHET  -43.795     17.333  -2.527   0.0134 *
SLC_GenotypeMUT  -42.179     18.011  -2.342   0.0216 *
SexMale          -72.998     29.855  -2.445   0.0166 *
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 64.3 on 83 degrees of freedom
Multiple R-squared:  0.2146,	Adjusted R-squared:  0.1673 
F-statistic: 4.536 on 5 and 83 DF,  p-value: 0.00105



Summary for SLC_Genotype*Treatment Interaction:
Call:
lm(formula = Average_Latency ~ Treatment * SLC_Genotype + Weight + 
    Sex, data = data)

Residuals:
     Min       1Q   Median       3Q      Max 
-105.385  -44.120   -8.881   40.755  168.199 

Coefficients:
                                Estimate Std. Error t value Pr(>|t|)  
(Intercept)                       56.755     96.292   0.589   0.5572  
TreatmentSALINE                   28.316     27.315   1.037   0.3030  
SLC_GenotypeHET                  -31.482     23.072  -1.364   0.1762  
SLC_GenotypeMUT                  -16.297     23.601  -0.691   0.4918  
Weight                             4.459      4.220   1.057   0.2938  
SexMale                          -73.188     30.290  -2.416   0.0179 *
TreatmentSALINE:SLC_GenotypeHET  -29.169     34.654  -0.842   0.4024  
TreatmentSALINE:SLC_GenotypeMUT  -61.420     36.318  -1.691   0.0946 .
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 63.96 on 81 degrees of freedom
Multiple R-squared:  0.2416,	Adjusted R-squared:  0.1761 
F-statistic: 3.687 on 7 and 81 DF,  p-value: 0.001655

