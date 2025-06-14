Luminal Colon
```
> set.seed(11)
> data.adonis=adonis2(data.dist ~ Sex + Site + Genotype, data=metadata, by="terms",permutations=10000)
> data.adonis
Permutation test for adonis under reduced model
Terms added sequentially (first to last)
Permutation: free
Number of permutations: 10000

adonis2(formula = data.dist ~ Sex + Site + Genotype, data = metadata, permutations = 10000, by = "terms")
         Df SumOfSqs      R2      F    Pr(>F)    
Sex       1   0.2698 0.04315 3.0180 9.999e-05 ***
Site      1   0.2331 0.03728 2.6077     4e-04 ***
Genotype  2   0.3864 0.06180 2.1612 9.999e-05 ***
Residual 60   5.3642 0.85778                     
Total    64   6.2536 1.00000                     
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```

Colon 
```
> data.adonis=adonis2(data.dist ~ Sex+ Genotype, data=metadata, by="terms",permutations=10000)
> data.adonis
Permutation test for adonis under reduced model
Terms added sequentially (first to last)
Permutation: free
Number of permutations: 10000

adonis2(formula = data.dist ~ Sex + Genotype, data = metadata, permutations = 10000, by = "terms")
         Df SumOfSqs      R2      F  Pr(>F)  
Sex       1  0.15573 0.05538 1.7975 0.01120 *
Genotype  2  0.23040 0.08194 1.3298 0.05899 .
Residual 28  2.42577 0.86268                 
Total    31  2.81190 1.00000                 
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```

Cecum
```
> data.adonis=adonis2(data.dist ~ Sex+ Genotype, data=metadata, by="terms",permutations=10000)
> data.adonis
Permutation test for adonis under reduced model
Terms added sequentially (first to last)
Permutation: free
Number of permutations: 10000

adonis2(formula = data.dist ~ Sex + Genotype, data = metadata, permutations = 10000, by = "terms")
         Df SumOfSqs      R2      F  Pr(>F)  
Sex       1   0.1467 0.04428 1.4571 0.03300 *
Genotype  2   0.2467 0.07449 1.2257 0.08699 .
Residual 29   2.9188 0.88123                 
Total    32   3.3122 1.00000                 
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```

Jejunum
```
> data.adonis=adonis2(data.dist ~ Sex+ Genotype, data=metadata, by="terms",permutations=10000)
> data.adonis
Permutation test for adonis under reduced model
Terms added sequentially (first to last)
Permutation: free
Number of permutations: 10000

adonis2(formula = data.dist ~ Sex + Genotype, data = metadata, permutations = 10000, by = "terms")
         Df SumOfSqs      R2      F Pr(>F)
Sex       1   0.1887 0.04629 1.4706  0.145
Genotype  2   0.1666 0.04085 0.6489  0.880
Residual 29   3.7221 0.91286              
Total    32   4.0774 1.00000
```