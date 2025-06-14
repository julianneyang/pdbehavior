## Longitudinal Colon
With repeated measures
```R
Permutation: free
Number of permutations: 0

Terms added sequentially (first to last)

          Df SumsOfSqs MeanSqs F.Model      R2    Pr(>F)    
Sex        1    0.2744 0.27439  3.0878 0.03830    0.0018 ** 
Genotype   2    0.2296 0.11481  1.2920 0.03205    0.2458    
Study      1    1.7737 1.77365 19.9592 0.24754 9.999e-05 ***
Residuals 55    4.8875 0.08886         0.68212 9.999e-05 ***
Total     59    7.1652                 1.00000              
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```

## Jejunum
### Sex and Genotype Interaction
```R
> data.adonis$aov.tab
Permutation: free
Number of permutations: 10000

Terms added sequentially (first to last)

          Df SumsOfSqs MeanSqs F.Model      R2 Pr(>F)    
Sex        1    0.7714 0.77138  5.4384 0.14285 0.0004 ***
Genotype   2    0.3734 0.18671  1.3164 0.06915 0.2173    
Residuals 30    4.2552 0.14184         0.78800           
Total     33    5.4000                 1.00000           
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```
### Sex-Genotype Interaction
```R
> data.adonis$aov.tab
Permutation: free
Number of permutations: 10000

Terms added sequentially (first to last)

             Df SumsOfSqs MeanSqs F.Model      R2    Pr(>F)    
Sex           1    0.7714 0.77138  5.8142 0.14285 0.0009999 ***
Genotype      2    0.3734 0.18671  1.4073 0.06915 0.1815818    
Sex:Genotype  2    0.5404 0.27019  2.0365 0.10007 0.0464954 *  
Residuals    28    3.7148 0.13267         0.68793              
Total        33    5.4000                 1.00000              
---
```

## Baseline
### Genotype
```R
> data.adonis$aov.tab
Permutation: free
Number of permutations: 10000

Terms added sequentially (first to last)

          Df SumsOfSqs  MeanSqs F.Model      R2  Pr(>F)    
Sex        1   0.20893 0.208933  3.7310 0.14036 0.00030 ***
Genotype   2   0.15964 0.079818  1.4253 0.10724 0.09399 .  
Residuals 20   1.11999 0.055999         0.75240            
Total     23   1.48856                  1.00000            
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```
### Sex-Genotype Interaction
```R
> data.adonis$aov.tab
Permutation: free
Number of permutations: 10000

Terms added sequentially (first to last)

          Df SumsOfSqs  MeanSqs F.Model      R2  Pr(>F)    
Sex        1   0.20893 0.208933  3.7310 0.14036 0.00030 ***
Genotype   2   0.15964 0.079818  1.4253 0.10724 0.09399 .  
Residuals 20   1.11999 0.055999         0.75240            
Total     23   1.48856                  1.00000            
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```

## Cecum
### Genotype
```R
> data.adonis$aov.tab
Permutation: free
Number of permutations: 10000

Terms added sequentially (first to last)

          Df SumsOfSqs MeanSqs F.Model      R2 Pr(>F)  
Sex        1    0.2662 0.26616  1.8155 0.05130 0.0205 *
Genotype   2    0.3777 0.18886  1.2882 0.07280 0.1149  
Residuals 31    4.5449 0.14661         0.87591         
Total     34    5.1887                 1.00000         
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```

### Sex-Genotype Interaction
```R
> data.adonis$aov.tab
Permutation: free
Number of permutations: 10000

Terms added sequentially (first to last)

             Df SumsOfSqs MeanSqs F.Model      R2  Pr(>F)  
Sex           1    0.2662 0.26616  1.8844 0.05130 0.01550 *
Genotype      2    0.3777 0.18886  1.3372 0.07280 0.08419 .
Sex:Genotype  2    0.4489 0.22444  1.5891 0.08651 0.01760 *
Residuals    29    4.0960 0.14124         0.78940          
Total        34    5.1887                 1.00000          
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```

## Colon
### Genotype
```R
> data.adonis$aov.tab
Permutation: free
Number of permutations: 10000

Terms added sequentially (first to last)

          Df SumsOfSqs MeanSqs F.Model      R2 Pr(>F)  
Sex        1     7.249  7.2489  3.7455 0.09966 0.0269 *
Genotype   2     3.556  1.7778  0.9186 0.04888 0.4665  
Residuals 32    61.932  1.9354         0.85146         
Total     35    72.737                 1.00000         
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```
### Sex-Genotype Interaction
```R
> data.adonis$aov.tab 
Permutation: free
Number of permutations: 10000

Terms added sequentially (first to last)

             Df SumsOfSqs MeanSqs F.Model      R2 Pr(>F)  
Sex           1     7.249  7.2489  3.6149 0.09966 0.0306 *
Genotype      2     3.556  1.7778  0.8866 0.04888 0.4647  
Sex:Genotype  2     1.774  0.8868  0.4422 0.02438 0.7908  
Residuals    30    60.159  2.0053         0.82707         
Total        35    72.737                 1.00000         
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```