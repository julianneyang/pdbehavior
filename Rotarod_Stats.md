

Summary for all days, Tg Pos:

Call:
lm(formula = Average_Latency ~ Day + Weight + SLC_Genotype + 
    Sex, data = subset(data, ASO_Tg == "Positive"))

Residuals:
    Min      1Q  Median      3Q     Max 
-55.095 -22.041  -3.638  23.496  93.165 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)    
(Intercept)     208.3063    17.7578  11.730  < 2e-16 ***
DayTwo           19.6367     7.5362   2.606  0.01060 *  
DayThree         10.1176     7.5362   1.343  0.18252    
Weight           -4.2801     0.5534  -7.734 9.33e-12 ***
SLC_GenotypeHET  12.2416     7.7678   1.576  0.11826    
SLC_GenotypeMUT  28.0266     8.2821   3.384  0.00103 ** 
SexMale           1.9024     8.7968   0.216  0.82924    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 31.53 on 98 degrees of freedom
Multiple R-squared:  0.5835,	Adjusted R-squared:  0.558 
F-statistic: 22.88 on 6 and 98 DF,  p-value: < 2.2e-16



Summary for all days, Tg Neg:

Call:
lm(formula = Average_Latency ~ Day + Weight + SLC_Genotype + 
    Sex, data = subset(data, ASO_Tg == "Negative"))

Residuals:
    Min      1Q  Median      3Q     Max 
-56.237 -16.081  -3.268  14.552  67.386 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)    
(Intercept)     140.2057    13.7369  10.207  < 2e-16 ***
DayTwo           13.2300     5.6001   2.362  0.01986 *  
DayThree         14.9458     5.6001   2.669  0.00873 ** 
Weight           -2.1822     0.3798  -5.746 7.86e-08 ***
SLC_GenotypeHET   5.4733     6.2077   0.882  0.37981    
SLC_GenotypeMUT  -7.5317     7.7078  -0.977  0.33058    
SexMale          -9.7881     5.6444  -1.734  0.08562 .  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 25.04 on 113 degrees of freedom
Multiple R-squared:  0.4057,	Adjusted R-squared:  0.3742 
F-statistic: 12.86 on 6 and 113 DF,  p-value: 4.944e-11



Summary for Day 1, Tg Pos:

Call:
lm(formula = Average_Latency ~ Weight + SLC_Genotype + Sex, data = subset(data, 
    Day == "One" & ASO_Tg == "Positive"))

Residuals:
    Min      1Q  Median      3Q     Max 
-44.764 -16.283  -6.302  21.782  58.489 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)    
(Intercept)     182.9938    25.9513   7.051 7.72e-08 ***
Weight           -3.6533     0.8342  -4.379 0.000133 ***
SLC_GenotypeHET  21.3586    11.7088   1.824 0.078104 .  
SLC_GenotypeMUT  34.7836    12.4839   2.786 0.009155 ** 
SexMale          -3.6429    13.2598  -0.275 0.785405    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 27.44 on 30 degrees of freedom
Multiple R-squared:  0.6266,	Adjusted R-squared:  0.5768 
F-statistic: 12.58 on 4 and 30 DF,  p-value: 3.981e-06



Summary for Day 1, Tg Neg:

Call:
lm(formula = Average_Latency ~ Weight + SLC_Genotype + Sex, data = subset(data, 
    Day == "One" & ASO_Tg == "Negative"))

Residuals:
    Min      1Q  Median      3Q     Max 
-45.763  -8.837  -2.290  11.914  35.647 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)    
(Intercept)     106.1154    16.7691   6.328 2.86e-07 ***
Weight           -1.1840     0.4770  -2.482    0.018 *  
SLC_GenotypeHET  -0.3286     7.7970  -0.042    0.967    
SLC_GenotypeMUT  -4.1847     9.6811  -0.432    0.668    
SexMale          -5.7763     7.0895  -0.815    0.421    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 18.16 on 35 degrees of freedom
Multiple R-squared:  0.2702,	Adjusted R-squared:  0.1868 
F-statistic: 3.239 on 4 and 35 DF,  p-value: 0.02314



Summary for Day 2, Tg Pos:

Call:
lm(formula = Average_Latency ~ Weight + SLC_Genotype + Sex, data = subset(data, 
    Day == "Two" & ASO_Tg == "Positive"))

Residuals:
    Min      1Q  Median      3Q     Max 
-63.582 -18.123  -7.038  21.991  79.731 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)    
(Intercept)      249.520     35.149   7.099 6.79e-08 ***
Weight            -4.852      1.130  -4.294 0.000169 ***
SLC_GenotypeHET    4.659     15.858   0.294 0.770927    
SLC_GenotypeMUT   30.601     16.908   1.810 0.080350 .  
SexMale            3.337     17.959   0.186 0.853856    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 37.16 on 30 degrees of freedom
Multiple R-squared:  0.581,	Adjusted R-squared:  0.5251 
F-statistic:  10.4 on 4 and 30 DF,  p-value: 2.094e-05



Summary for Day 2, Tg Neg:

Call:
lm(formula = Average_Latency ~ Weight + SLC_Genotype + Sex, data = subset(data, 
    Day == "Two" & ASO_Tg == "Negative"))

Residuals:
    Min      1Q  Median      3Q     Max 
-36.767 -16.081  -2.837  11.096  47.289 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)    
(Intercept)     186.3597    20.8438   8.941 1.46e-10 ***
Weight           -3.2465     0.5929  -5.475 3.80e-06 ***
SLC_GenotypeHET   7.0341     9.6916   0.726    0.473    
SLC_GenotypeMUT -14.0396    12.0335  -1.167    0.251    
SexMale          -2.0696     8.8122  -0.235    0.816    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 22.57 on 35 degrees of freedom
Multiple R-squared:  0.5693,	Adjusted R-squared:  0.5201 
F-statistic: 11.57 on 4 and 35 DF,  p-value: 4.346e-06



Summary for Day 3, Tg Pos:

Call:
lm(formula = Average_Latency ~ Weight + SLC_Genotype + Sex, data = subset(data, 
    Day == "Three" & ASO_Tg == "Positive"))

Residuals:
    Min      1Q  Median      3Q     Max 
-56.715 -18.245  -3.817  17.251  91.134 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)    
(Intercept)     222.1598    29.9370   7.421 2.87e-08 ***
Weight           -4.3353     0.9623  -4.505 9.39e-05 ***
SLC_GenotypeHET  10.7067    13.5071   0.793    0.434    
SLC_GenotypeMUT  18.6950    14.4013   1.298    0.204    
SexMale           6.0133    15.2963   0.393    0.697    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 31.65 on 30 degrees of freedom
Multiple R-squared:  0.5565,	Adjusted R-squared:  0.4974 
F-statistic: 9.412 on 4 and 30 DF,  p-value: 4.716e-05



Summary for Day 3, Tg Neg:

Call:
lm(formula = Average_Latency ~ Weight + SLC_Genotype + Sex, data = subset(data, 
    Day == "Three" & ASO_Tg == "Negative"))

Residuals:
    Min      1Q  Median      3Q     Max 
-63.571 -21.244  -3.596  17.352  71.142 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)    
(Intercept)     156.3178    29.2509   5.344 5.66e-06 ***
Weight           -2.1163     0.8321  -2.543   0.0156 *  
SLC_GenotypeHET   9.7145    13.6006   0.714   0.4798    
SLC_GenotypeMUT  -4.3708    16.8871  -0.259   0.7973    
SexMale         -21.5185    12.3665  -1.740   0.0906 .  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 31.68 on 35 degrees of freedom
Multiple R-squared:  0.3804,	Adjusted R-squared:  0.3096 
F-statistic: 5.371 on 4 and 35 DF,  p-value: 0.001763

