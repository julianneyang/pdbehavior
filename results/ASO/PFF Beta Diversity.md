```r
> data.adonis=adonis2(data.dist ~ Sex + Study + Genotype, data=metadata, by="terms",permutations=10000)
> data.adonis
Permutation test for adonis under reduced model
Terms added sequentially (first to last)
Permutation: free
Number of permutations: 10000

adonis2(formula = data.dist ~ Sex + Study + Genotype, data = metadata, permutations = 10000, by = "terms")
         Df SumOfSqs      R2      F    Pr(>F)    
Sex       1   0.3569 0.04533 3.5648 9.999e-05 ***
Study     1   0.4239 0.05384 4.2339 9.999e-05 ***
Genotype  2   0.4847 0.06156 2.4207 9.999e-05 ***
Residual 66   6.6076 0.83927                     
Total    70   7.8730 1.00000                     
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```

```r
> data.adonis=adonis2(data.dist ~ Average_Latency,  data=metadata, by="terms",permutations=10000)
> data.adonis
Permutation test for adonis under reduced model
Terms added sequentially (first to last)
Permutation: free
Number of permutations: 10000

adonis2(formula = data.dist ~ Average_Latency, data = metadata, permutations = 10000, by = "terms")
                Df SumOfSqs      R2      F   Pr(>F)   
Average_Latency  1   0.2298 0.02919 2.0745 0.007499 **
Residual        69   7.6432 0.97081                   
Total           70   7.8730 1.00000                   
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```