

Summary for all data:
Linear mixed-effects model fit by REML
  Data: data_long 
       AIC      BIC    logLik
  2043.802 2093.006 -1009.901

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    3.084915 1.748682

Fixed effects:  FP_output ~ timepoint + ASO_Tg + Sex + SLC_Genotype 
                    Value Std.Error  DF   t-value p-value
(Intercept)      2.560527 0.9837678 375  2.602776  0.0096
timepoint10      1.473684 0.2836737 375  5.194998  0.0000
timepoint15      2.592105 0.2836737 375  9.137630  0.0000
timepoint30      4.394737 0.2836737 375 15.492226  0.0000
timepoint45      5.671053 0.2836737 375 19.991465  0.0000
timepoint60      6.776316 0.2836737 375 23.887714  0.0000
ASO_TgPositive  -0.609948 0.7452987  71 -0.818395  0.4159
SexMale         -0.753162 0.7478926  71 -1.007046  0.3173
SLC_GenotypeHET  1.233289 0.9241461  71  1.334518  0.1863
SLC_GenotypeMUT -0.524383 1.0691898  71 -0.490449  0.6253
 Correlation: 
                (Intr) tmpn10 tmpn15 tmpn30 tmpn45 tmpn60 ASO_TP
timepoint10     -0.144                                          
timepoint15     -0.144  0.500                                   
timepoint30     -0.144  0.500  0.500                            
timepoint45     -0.144  0.500  0.500  0.500                     
timepoint60     -0.144  0.500  0.500  0.500  0.500              
ASO_TgPositive  -0.442  0.000  0.000  0.000  0.000  0.000       
SexMale         -0.444  0.000  0.000  0.000  0.000  0.000  0.103
SLC_GenotypeHET -0.687  0.000  0.000  0.000  0.000  0.000  0.121
SLC_GenotypeMUT -0.612  0.000  0.000  0.000  0.000  0.000 -0.019
                SexMal SLC_GH
timepoint10                  
timepoint15                  
timepoint30                  
timepoint45                  
timepoint60                  
ASO_TgPositive               
SexMale                      
SLC_GenotypeHET -0.024       
SLC_GenotypeMUT  0.146  0.589

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3         Max 
-2.81067409 -0.62689950  0.01443301  0.55330909  3.23136496 

Number of Observations: 456
Number of Groups: 76 


Summary for all data, non parametric:

	Kruskal-Wallis rank sum test

data:  FP_output by ASO_Tg
Kruskal-Wallis chi-squared = 3.2056, df = 1, p-value =
0.07339



Summary for all data, time*ASO:
Linear mixed-effects model fit by REML
  Data: data_long 
      AIC      BIC    logLik
  2049.93 2119.444 -1007.965

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    3.084241 1.755801

Fixed effects:  FP_output ~ timepoint * ASO_Tg + Sex + SLC_Genotype 
                               Value Std.Error  DF   t-value
(Intercept)                 2.602087 0.9984633 370  2.606092
timepoint10                 1.439024 0.3877916 370  3.710819
timepoint15                 2.365854 0.3877916 370  6.100838
timepoint30                 4.268293 0.3877916 370 11.006667
timepoint45                 5.756098 0.3877916 370 14.843277
timepoint60                 6.829268 0.3877916 370 17.610668
ASO_TgPositive             -0.700192 0.8315830  71 -0.841999
SexMale                    -0.753162 0.7478926  71 -1.007046
SLC_GenotypeHET             1.233289 0.9241461  71  1.334518
SLC_GenotypeMUT            -0.524383 1.0691898  71 -0.490449
timepoint10:ASO_TgPositive  0.075261 0.5714406 370  0.131705
timepoint15:ASO_TgPositive  0.491289 0.5714406 370  0.859738
timepoint30:ASO_TgPositive  0.274564 0.5714406 370  0.480478
timepoint45:ASO_TgPositive -0.184669 0.5714406 370 -0.323164
timepoint60:ASO_TgPositive -0.114983 0.5714406 370 -0.201215
                           p-value
(Intercept)                 0.0095
timepoint10                 0.0002
timepoint15                 0.0000
timepoint30                 0.0000
timepoint45                 0.0000
timepoint60                 0.0000
ASO_TgPositive              0.4026
SexMale                     0.3173
SLC_GenotypeHET             0.1863
SLC_GenotypeMUT             0.6253
timepoint10:ASO_TgPositive  0.8953
timepoint15:ASO_TgPositive  0.3905
timepoint30:ASO_TgPositive  0.6312
timepoint45:ASO_TgPositive  0.7468
timepoint60:ASO_TgPositive  0.8406
 Correlation: 
                           (Intr) tmpn10 tmpn15 tmpn30 tmpn45
timepoint10                -0.194                            
timepoint15                -0.194  0.500                     
timepoint30                -0.194  0.500  0.500              
timepoint45                -0.194  0.500  0.500  0.500       
timepoint60                -0.194  0.500  0.500  0.500  0.500
ASO_TgPositive             -0.466  0.233  0.233  0.233  0.233
SexMale                    -0.437  0.000  0.000  0.000  0.000
SLC_GenotypeHET            -0.677  0.000  0.000  0.000  0.000
SLC_GenotypeMUT            -0.603  0.000  0.000  0.000  0.000
timepoint10:ASO_TgPositive  0.132 -0.679 -0.339 -0.339 -0.339
timepoint15:ASO_TgPositive  0.132 -0.339 -0.679 -0.339 -0.339
timepoint30:ASO_TgPositive  0.132 -0.339 -0.339 -0.679 -0.339
timepoint45:ASO_TgPositive  0.132 -0.339 -0.339 -0.339 -0.679
timepoint60:ASO_TgPositive  0.132 -0.339 -0.339 -0.339 -0.339
                           tmpn60 ASO_TP SexMal SLC_GH SLC_GM
timepoint10                                                  
timepoint15                                                  
timepoint30                                                  
timepoint45                                                  
timepoint60                                                  
ASO_TgPositive              0.233                            
SexMale                     0.000  0.092                     
SLC_GenotypeHET             0.000  0.108 -0.024              
SLC_GenotypeMUT             0.000 -0.017  0.146  0.589       
timepoint10:ASO_TgPositive -0.339 -0.344  0.000  0.000  0.000
timepoint15:ASO_TgPositive -0.339 -0.344  0.000  0.000  0.000
timepoint30:ASO_TgPositive -0.339 -0.344  0.000  0.000  0.000
timepoint45:ASO_TgPositive -0.339 -0.344  0.000  0.000  0.000
timepoint60:ASO_TgPositive -0.679 -0.344  0.000  0.000  0.000
                           t10:AS t15:AS t30:AS t45:AS
timepoint10                                           
timepoint15                                           
timepoint30                                           
timepoint45                                           
timepoint60                                           
ASO_TgPositive                                        
SexMale                                               
SLC_GenotypeHET                                       
SLC_GenotypeMUT                                       
timepoint10:ASO_TgPositive                            
timepoint15:ASO_TgPositive  0.500                     
timepoint30:ASO_TgPositive  0.500  0.500              
timepoint45:ASO_TgPositive  0.500  0.500  0.500       
timepoint60:ASO_TgPositive  0.500  0.500  0.500  0.500

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3         Max 
-2.82248168 -0.57869199  0.01385993  0.51485300  3.28260037 

Number of Observations: 456
Number of Groups: 76 


Summary for all data, SLC*ASO:
Linear mixed-effects model fit by REML
  Data: data_long 
       AIC     BIC    logLik
  2041.569 2098.91 -1006.784

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    3.126233 1.748682

Fixed effects:  FP_output ~ timepoint + ASO_Tg * SLC_Genotype + Sex 
                                   Value Std.Error  DF   t-value
(Intercept)                     2.912095 1.2423616 375  2.344000
timepoint10                     1.473684 0.2836737 375  5.194998
timepoint15                     2.592105 0.2836737 375  9.137630
timepoint30                     4.394737 0.2836737 375 15.492226
timepoint45                     5.671053 0.2836737 375 19.991465
timepoint60                     6.776316 0.2836737 375 23.887714
ASO_TgPositive                 -1.259060 1.5641826  69 -0.804931
SLC_GenotypeHET                 0.830797 1.3027092  69  0.637745
SLC_GenotypeMUT                -1.025364 1.6145201  69 -0.635089
SexMale                        -0.768125 0.7582043  69 -1.013084
ASO_TgPositive:SLC_GenotypeHET  0.807851 1.8794239  69  0.429840
ASO_TgPositive:SLC_GenotypeMUT  0.915350 2.1567657  69  0.424409
                               p-value
(Intercept)                     0.0196
timepoint10                     0.0000
timepoint15                     0.0000
timepoint30                     0.0000
timepoint45                     0.0000
timepoint60                     0.0000
ASO_TgPositive                  0.4236
SLC_GenotypeHET                 0.5258
SLC_GenotypeMUT                 0.5275
SexMale                         0.3146
ASO_TgPositive:SLC_GenotypeHET  0.6687
ASO_TgPositive:SLC_GenotypeMUT  0.6726
 Correlation: 
                               (Intr) tmpn10 tmpn15 tmpn30 tmpn45
timepoint10                    -0.114                            
timepoint15                    -0.114  0.500                     
timepoint30                    -0.114  0.500  0.500              
timepoint45                    -0.114  0.500  0.500  0.500       
timepoint60                    -0.114  0.500  0.500  0.500  0.500
ASO_TgPositive                 -0.695  0.000  0.000  0.000  0.000
SLC_GenotypeHET                -0.800  0.000  0.000  0.000  0.000
SLC_GenotypeMUT                -0.686  0.000  0.000  0.000  0.000
SexMale                        -0.381  0.000  0.000  0.000  0.000
ASO_TgPositive:SLC_GenotypeHET  0.568  0.000  0.000  0.000  0.000
ASO_TgPositive:SLC_GenotypeMUT  0.490  0.000  0.000  0.000  0.000
                               tmpn60 ASO_TgP SLC_GH SLC_GM
timepoint10                                                
timepoint15                                                
timepoint30                                                
timepoint45                                                
timepoint60                                                
ASO_TgPositive                  0.000                      
SLC_GenotypeHET                 0.000  0.632               
SLC_GenotypeMUT                 0.000  0.519   0.613       
SexMale                         0.000  0.088   0.015  0.117
ASO_TgPositive:SLC_GenotypeHET  0.000 -0.830  -0.694 -0.429
ASO_TgPositive:SLC_GenotypeMUT  0.000 -0.722  -0.458 -0.741
                               SexMal ASO_TP:SLC_GH
timepoint10                                        
timepoint15                                        
timepoint30                                        
timepoint45                                        
timepoint60                                        
ASO_TgPositive                                     
SLC_GenotypeHET                                    
SLC_GenotypeMUT                                    
SexMale                                            
ASO_TgPositive:SLC_GenotypeHET -0.046              
ASO_TgPositive:SLC_GenotypeMUT -0.028  0.600       

Standardized Within-Group Residuals:
         Min           Q1          Med           Q3          Max 
-2.810239242 -0.623768819  0.007815593  0.555802213  3.224120039 

Number of Observations: 456
Number of Groups: 76 


Summary for Tg Pos:
Linear mixed-effects model fit by REML
  Data: pos 
       AIC      BIC    logLik
  919.5351 987.8329 -438.7676

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    3.117654 1.650446

Fixed effects:  FP_output ~ Sex + timepoint * SLC_Genotype 
                                Value Std.Error  DF   t-value
(Intercept)                  1.863695 1.2765582 160  1.459937
SexMale                     -0.193313 1.1181463  31 -0.172887
timepoint10                  1.333333 0.7780279 160  1.713735
timepoint15                  2.000000 0.7780279 160  2.570602
timepoint30                  3.888889 0.7780279 160  4.998393
timepoint45                  4.888889 0.7780279 160  6.283694
timepoint60                  6.000000 0.7780279 160  7.711806
SLC_GenotypeHET              0.906072 1.4906706  31  0.607829
SLC_GenotypeMUT             -0.720064 1.5971075  31 -0.450855
timepoint10:SLC_GenotypeHET  0.533333 0.9841360 160  0.541930
timepoint15:SLC_GenotypeHET  1.200000 0.9841360 160  1.219344
timepoint30:SLC_GenotypeHET  0.844444 0.9841360 160  0.858057
timepoint45:SLC_GenotypeHET  0.777778 0.9841360 160  0.790315
timepoint60:SLC_GenotypeHET  0.733333 0.9841360 160  0.745154
timepoint10:SLC_GenotypeMUT -0.151515 1.0490925 160 -0.144425
timepoint15:SLC_GenotypeMUT  1.090909 1.0490925 160  1.039860
timepoint30:SLC_GenotypeMUT  0.929293 1.0490925 160  0.885806
timepoint45:SLC_GenotypeMUT  1.111111 1.0490925 160  1.059116
timepoint60:SLC_GenotypeMUT  1.272727 1.0490925 160  1.213170
                            p-value
(Intercept)                  0.1463
SexMale                      0.8639
timepoint10                  0.0885
timepoint15                  0.0111
timepoint30                  0.0000
timepoint45                  0.0000
timepoint60                  0.0000
SLC_GenotypeHET              0.5477
SLC_GenotypeMUT              0.6552
timepoint10:SLC_GenotypeHET  0.5886
timepoint15:SLC_GenotypeHET  0.2245
timepoint30:SLC_GenotypeHET  0.3921
timepoint45:SLC_GenotypeHET  0.4305
timepoint60:SLC_GenotypeHET  0.4573
timepoint10:SLC_GenotypeMUT  0.8853
timepoint15:SLC_GenotypeMUT  0.3000
timepoint30:SLC_GenotypeMUT  0.3771
timepoint45:SLC_GenotypeMUT  0.2911
timepoint60:SLC_GenotypeMUT  0.2269
 Correlation: 
                            (Intr) SexMal tmpn10 tmpn15 tmpn30
SexMale                     -0.389                            
timepoint10                 -0.305  0.000                     
timepoint15                 -0.305  0.000  0.500              
timepoint30                 -0.305  0.000  0.500  0.500       
timepoint45                 -0.305  0.000  0.500  0.500  0.500
timepoint60                 -0.305  0.000  0.500  0.500  0.500
SLC_GenotypeHET             -0.701 -0.067  0.261  0.261  0.261
SLC_GenotypeMUT             -0.725  0.120  0.244  0.244  0.244
timepoint10:SLC_GenotypeHET  0.241  0.000 -0.791 -0.395 -0.395
timepoint15:SLC_GenotypeHET  0.241  0.000 -0.395 -0.791 -0.395
timepoint30:SLC_GenotypeHET  0.241  0.000 -0.395 -0.395 -0.791
timepoint45:SLC_GenotypeHET  0.241  0.000 -0.395 -0.395 -0.395
timepoint60:SLC_GenotypeHET  0.241  0.000 -0.395 -0.395 -0.395
timepoint10:SLC_GenotypeMUT  0.226  0.000 -0.742 -0.371 -0.371
timepoint15:SLC_GenotypeMUT  0.226  0.000 -0.371 -0.742 -0.371
timepoint30:SLC_GenotypeMUT  0.226  0.000 -0.371 -0.371 -0.742
timepoint45:SLC_GenotypeMUT  0.226  0.000 -0.371 -0.371 -0.371
timepoint60:SLC_GenotypeMUT  0.226  0.000 -0.371 -0.371 -0.371
                            tmpn45 tmpn60 SLC_GH SLC_GM
SexMale                                                
timepoint10                                            
timepoint15                                            
timepoint30                                            
timepoint45                                            
timepoint60                  0.500                     
SLC_GenotypeHET              0.261  0.261              
SLC_GenotypeMUT              0.244  0.244  0.573       
timepoint10:SLC_GenotypeHET -0.395 -0.395 -0.330 -0.193
timepoint15:SLC_GenotypeHET -0.395 -0.395 -0.330 -0.193
timepoint30:SLC_GenotypeHET -0.395 -0.395 -0.330 -0.193
timepoint45:SLC_GenotypeHET -0.791 -0.395 -0.330 -0.193
timepoint60:SLC_GenotypeHET -0.395 -0.791 -0.330 -0.193
timepoint10:SLC_GenotypeMUT -0.371 -0.371 -0.194 -0.328
timepoint15:SLC_GenotypeMUT -0.371 -0.371 -0.194 -0.328
timepoint30:SLC_GenotypeMUT -0.371 -0.371 -0.194 -0.328
timepoint45:SLC_GenotypeMUT -0.742 -0.371 -0.194 -0.328
timepoint60:SLC_GenotypeMUT -0.371 -0.742 -0.194 -0.328
                            t10:SLC_GH t15:SLC_GH t30:SLC_GH
SexMale                                                     
timepoint10                                                 
timepoint15                                                 
timepoint30                                                 
timepoint45                                                 
timepoint60                                                 
SLC_GenotypeHET                                             
SLC_GenotypeMUT                                             
timepoint10:SLC_GenotypeHET                                 
timepoint15:SLC_GenotypeHET  0.500                          
timepoint30:SLC_GenotypeHET  0.500      0.500               
timepoint45:SLC_GenotypeHET  0.500      0.500      0.500    
timepoint60:SLC_GenotypeHET  0.500      0.500      0.500    
timepoint10:SLC_GenotypeMUT  0.586      0.293      0.293    
timepoint15:SLC_GenotypeMUT  0.293      0.586      0.293    
timepoint30:SLC_GenotypeMUT  0.293      0.293      0.586    
timepoint45:SLC_GenotypeMUT  0.293      0.293      0.293    
timepoint60:SLC_GenotypeMUT  0.293      0.293      0.293    
                            t45:SLC_GH t60:SLC_GH t10:SLC_GM
SexMale                                                     
timepoint10                                                 
timepoint15                                                 
timepoint30                                                 
timepoint45                                                 
timepoint60                                                 
SLC_GenotypeHET                                             
SLC_GenotypeMUT                                             
timepoint10:SLC_GenotypeHET                                 
timepoint15:SLC_GenotypeHET                                 
timepoint30:SLC_GenotypeHET                                 
timepoint45:SLC_GenotypeHET                                 
timepoint60:SLC_GenotypeHET  0.500                          
timepoint10:SLC_GenotypeMUT  0.293      0.293               
timepoint15:SLC_GenotypeMUT  0.293      0.293      0.500    
timepoint30:SLC_GenotypeMUT  0.293      0.293      0.500    
timepoint45:SLC_GenotypeMUT  0.586      0.293      0.500    
timepoint60:SLC_GenotypeMUT  0.293      0.586      0.500    
                            t15:SLC_GM t30:SLC_GM t45:SLC_GM
SexMale                                                     
timepoint10                                                 
timepoint15                                                 
timepoint30                                                 
timepoint45                                                 
timepoint60                                                 
SLC_GenotypeHET                                             
SLC_GenotypeMUT                                             
timepoint10:SLC_GenotypeHET                                 
timepoint15:SLC_GenotypeHET                                 
timepoint30:SLC_GenotypeHET                                 
timepoint45:SLC_GenotypeHET                                 
timepoint60:SLC_GenotypeHET                                 
timepoint10:SLC_GenotypeMUT                                 
timepoint15:SLC_GenotypeMUT                                 
timepoint30:SLC_GenotypeMUT  0.500                          
timepoint45:SLC_GenotypeMUT  0.500      0.500               
timepoint60:SLC_GenotypeMUT  0.500      0.500      0.500    

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3         Max 
-2.27465021 -0.57235726  0.02441021  0.49067136  3.25061674 

Number of Observations: 210
Number of Groups: 35 


Summary for Tg Neg:
Linear mixed-effects model fit by REML
  Data: neg 
       AIC     BIC    logLik
  1132.456 1204.38 -545.2279

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    3.148865 1.903275

Fixed effects:  FP_output ~ Sex + timepoint * SLC_Genotype 
                                Value Std.Error  DF   t-value
(Intercept)                  3.404915 1.4538447 190  2.342007
SexMale                     -1.247863 1.0386923  37 -1.201379
timepoint10                  1.000000 0.9516376 190  1.050820
timepoint15                  2.250000 0.9516376 190  2.364346
timepoint30                  4.000000 0.9516376 190  4.203281
timepoint45                  5.875000 0.9516376 190  6.173569
timepoint60                  6.625000 0.9516376 190  6.961684
SLC_GenotypeHET              0.623803 1.4947953  37  0.417317
SLC_GenotypeMUT             -1.311966 1.8579242  37 -0.706146
timepoint10:SLC_GenotypeHET  0.480000 1.0933483 190  0.439018
timepoint15:SLC_GenotypeHET  0.150000 1.0933483 190  0.137193
timepoint30:SLC_GenotypeHET  0.280000 1.0933483 190  0.256094
timepoint45:SLC_GenotypeHET -0.075000 1.0933483 190 -0.068597
timepoint60:SLC_GenotypeHET  0.335000 1.0933483 190  0.306398
timepoint10:SLC_GenotypeMUT  0.750000 1.3458187 190  0.557282
timepoint15:SLC_GenotypeMUT  0.125000 1.3458187 190  0.092880
timepoint30:SLC_GenotypeMUT  0.500000 1.3458187 190  0.371521
timepoint45:SLC_GenotypeMUT -0.375000 1.3458187 190 -0.278641
timepoint60:SLC_GenotypeMUT  0.000000 1.3458187 190  0.000000
                            p-value
(Intercept)                  0.0202
SexMale                      0.2372
timepoint10                  0.2947
timepoint15                  0.0191
timepoint30                  0.0000
timepoint45                  0.0000
timepoint60                  0.0000
SLC_GenotypeHET              0.6789
SLC_GenotypeMUT              0.4845
timepoint10:SLC_GenotypeHET  0.6611
timepoint15:SLC_GenotypeHET  0.8910
timepoint30:SLC_GenotypeHET  0.7982
timepoint45:SLC_GenotypeHET  0.9454
timepoint60:SLC_GenotypeHET  0.7596
timepoint10:SLC_GenotypeMUT  0.5780
timepoint15:SLC_GenotypeMUT  0.9261
timepoint30:SLC_GenotypeMUT  0.7107
timepoint45:SLC_GenotypeMUT  0.7808
timepoint60:SLC_GenotypeMUT  1.0000
 Correlation: 
                            (Intr) SexMal tmpn10 tmpn15 tmpn30
SexMale                     -0.447                            
timepoint10                 -0.327  0.000                     
timepoint15                 -0.327  0.000  0.500              
timepoint30                 -0.327  0.000  0.500  0.500       
timepoint45                 -0.327  0.000  0.500  0.500  0.500
timepoint60                 -0.327  0.000  0.500  0.500  0.500
SLC_GenotypeHET             -0.786  0.017  0.318  0.318  0.318
SLC_GenotypeMUT             -0.689  0.140  0.256  0.256  0.256
timepoint10:SLC_GenotypeHET  0.285  0.000 -0.870 -0.435 -0.435
timepoint15:SLC_GenotypeHET  0.285  0.000 -0.435 -0.870 -0.435
timepoint30:SLC_GenotypeHET  0.285  0.000 -0.435 -0.435 -0.870
timepoint45:SLC_GenotypeHET  0.285  0.000 -0.435 -0.435 -0.435
timepoint60:SLC_GenotypeHET  0.285  0.000 -0.435 -0.435 -0.435
timepoint10:SLC_GenotypeMUT  0.231  0.000 -0.707 -0.354 -0.354
timepoint15:SLC_GenotypeMUT  0.231  0.000 -0.354 -0.707 -0.354
timepoint30:SLC_GenotypeMUT  0.231  0.000 -0.354 -0.354 -0.707
timepoint45:SLC_GenotypeMUT  0.231  0.000 -0.354 -0.354 -0.354
timepoint60:SLC_GenotypeMUT  0.231  0.000 -0.354 -0.354 -0.354
                            tmpn45 tmpn60 SLC_GH SLC_GM
SexMale                                                
timepoint10                                            
timepoint15                                            
timepoint30                                            
timepoint45                                            
timepoint60                  0.500                     
SLC_GenotypeHET              0.318  0.318              
SLC_GenotypeMUT              0.256  0.256  0.612       
timepoint10:SLC_GenotypeHET -0.435 -0.435 -0.366 -0.223
timepoint15:SLC_GenotypeHET -0.435 -0.435 -0.366 -0.223
timepoint30:SLC_GenotypeHET -0.435 -0.435 -0.366 -0.223
timepoint45:SLC_GenotypeHET -0.870 -0.435 -0.366 -0.223
timepoint60:SLC_GenotypeHET -0.435 -0.870 -0.366 -0.223
timepoint10:SLC_GenotypeMUT -0.354 -0.354 -0.225 -0.362
timepoint15:SLC_GenotypeMUT -0.354 -0.354 -0.225 -0.362
timepoint30:SLC_GenotypeMUT -0.354 -0.354 -0.225 -0.362
timepoint45:SLC_GenotypeMUT -0.707 -0.354 -0.225 -0.362
timepoint60:SLC_GenotypeMUT -0.354 -0.707 -0.225 -0.362
                            t10:SLC_GH t15:SLC_GH t30:SLC_GH
SexMale                                                     
timepoint10                                                 
timepoint15                                                 
timepoint30                                                 
timepoint45                                                 
timepoint60                                                 
SLC_GenotypeHET                                             
SLC_GenotypeMUT                                             
timepoint10:SLC_GenotypeHET                                 
timepoint15:SLC_GenotypeHET  0.500                          
timepoint30:SLC_GenotypeHET  0.500      0.500               
timepoint45:SLC_GenotypeHET  0.500      0.500      0.500    
timepoint60:SLC_GenotypeHET  0.500      0.500      0.500    
timepoint10:SLC_GenotypeMUT  0.615      0.308      0.308    
timepoint15:SLC_GenotypeMUT  0.308      0.615      0.308    
timepoint30:SLC_GenotypeMUT  0.308      0.308      0.615    
timepoint45:SLC_GenotypeMUT  0.308      0.308      0.308    
timepoint60:SLC_GenotypeMUT  0.308      0.308      0.308    
                            t45:SLC_GH t60:SLC_GH t10:SLC_GM
SexMale                                                     
timepoint10                                                 
timepoint15                                                 
timepoint30                                                 
timepoint45                                                 
timepoint60                                                 
SLC_GenotypeHET                                             
SLC_GenotypeMUT                                             
timepoint10:SLC_GenotypeHET                                 
timepoint15:SLC_GenotypeHET                                 
timepoint30:SLC_GenotypeHET                                 
timepoint45:SLC_GenotypeHET                                 
timepoint60:SLC_GenotypeHET  0.500                          
timepoint10:SLC_GenotypeMUT  0.308      0.308               
timepoint15:SLC_GenotypeMUT  0.308      0.308      0.500    
timepoint30:SLC_GenotypeMUT  0.308      0.308      0.500    
timepoint45:SLC_GenotypeMUT  0.615      0.308      0.500    
timepoint60:SLC_GenotypeMUT  0.308      0.615      0.500    
                            t15:SLC_GM t30:SLC_GM t45:SLC_GM
SexMale                                                     
timepoint10                                                 
timepoint15                                                 
timepoint30                                                 
timepoint45                                                 
timepoint60                                                 
SLC_GenotypeHET                                             
SLC_GenotypeMUT                                             
timepoint10:SLC_GenotypeHET                                 
timepoint15:SLC_GenotypeHET                                 
timepoint30:SLC_GenotypeHET                                 
timepoint45:SLC_GenotypeHET                                 
timepoint60:SLC_GenotypeHET                                 
timepoint10:SLC_GenotypeMUT                                 
timepoint15:SLC_GenotypeMUT                                 
timepoint30:SLC_GenotypeMUT  0.500                          
timepoint45:SLC_GenotypeMUT  0.500      0.500               
timepoint60:SLC_GenotypeMUT  0.500      0.500      0.500    

Standardized Within-Group Residuals:
       Min         Q1        Med         Q3        Max 
-2.5667337 -0.5996178  0.0127095  0.5373774  2.8688778 

Number of Observations: 246
Number of Groups: 41 


Summary for Males Tg Pos:
Linear mixed-effects model fit by REML
  Data: pos_males 
      AIC      BIC   logLik
  362.762 408.2953 -161.381

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    2.576963  1.46956

Fixed effects:  FP_output ~ timepoint * SLC_Genotype 
                                Value Std.Error DF   t-value
(Intercept)                  1.750000  1.483269 60  1.179826
timepoint10                  2.000000  1.039136 60  1.924676
timepoint15                  2.750000  1.039136 60  2.646430
timepoint30                  4.750000  1.039136 60  4.571106
timepoint45                  5.500000  1.039136 60  5.292860
timepoint60                  7.250000  1.039136 60  6.976951
SLC_GenotypeHET              1.625000  1.816626 12  0.894515
SLC_GenotypeMUT             -1.750000  2.265731 12 -0.772378
timepoint10:SLC_GenotypeHET  0.000000  1.272676 60  0.000000
timepoint15:SLC_GenotypeHET  0.000000  1.272676 60  0.000000
timepoint30:SLC_GenotypeHET -0.250000  1.272676 60 -0.196436
timepoint45:SLC_GenotypeHET -0.250000  1.272676 60 -0.196436
timepoint60:SLC_GenotypeHET -1.125000  1.272676 60 -0.883964
timepoint10:SLC_GenotypeMUT -1.666667  1.587306 60 -1.049997
timepoint15:SLC_GenotypeMUT -0.750000  1.587306 60 -0.472499
timepoint30:SLC_GenotypeMUT -1.750000  1.587306 60 -1.102497
timepoint45:SLC_GenotypeMUT -1.833333  1.587306 60 -1.154997
timepoint60:SLC_GenotypeMUT -2.916667  1.587306 60 -1.837495
                            p-value
(Intercept)                  0.2427
timepoint10                  0.0590
timepoint15                  0.0104
timepoint30                  0.0000
timepoint45                  0.0000
timepoint60                  0.0000
SLC_GenotypeHET              0.3886
SLC_GenotypeMUT              0.4548
timepoint10:SLC_GenotypeHET  1.0000
timepoint15:SLC_GenotypeHET  1.0000
timepoint30:SLC_GenotypeHET  0.8449
timepoint45:SLC_GenotypeHET  0.8449
timepoint60:SLC_GenotypeHET  0.3802
timepoint10:SLC_GenotypeMUT  0.2979
timepoint15:SLC_GenotypeMUT  0.6383
timepoint30:SLC_GenotypeMUT  0.2746
timepoint45:SLC_GenotypeMUT  0.2527
timepoint60:SLC_GenotypeMUT  0.0711
 Correlation: 
                            (Intr) tmpn10 tmpn15 tmpn30 tmpn45
timepoint10                 -0.350                            
timepoint15                 -0.350  0.500                     
timepoint30                 -0.350  0.500  0.500              
timepoint45                 -0.350  0.500  0.500  0.500       
timepoint60                 -0.350  0.500  0.500  0.500  0.500
SLC_GenotypeHET             -0.816  0.286  0.286  0.286  0.286
SLC_GenotypeMUT             -0.655  0.229  0.229  0.229  0.229
timepoint10:SLC_GenotypeHET  0.286 -0.816 -0.408 -0.408 -0.408
timepoint15:SLC_GenotypeHET  0.286 -0.408 -0.816 -0.408 -0.408
timepoint30:SLC_GenotypeHET  0.286 -0.408 -0.408 -0.816 -0.408
timepoint45:SLC_GenotypeHET  0.286 -0.408 -0.408 -0.408 -0.816
timepoint60:SLC_GenotypeHET  0.286 -0.408 -0.408 -0.408 -0.408
timepoint10:SLC_GenotypeMUT  0.229 -0.655 -0.327 -0.327 -0.327
timepoint15:SLC_GenotypeMUT  0.229 -0.327 -0.655 -0.327 -0.327
timepoint30:SLC_GenotypeMUT  0.229 -0.327 -0.327 -0.655 -0.327
timepoint45:SLC_GenotypeMUT  0.229 -0.327 -0.327 -0.327 -0.655
timepoint60:SLC_GenotypeMUT  0.229 -0.327 -0.327 -0.327 -0.327
                            tmpn60 SLC_GH SLC_GM t10:SLC_GH
timepoint10                                                
timepoint15                                                
timepoint30                                                
timepoint45                                                
timepoint60                                                
SLC_GenotypeHET              0.286                         
SLC_GenotypeMUT              0.229  0.535                  
timepoint10:SLC_GenotypeHET -0.408 -0.350 -0.187           
timepoint15:SLC_GenotypeHET -0.408 -0.350 -0.187  0.500    
timepoint30:SLC_GenotypeHET -0.408 -0.350 -0.187  0.500    
timepoint45:SLC_GenotypeHET -0.408 -0.350 -0.187  0.500    
timepoint60:SLC_GenotypeHET -0.816 -0.350 -0.187  0.500    
timepoint10:SLC_GenotypeMUT -0.327 -0.187 -0.350  0.535    
timepoint15:SLC_GenotypeMUT -0.327 -0.187 -0.350  0.267    
timepoint30:SLC_GenotypeMUT -0.327 -0.187 -0.350  0.267    
timepoint45:SLC_GenotypeMUT -0.327 -0.187 -0.350  0.267    
timepoint60:SLC_GenotypeMUT -0.655 -0.187 -0.350  0.267    
                            t15:SLC_GH t30:SLC_GH t45:SLC_GH
timepoint10                                                 
timepoint15                                                 
timepoint30                                                 
timepoint45                                                 
timepoint60                                                 
SLC_GenotypeHET                                             
SLC_GenotypeMUT                                             
timepoint10:SLC_GenotypeHET                                 
timepoint15:SLC_GenotypeHET                                 
timepoint30:SLC_GenotypeHET  0.500                          
timepoint45:SLC_GenotypeHET  0.500      0.500               
timepoint60:SLC_GenotypeHET  0.500      0.500      0.500    
timepoint10:SLC_GenotypeMUT  0.267      0.267      0.267    
timepoint15:SLC_GenotypeMUT  0.535      0.267      0.267    
timepoint30:SLC_GenotypeMUT  0.267      0.535      0.267    
timepoint45:SLC_GenotypeMUT  0.267      0.267      0.535    
timepoint60:SLC_GenotypeMUT  0.267      0.267      0.267    
                            t60:SLC_GH t10:SLC_GM t15:SLC_GM
timepoint10                                                 
timepoint15                                                 
timepoint30                                                 
timepoint45                                                 
timepoint60                                                 
SLC_GenotypeHET                                             
SLC_GenotypeMUT                                             
timepoint10:SLC_GenotypeHET                                 
timepoint15:SLC_GenotypeHET                                 
timepoint30:SLC_GenotypeHET                                 
timepoint45:SLC_GenotypeHET                                 
timepoint60:SLC_GenotypeHET                                 
timepoint10:SLC_GenotypeMUT  0.267                          
timepoint15:SLC_GenotypeMUT  0.267      0.500               
timepoint30:SLC_GenotypeMUT  0.267      0.500      0.500    
timepoint45:SLC_GenotypeMUT  0.267      0.500      0.500    
timepoint60:SLC_GenotypeMUT  0.535      0.500      0.500    
                            t30:SLC_GM t45:SLC_GM
timepoint10                                      
timepoint15                                      
timepoint30                                      
timepoint45                                      
timepoint60                                      
SLC_GenotypeHET                                  
SLC_GenotypeMUT                                  
timepoint10:SLC_GenotypeHET                      
timepoint15:SLC_GenotypeHET                      
timepoint30:SLC_GenotypeHET                      
timepoint45:SLC_GenotypeHET                      
timepoint60:SLC_GenotypeHET                      
timepoint10:SLC_GenotypeMUT                      
timepoint15:SLC_GenotypeMUT                      
timepoint30:SLC_GenotypeMUT                      
timepoint45:SLC_GenotypeMUT  0.500               
timepoint60:SLC_GenotypeMUT  0.500      0.500    

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3         Max 
-2.12743371 -0.45503521 -0.03394715  0.54728372  2.22302670 

Number of Observations: 90
Number of Groups: 15 


Summary for Males Tg Neg:
Linear mixed-effects model fit by REML
  Data: neg_males 
       AIC      BIC    logLik
  587.3829 643.1327 -273.6914

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    2.616062 1.638631

Fixed effects:  FP_output ~ timepoint * SLC_Genotype 
                                Value Std.Error  DF   t-value
(Intercept)                  3.000000  1.380499 100  2.173127
timepoint10                  1.000000  1.036361 100  0.964915
timepoint15                  2.600000  1.036361 100  2.508778
timepoint30                  4.200000  1.036361 100  4.052641
timepoint45                  6.200000  1.036361 100  5.982470
timepoint60                  7.000000  1.036361 100  6.754402
SLC_GenotypeHET              0.000000  1.594063  20  0.000000
SLC_GenotypeMUT             -2.333333  2.254346  20 -1.035038
timepoint10:SLC_GenotypeHET  0.000000  1.196687 100  0.000000
timepoint15:SLC_GenotypeHET -0.600000  1.196687 100 -0.501384
timepoint30:SLC_GenotypeHET -0.866667  1.196687 100 -0.724222
timepoint45:SLC_GenotypeHET -1.666667  1.196687 100 -1.392734
timepoint60:SLC_GenotypeHET -1.400000  1.196687 100 -1.169897
timepoint10:SLC_GenotypeMUT  2.000000  1.692371 100  1.181774
timepoint15:SLC_GenotypeMUT  1.066667  1.692371 100  0.630280
timepoint30:SLC_GenotypeMUT  1.800000  1.692371 100  1.063597
timepoint45:SLC_GenotypeMUT  0.466667  1.692371 100  0.275747
timepoint60:SLC_GenotypeMUT  0.666667  1.692371 100  0.393925
                            p-value
(Intercept)                  0.0321
timepoint10                  0.3369
timepoint15                  0.0137
timepoint30                  0.0001
timepoint45                  0.0000
timepoint60                  0.0000
SLC_GenotypeHET              1.0000
SLC_GenotypeMUT              0.3130
timepoint10:SLC_GenotypeHET  1.0000
timepoint15:SLC_GenotypeHET  0.6172
timepoint30:SLC_GenotypeHET  0.4706
timepoint45:SLC_GenotypeHET  0.1668
timepoint60:SLC_GenotypeHET  0.2448
timepoint10:SLC_GenotypeMUT  0.2401
timepoint15:SLC_GenotypeMUT  0.5299
timepoint30:SLC_GenotypeMUT  0.2901
timepoint45:SLC_GenotypeMUT  0.7833
timepoint60:SLC_GenotypeMUT  0.6945
 Correlation: 
                            (Intr) tmpn10 tmpn15 tmpn30 tmpn45
timepoint10                 -0.375                            
timepoint15                 -0.375  0.500                     
timepoint30                 -0.375  0.500  0.500              
timepoint45                 -0.375  0.500  0.500  0.500       
timepoint60                 -0.375  0.500  0.500  0.500  0.500
SLC_GenotypeHET             -0.866  0.325  0.325  0.325  0.325
SLC_GenotypeMUT             -0.612  0.230  0.230  0.230  0.230
timepoint10:SLC_GenotypeHET  0.325 -0.866 -0.433 -0.433 -0.433
timepoint15:SLC_GenotypeHET  0.325 -0.433 -0.866 -0.433 -0.433
timepoint30:SLC_GenotypeHET  0.325 -0.433 -0.433 -0.866 -0.433
timepoint45:SLC_GenotypeHET  0.325 -0.433 -0.433 -0.433 -0.866
timepoint60:SLC_GenotypeHET  0.325 -0.433 -0.433 -0.433 -0.433
timepoint10:SLC_GenotypeMUT  0.230 -0.612 -0.306 -0.306 -0.306
timepoint15:SLC_GenotypeMUT  0.230 -0.306 -0.612 -0.306 -0.306
timepoint30:SLC_GenotypeMUT  0.230 -0.306 -0.306 -0.612 -0.306
timepoint45:SLC_GenotypeMUT  0.230 -0.306 -0.306 -0.306 -0.612
timepoint60:SLC_GenotypeMUT  0.230 -0.306 -0.306 -0.306 -0.306
                            tmpn60 SLC_GH SLC_GM t10:SLC_GH
timepoint10                                                
timepoint15                                                
timepoint30                                                
timepoint45                                                
timepoint60                                                
SLC_GenotypeHET              0.325                         
SLC_GenotypeMUT              0.230  0.530                  
timepoint10:SLC_GenotypeHET -0.433 -0.375 -0.199           
timepoint15:SLC_GenotypeHET -0.433 -0.375 -0.199  0.500    
timepoint30:SLC_GenotypeHET -0.433 -0.375 -0.199  0.500    
timepoint45:SLC_GenotypeHET -0.433 -0.375 -0.199  0.500    
timepoint60:SLC_GenotypeHET -0.866 -0.375 -0.199  0.500    
timepoint10:SLC_GenotypeMUT -0.306 -0.199 -0.375  0.530    
timepoint15:SLC_GenotypeMUT -0.306 -0.199 -0.375  0.265    
timepoint30:SLC_GenotypeMUT -0.306 -0.199 -0.375  0.265    
timepoint45:SLC_GenotypeMUT -0.306 -0.199 -0.375  0.265    
timepoint60:SLC_GenotypeMUT -0.612 -0.199 -0.375  0.265    
                            t15:SLC_GH t30:SLC_GH t45:SLC_GH
timepoint10                                                 
timepoint15                                                 
timepoint30                                                 
timepoint45                                                 
timepoint60                                                 
SLC_GenotypeHET                                             
SLC_GenotypeMUT                                             
timepoint10:SLC_GenotypeHET                                 
timepoint15:SLC_GenotypeHET                                 
timepoint30:SLC_GenotypeHET  0.500                          
timepoint45:SLC_GenotypeHET  0.500      0.500               
timepoint60:SLC_GenotypeHET  0.500      0.500      0.500    
timepoint10:SLC_GenotypeMUT  0.265      0.265      0.265    
timepoint15:SLC_GenotypeMUT  0.530      0.265      0.265    
timepoint30:SLC_GenotypeMUT  0.265      0.530      0.265    
timepoint45:SLC_GenotypeMUT  0.265      0.265      0.530    
timepoint60:SLC_GenotypeMUT  0.265      0.265      0.265    
                            t60:SLC_GH t10:SLC_GM t15:SLC_GM
timepoint10                                                 
timepoint15                                                 
timepoint30                                                 
timepoint45                                                 
timepoint60                                                 
SLC_GenotypeHET                                             
SLC_GenotypeMUT                                             
timepoint10:SLC_GenotypeHET                                 
timepoint15:SLC_GenotypeHET                                 
timepoint30:SLC_GenotypeHET                                 
timepoint45:SLC_GenotypeHET                                 
timepoint60:SLC_GenotypeHET                                 
timepoint10:SLC_GenotypeMUT  0.265                          
timepoint15:SLC_GenotypeMUT  0.265      0.500               
timepoint30:SLC_GenotypeMUT  0.265      0.500      0.500    
timepoint45:SLC_GenotypeMUT  0.265      0.500      0.500    
timepoint60:SLC_GenotypeMUT  0.530      0.500      0.500    
                            t30:SLC_GM t45:SLC_GM
timepoint10                                      
timepoint15                                      
timepoint30                                      
timepoint45                                      
timepoint60                                      
SLC_GenotypeHET                                  
SLC_GenotypeMUT                                  
timepoint10:SLC_GenotypeHET                      
timepoint15:SLC_GenotypeHET                      
timepoint30:SLC_GenotypeHET                      
timepoint45:SLC_GenotypeHET                      
timepoint60:SLC_GenotypeHET                      
timepoint10:SLC_GenotypeMUT                      
timepoint15:SLC_GenotypeMUT                      
timepoint30:SLC_GenotypeMUT                      
timepoint45:SLC_GenotypeMUT  0.500               
timepoint60:SLC_GenotypeMUT  0.500      0.500    

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3         Max 
-3.40920442 -0.44164310 -0.03471558  0.51587055  3.08878418 

Number of Observations: 138
Number of Groups: 23 


Summary for Males Tg Pos:
Linear mixed-effects model fit by REML
  Data: pos_females 
       AIC      BIC    logLik
  533.5856 586.0851 -246.7928

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    3.328379  1.78159

Fixed effects:  FP_output ~ timepoint * SLC_Genotype 
                                Value Std.Error DF   t-value
(Intercept)                  1.800000  1.688323 85  1.066147
timepoint10                  0.800000  1.126776 85  0.709990
timepoint15                  1.400000  1.126776 85  1.242483
timepoint30                  3.200000  1.126776 85  2.839961
timepoint45                  4.400000  1.126776 85  3.904946
timepoint60                  5.000000  1.126776 85  4.437438
SLC_GenotypeHET              0.057143  2.210534 17  0.025850
SLC_GenotypeMUT             -0.300000  2.152198 17 -0.139392
timepoint10:SLC_GenotypeHET  0.914286  1.475296 85  0.619730
timepoint15:SLC_GenotypeHET  2.314286  1.475296 85  1.568692
timepoint30:SLC_GenotypeHET  1.800000  1.475296 85  1.220094
timepoint45:SLC_GenotypeHET  1.742857  1.475296 85  1.181361
timepoint60:SLC_GenotypeHET  2.428571  1.475296 85  1.646158
timepoint10:SLC_GenotypeMUT  0.700000  1.436363 85  0.487342
timepoint15:SLC_GenotypeMUT  2.100000  1.436363 85  1.462025
timepoint30:SLC_GenotypeMUT  2.300000  1.436363 85  1.601266
timepoint45:SLC_GenotypeMUT  2.475000  1.436363 85  1.723101
timepoint60:SLC_GenotypeMUT  3.375000  1.436363 85  2.349684
                            p-value
(Intercept)                  0.2894
timepoint10                  0.4797
timepoint15                  0.2175
timepoint30                  0.0056
timepoint45                  0.0002
timepoint60                  0.0000
SLC_GenotypeHET              0.9797
SLC_GenotypeMUT              0.8908
timepoint10:SLC_GenotypeHET  0.5371
timepoint15:SLC_GenotypeHET  0.1204
timepoint30:SLC_GenotypeHET  0.2258
timepoint45:SLC_GenotypeHET  0.2408
timepoint60:SLC_GenotypeHET  0.1034
timepoint10:SLC_GenotypeMUT  0.6273
timepoint15:SLC_GenotypeMUT  0.1474
timepoint30:SLC_GenotypeMUT  0.1130
timepoint45:SLC_GenotypeMUT  0.0885
timepoint60:SLC_GenotypeMUT  0.0211
 Correlation: 
                            (Intr) tmpn10 tmpn15 tmpn30 tmpn45
timepoint10                 -0.334                            
timepoint15                 -0.334  0.500                     
timepoint30                 -0.334  0.500  0.500              
timepoint45                 -0.334  0.500  0.500  0.500       
timepoint60                 -0.334  0.500  0.500  0.500  0.500
SLC_GenotypeHET             -0.764  0.255  0.255  0.255  0.255
SLC_GenotypeMUT             -0.784  0.262  0.262  0.262  0.262
timepoint10:SLC_GenotypeHET  0.255 -0.764 -0.382 -0.382 -0.382
timepoint15:SLC_GenotypeHET  0.255 -0.382 -0.764 -0.382 -0.382
timepoint30:SLC_GenotypeHET  0.255 -0.382 -0.382 -0.764 -0.382
timepoint45:SLC_GenotypeHET  0.255 -0.382 -0.382 -0.382 -0.764
timepoint60:SLC_GenotypeHET  0.255 -0.382 -0.382 -0.382 -0.382
timepoint10:SLC_GenotypeMUT  0.262 -0.784 -0.392 -0.392 -0.392
timepoint15:SLC_GenotypeMUT  0.262 -0.392 -0.784 -0.392 -0.392
timepoint30:SLC_GenotypeMUT  0.262 -0.392 -0.392 -0.784 -0.392
timepoint45:SLC_GenotypeMUT  0.262 -0.392 -0.392 -0.392 -0.784
timepoint60:SLC_GenotypeMUT  0.262 -0.392 -0.392 -0.392 -0.392
                            tmpn60 SLC_GH SLC_GM t10:SLC_GH
timepoint10                                                
timepoint15                                                
timepoint30                                                
timepoint45                                                
timepoint60                                                
SLC_GenotypeHET              0.255                         
SLC_GenotypeMUT              0.262  0.599                  
timepoint10:SLC_GenotypeHET -0.382 -0.334 -0.200           
timepoint15:SLC_GenotypeHET -0.382 -0.334 -0.200  0.500    
timepoint30:SLC_GenotypeHET -0.382 -0.334 -0.200  0.500    
timepoint45:SLC_GenotypeHET -0.382 -0.334 -0.200  0.500    
timepoint60:SLC_GenotypeHET -0.764 -0.334 -0.200  0.500    
timepoint10:SLC_GenotypeMUT -0.392 -0.200 -0.334  0.599    
timepoint15:SLC_GenotypeMUT -0.392 -0.200 -0.334  0.300    
timepoint30:SLC_GenotypeMUT -0.392 -0.200 -0.334  0.300    
timepoint45:SLC_GenotypeMUT -0.392 -0.200 -0.334  0.300    
timepoint60:SLC_GenotypeMUT -0.784 -0.200 -0.334  0.300    
                            t15:SLC_GH t30:SLC_GH t45:SLC_GH
timepoint10                                                 
timepoint15                                                 
timepoint30                                                 
timepoint45                                                 
timepoint60                                                 
SLC_GenotypeHET                                             
SLC_GenotypeMUT                                             
timepoint10:SLC_GenotypeHET                                 
timepoint15:SLC_GenotypeHET                                 
timepoint30:SLC_GenotypeHET  0.500                          
timepoint45:SLC_GenotypeHET  0.500      0.500               
timepoint60:SLC_GenotypeHET  0.500      0.500      0.500    
timepoint10:SLC_GenotypeMUT  0.300      0.300      0.300    
timepoint15:SLC_GenotypeMUT  0.599      0.300      0.300    
timepoint30:SLC_GenotypeMUT  0.300      0.599      0.300    
timepoint45:SLC_GenotypeMUT  0.300      0.300      0.599    
timepoint60:SLC_GenotypeMUT  0.300      0.300      0.300    
                            t60:SLC_GH t10:SLC_GM t15:SLC_GM
timepoint10                                                 
timepoint15                                                 
timepoint30                                                 
timepoint45                                                 
timepoint60                                                 
SLC_GenotypeHET                                             
SLC_GenotypeMUT                                             
timepoint10:SLC_GenotypeHET                                 
timepoint15:SLC_GenotypeHET                                 
timepoint30:SLC_GenotypeHET                                 
timepoint45:SLC_GenotypeHET                                 
timepoint60:SLC_GenotypeHET                                 
timepoint10:SLC_GenotypeMUT  0.300                          
timepoint15:SLC_GenotypeMUT  0.300      0.500               
timepoint30:SLC_GenotypeMUT  0.300      0.500      0.500    
timepoint45:SLC_GenotypeMUT  0.300      0.500      0.500    
timepoint60:SLC_GenotypeMUT  0.599      0.500      0.500    
                            t30:SLC_GM t45:SLC_GM
timepoint10                                      
timepoint15                                      
timepoint30                                      
timepoint45                                      
timepoint60                                      
SLC_GenotypeHET                                  
SLC_GenotypeMUT                                  
timepoint10:SLC_GenotypeHET                      
timepoint15:SLC_GenotypeHET                      
timepoint30:SLC_GenotypeHET                      
timepoint45:SLC_GenotypeHET                      
timepoint60:SLC_GenotypeHET                      
timepoint10:SLC_GenotypeMUT                      
timepoint15:SLC_GenotypeMUT                      
timepoint30:SLC_GenotypeMUT                      
timepoint45:SLC_GenotypeMUT  0.500               
timepoint60:SLC_GenotypeMUT  0.500      0.500    

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3         Max 
-2.07428165 -0.60634068  0.04431058  0.47898305  2.68879313 

Number of Observations: 120
Number of Groups: 20 


Summary for Males Tg Neg:
Linear mixed-effects model fit by REML
  Data: neg_females 
       AIC     BIC    logLik
  509.3258 559.322 -234.6629

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    3.677882 2.182218

Fixed effects:  FP_output ~ timepoint * SLC_Genotype 
                                Value Std.Error DF   t-value
(Intercept)                  2.000000  2.469068 75  0.810022
timepoint10                  1.000000  1.781773 75  0.561239
timepoint15                  1.666667  1.781773 75  0.935398
timepoint30                  3.666667  1.781773 75  2.057875
timepoint45                  5.333333  1.781773 75  2.993273
timepoint60                  6.000000  1.781773 75  3.367432
SLC_GenotypeHET              1.700000  2.815170 15  0.603871
SLC_GenotypeMUT              0.200000  3.123151 15  0.064038
timepoint10:SLC_GenotypeHET  1.200000  2.031534 75  0.590687
timepoint15:SLC_GenotypeHET  1.333333  2.031534 75  0.656318
timepoint30:SLC_GenotypeHET  2.033333  2.031534 75  1.000886
timepoint45:SLC_GenotypeHET  2.366667  2.031534 75  1.164965
timepoint60:SLC_GenotypeHET  3.000000  2.031534 75  1.476717
timepoint10:SLC_GenotypeMUT  0.000000  2.253785 75  0.000000
timepoint15:SLC_GenotypeMUT -0.066667  2.253785 75 -0.029580
timepoint30:SLC_GenotypeMUT -0.066667  2.253785 75 -0.029580
timepoint45:SLC_GenotypeMUT -0.533333  2.253785 75 -0.236639
timepoint60:SLC_GenotypeMUT  0.000000  2.253785 75  0.000000
                            p-value
(Intercept)                  0.4205
timepoint10                  0.5763
timepoint15                  0.3526
timepoint30                  0.0431
timepoint45                  0.0037
timepoint60                  0.0012
SLC_GenotypeHET              0.5550
SLC_GenotypeMUT              0.9498
timepoint10:SLC_GenotypeHET  0.5565
timepoint15:SLC_GenotypeHET  0.5136
timepoint30:SLC_GenotypeHET  0.3201
timepoint45:SLC_GenotypeHET  0.2477
timepoint60:SLC_GenotypeHET  0.1439
timepoint10:SLC_GenotypeMUT  1.0000
timepoint15:SLC_GenotypeMUT  0.9765
timepoint30:SLC_GenotypeMUT  0.9765
timepoint45:SLC_GenotypeMUT  0.8136
timepoint60:SLC_GenotypeMUT  1.0000
 Correlation: 
                            (Intr) tmpn10 tmpn15 tmpn30 tmpn45
timepoint10                 -0.361                            
timepoint15                 -0.361  0.500                     
timepoint30                 -0.361  0.500  0.500              
timepoint45                 -0.361  0.500  0.500  0.500       
timepoint60                 -0.361  0.500  0.500  0.500  0.500
SLC_GenotypeHET             -0.877  0.316  0.316  0.316  0.316
SLC_GenotypeMUT             -0.791  0.285  0.285  0.285  0.285
timepoint10:SLC_GenotypeHET  0.316 -0.877 -0.439 -0.439 -0.439
timepoint15:SLC_GenotypeHET  0.316 -0.439 -0.877 -0.439 -0.439
timepoint30:SLC_GenotypeHET  0.316 -0.439 -0.439 -0.877 -0.439
timepoint45:SLC_GenotypeHET  0.316 -0.439 -0.439 -0.439 -0.877
timepoint60:SLC_GenotypeHET  0.316 -0.439 -0.439 -0.439 -0.439
timepoint10:SLC_GenotypeMUT  0.285 -0.791 -0.395 -0.395 -0.395
timepoint15:SLC_GenotypeMUT  0.285 -0.395 -0.791 -0.395 -0.395
timepoint30:SLC_GenotypeMUT  0.285 -0.395 -0.395 -0.791 -0.395
timepoint45:SLC_GenotypeMUT  0.285 -0.395 -0.395 -0.395 -0.791
timepoint60:SLC_GenotypeMUT  0.285 -0.395 -0.395 -0.395 -0.395
                            tmpn60 SLC_GH SLC_GM t10:SLC_GH
timepoint10                                                
timepoint15                                                
timepoint30                                                
timepoint45                                                
timepoint60                                                
SLC_GenotypeHET              0.316                         
SLC_GenotypeMUT              0.285  0.693                  
timepoint10:SLC_GenotypeHET -0.439 -0.361 -0.250           
timepoint15:SLC_GenotypeHET -0.439 -0.361 -0.250  0.500    
timepoint30:SLC_GenotypeHET -0.439 -0.361 -0.250  0.500    
timepoint45:SLC_GenotypeHET -0.439 -0.361 -0.250  0.500    
timepoint60:SLC_GenotypeHET -0.877 -0.361 -0.250  0.500    
timepoint10:SLC_GenotypeMUT -0.395 -0.250 -0.361  0.693    
timepoint15:SLC_GenotypeMUT -0.395 -0.250 -0.361  0.347    
timepoint30:SLC_GenotypeMUT -0.395 -0.250 -0.361  0.347    
timepoint45:SLC_GenotypeMUT -0.395 -0.250 -0.361  0.347    
timepoint60:SLC_GenotypeMUT -0.791 -0.250 -0.361  0.347    
                            t15:SLC_GH t30:SLC_GH t45:SLC_GH
timepoint10                                                 
timepoint15                                                 
timepoint30                                                 
timepoint45                                                 
timepoint60                                                 
SLC_GenotypeHET                                             
SLC_GenotypeMUT                                             
timepoint10:SLC_GenotypeHET                                 
timepoint15:SLC_GenotypeHET                                 
timepoint30:SLC_GenotypeHET  0.500                          
timepoint45:SLC_GenotypeHET  0.500      0.500               
timepoint60:SLC_GenotypeHET  0.500      0.500      0.500    
timepoint10:SLC_GenotypeMUT  0.347      0.347      0.347    
timepoint15:SLC_GenotypeMUT  0.693      0.347      0.347    
timepoint30:SLC_GenotypeMUT  0.347      0.693      0.347    
timepoint45:SLC_GenotypeMUT  0.347      0.347      0.693    
timepoint60:SLC_GenotypeMUT  0.347      0.347      0.347    
                            t60:SLC_GH t10:SLC_GM t15:SLC_GM
timepoint10                                                 
timepoint15                                                 
timepoint30                                                 
timepoint45                                                 
timepoint60                                                 
SLC_GenotypeHET                                             
SLC_GenotypeMUT                                             
timepoint10:SLC_GenotypeHET                                 
timepoint15:SLC_GenotypeHET                                 
timepoint30:SLC_GenotypeHET                                 
timepoint45:SLC_GenotypeHET                                 
timepoint60:SLC_GenotypeHET                                 
timepoint10:SLC_GenotypeMUT  0.347                          
timepoint15:SLC_GenotypeMUT  0.347      0.500               
timepoint30:SLC_GenotypeMUT  0.347      0.500      0.500    
timepoint45:SLC_GenotypeMUT  0.347      0.500      0.500    
timepoint60:SLC_GenotypeMUT  0.693      0.500      0.500    
                            t30:SLC_GM t45:SLC_GM
timepoint10                                      
timepoint15                                      
timepoint30                                      
timepoint45                                      
timepoint60                                      
SLC_GenotypeHET                                  
SLC_GenotypeMUT                                  
timepoint10:SLC_GenotypeHET                      
timepoint15:SLC_GenotypeHET                      
timepoint30:SLC_GenotypeHET                      
timepoint45:SLC_GenotypeHET                      
timepoint60:SLC_GenotypeHET                      
timepoint10:SLC_GenotypeMUT                      
timepoint15:SLC_GenotypeMUT                      
timepoint30:SLC_GenotypeMUT                      
timepoint45:SLC_GenotypeMUT  0.500               
timepoint60:SLC_GenotypeMUT  0.500      0.500    

Standardized Within-Group Residuals:
         Min           Q1          Med           Q3          Max 
-2.071800333 -0.515859604 -0.002700078  0.592209988  2.510693897 

Number of Observations: 108
Number of Groups: 18 
