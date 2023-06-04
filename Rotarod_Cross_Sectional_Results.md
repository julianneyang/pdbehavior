Summary for all days, Tg + vs Tg -:

Call:
lm(formula = Average_Latency ~ Day + ASO_Tg + Weight + SLC_Genotype + 
    Sex, data = data)

Residuals:
    Min      1Q  Median      3Q     Max 
-72.039 -19.120  -1.376  17.159  89.493 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)    
(Intercept)     162.3594    11.4898  14.131  < 2e-16 ***
DayTwo           16.2198     4.8505   3.344 0.000973 ***
DayThree         12.6927     4.8505   2.617 0.009500 ** 
ASO_TgPositive   14.0153     4.1047   3.414 0.000763 ***
Weight           -3.0461     0.3372  -9.033  < 2e-16 ***
SLC_GenotypeHET   8.8470     5.1415   1.721 0.086733 .  
SLC_GenotypeMUT  11.0645     5.9055   1.874 0.062331 .  
SexMale          -6.5980     5.1941  -1.270 0.205340    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 29.7 on 217 degrees of freedom
Multiple R-squared:  0.4771,	Adjusted R-squared:  0.4603 
F-statistic: 28.29 on 7 and 217 DF,  p-value: < 2.2e-16



Summary for Day 1, Tg + vs Tg -:

Call:
lm(formula = Average_Latency ~ ASO_Tg + Weight + SLC_Genotype + 
    Sex, data = subset(data, Day == "One"))

Residuals:
    Min      1Q  Median      3Q     Max 
-57.621 -16.662  -0.085  13.661  78.623 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)    
(Intercept)     133.2550    16.4885   8.082 1.42e-11 ***
ASO_TgPositive   13.2790     6.0736   2.186   0.0322 *  
Weight           -2.2426     0.4989  -4.495 2.73e-05 ***
SLC_GenotypeHET   9.5929     7.6078   1.261   0.2116    
SLC_GenotypeMUT  15.8421     8.7382   1.813   0.0742 .  
SexMale          -6.6531     7.6856  -0.866   0.3897    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 25.38 on 69 degrees of freedom
Multiple R-squared:  0.447,	Adjusted R-squared:  0.4069 
F-statistic: 11.15 on 5 and 69 DF,  p-value: 6.733e-08



Summary for Day 2, Tg + vs Tg -:

Call:
lm(formula = Average_Latency ~ ASO_Tg + Weight + SLC_Genotype + 
    Sex, data = subset(data, Day == "Two"))

Residuals:
   Min     1Q Median     3Q    Max 
-65.33 -20.33  -0.35  17.56  80.09 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)    
(Intercept)     204.0712    20.7091   9.854 8.52e-15 ***
ASO_TgPositive   20.1204     7.6283   2.638   0.0103 *  
Weight           -3.8990     0.6267  -6.222 3.31e-08 ***
SLC_GenotypeHET   6.7405     9.5551   0.705   0.4829    
SLC_GenotypeMUT  10.1918    10.9749   0.929   0.3563    
SexMale          -1.4882     9.6529  -0.154   0.8779    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 31.87 on 69 degrees of freedom
Multiple R-squared:  0.5284,	Adjusted R-squared:  0.4942 
F-statistic: 15.46 on 5 and 69 DF,  p-value: 3.508e-10



Summary for Day 3, Tg + vs Tg -:

Call:
lm(formula = Average_Latency ~ ASO_Tg + Weight + SLC_Genotype + 
    Sex, data = subset(data, Day == "Three"))

Residuals:
    Min      1Q  Median      3Q     Max 
-72.761 -19.695  -1.696  18.133  84.616 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)    
(Intercept)     178.6644    20.7280   8.619 1.47e-12 ***
ASO_TgPositive    8.6465     7.6352   1.132    0.261    
Weight           -2.9965     0.6272  -4.777 9.65e-06 ***
SLC_GenotypeHET  10.2075     9.5639   1.067    0.290    
SLC_GenotypeMUT   7.1595    10.9849   0.652    0.517    
SexMale         -11.6529     9.6617  -1.206    0.232    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 31.9 on 69 degrees of freedom
Multiple R-squared:  0.444,	Adjusted R-squared:  0.4037 
F-statistic: 11.02 on 5 and 69 DF,  p-value: 8.031e-08

