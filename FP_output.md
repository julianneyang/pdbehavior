

Summary for all data:
Linear mixed-effects model fit by REML
  Data: data_long 
       AIC      BIC    logLik
  2049.297 2118.811 -1007.648

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    3.070112 1.755801

Fixed effects:  FP_output ~ timepoint * ASO_Tg + Sex + SLC_Genotype 
                               Value Std.Error  DF
(Intercept)                 2.636347 0.9677466 370
timepoint10                 1.439024 0.3877916 370
timepoint15                 2.365854 0.3877916 370
timepoint30                 4.268293 0.3877916 370
timepoint45                 5.756098 0.3877916 370
timepoint60                 6.829268 0.3877916 370
ASO_TgPositive             -0.663069 0.8257669  71
SexMale                    -0.961873 0.7501439  71
SLC_GenotypeHET             1.305117 0.9227962  71
SLC_GenotypeMUT            -0.564851 1.0643632  71
timepoint10:ASO_TgPositive  0.075261 0.5714406 370
timepoint15:ASO_TgPositive  0.491289 0.5714406 370
timepoint30:ASO_TgPositive  0.274564 0.5714406 370
timepoint45:ASO_TgPositive -0.184669 0.5714406 370
timepoint60:ASO_TgPositive -0.114983 0.5714406 370
                             t-value p-value
(Intercept)                 2.724212  0.0068
timepoint10                 3.710819  0.0002
timepoint15                 6.100838  0.0000
timepoint30                11.006667  0.0000
timepoint45                14.843277  0.0000
timepoint60                17.610668  0.0000
ASO_TgPositive             -0.802974  0.4247
SexMale                    -1.282251  0.2039
SLC_GenotypeHET             1.414307  0.1616
SLC_GenotypeMUT            -0.530694  0.5973
timepoint10:ASO_TgPositive  0.131705  0.8953
timepoint15:ASO_TgPositive  0.859738  0.3905
timepoint30:ASO_TgPositive  0.480478  0.6312
timepoint45:ASO_TgPositive -0.323164  0.7468
timepoint60:ASO_TgPositive -0.201215  0.8406
 Correlation: 
                           (Intr) tmpn10 tmpn15 tmpn30
timepoint10                -0.200                     
timepoint15                -0.200  0.500              
timepoint30                -0.200  0.500  0.500       
timepoint45                -0.200  0.500  0.500  0.500
timepoint60                -0.200  0.500  0.500  0.500
ASO_TgPositive             -0.454  0.235  0.235  0.235
SexMale                    -0.382  0.000  0.000  0.000
SLC_GenotypeHET            -0.674  0.000  0.000  0.000
SLC_GenotypeMUT            -0.609  0.000  0.000  0.000
timepoint10:ASO_TgPositive  0.136 -0.679 -0.339 -0.339
timepoint15:ASO_TgPositive  0.136 -0.339 -0.679 -0.339
timepoint30:ASO_TgPositive  0.136 -0.339 -0.339 -0.679
timepoint45:ASO_TgPositive  0.136 -0.339 -0.339 -0.339
timepoint60:ASO_TgPositive  0.136 -0.339 -0.339 -0.339
                           tmpn45 tmpn60 ASO_TP SexMal
timepoint10                                           
timepoint15                                           
timepoint30                                           
timepoint45                                           
timepoint60                 0.500                     
ASO_TgPositive              0.235  0.235              
SexMale                     0.000  0.000  0.038       
SLC_GenotypeHET             0.000  0.000  0.107 -0.080
SLC_GenotypeMUT             0.000  0.000 -0.025  0.145
timepoint10:ASO_TgPositive -0.339 -0.339 -0.346  0.000
timepoint15:ASO_TgPositive -0.339 -0.339 -0.346  0.000
timepoint30:ASO_TgPositive -0.339 -0.339 -0.346  0.000
timepoint45:ASO_TgPositive -0.679 -0.339 -0.346  0.000
timepoint60:ASO_TgPositive -0.339 -0.679 -0.346  0.000
                           SLC_GH SLC_GM t10:AS t15:AS
timepoint10                                           
timepoint15                                           
timepoint30                                           
timepoint45                                           
timepoint60                                           
ASO_TgPositive                                        
SexMale                                               
SLC_GenotypeHET                                       
SLC_GenotypeMUT             0.579                     
timepoint10:ASO_TgPositive  0.000  0.000              
timepoint15:ASO_TgPositive  0.000  0.000  0.500       
timepoint30:ASO_TgPositive  0.000  0.000  0.500  0.500
timepoint45:ASO_TgPositive  0.000  0.000  0.500  0.500
timepoint60:ASO_TgPositive  0.000  0.000  0.500  0.500
                           t30:AS t45:AS
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
timepoint15:ASO_TgPositive              
timepoint30:ASO_TgPositive              
timepoint45:ASO_TgPositive  0.500       
timepoint60:ASO_TgPositive  0.500  0.500

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3 
-2.81895605 -0.57671647  0.01601037  0.51427570 
        Max 
 3.28307478 

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
                                Value Std.Error  DF
(Intercept)                  1.863695 1.2765582 160
SexMale                     -0.193313 1.1181463  31
timepoint10                  1.333333 0.7780279 160
timepoint15                  2.000000 0.7780279 160
timepoint30                  3.888889 0.7780279 160
timepoint45                  4.888889 0.7780279 160
timepoint60                  6.000000 0.7780279 160
SLC_GenotypeHET              0.906072 1.4906706  31
SLC_GenotypeMUT             -0.720064 1.5971075  31
timepoint10:SLC_GenotypeHET  0.533333 0.9841360 160
timepoint15:SLC_GenotypeHET  1.200000 0.9841360 160
timepoint30:SLC_GenotypeHET  0.844444 0.9841360 160
timepoint45:SLC_GenotypeHET  0.777778 0.9841360 160
timepoint60:SLC_GenotypeHET  0.733333 0.9841360 160
timepoint10:SLC_GenotypeMUT -0.151515 1.0490925 160
timepoint15:SLC_GenotypeMUT  1.090909 1.0490925 160
timepoint30:SLC_GenotypeMUT  0.929293 1.0490925 160
timepoint45:SLC_GenotypeMUT  1.111111 1.0490925 160
timepoint60:SLC_GenotypeMUT  1.272727 1.0490925 160
                              t-value p-value
(Intercept)                  1.459937  0.1463
SexMale                     -0.172887  0.8639
timepoint10                  1.713735  0.0885
timepoint15                  2.570602  0.0111
timepoint30                  4.998393  0.0000
timepoint45                  6.283694  0.0000
timepoint60                  7.711806  0.0000
SLC_GenotypeHET              0.607829  0.5477
SLC_GenotypeMUT             -0.450855  0.6552
timepoint10:SLC_GenotypeHET  0.541930  0.5886
timepoint15:SLC_GenotypeHET  1.219344  0.2245
timepoint30:SLC_GenotypeHET  0.858057  0.3921
timepoint45:SLC_GenotypeHET  0.790315  0.4305
timepoint60:SLC_GenotypeHET  0.745154  0.4573
timepoint10:SLC_GenotypeMUT -0.144425  0.8853
timepoint15:SLC_GenotypeMUT  1.039860  0.3000
timepoint30:SLC_GenotypeMUT  0.885806  0.3771
timepoint45:SLC_GenotypeMUT  1.059116  0.2911
timepoint60:SLC_GenotypeMUT  1.213170  0.2269
 Correlation: 
                            (Intr) SexMal tmpn10 tmpn15
SexMale                     -0.389                     
timepoint10                 -0.305  0.000              
timepoint15                 -0.305  0.000  0.500       
timepoint30                 -0.305  0.000  0.500  0.500
timepoint45                 -0.305  0.000  0.500  0.500
timepoint60                 -0.305  0.000  0.500  0.500
SLC_GenotypeHET             -0.701 -0.067  0.261  0.261
SLC_GenotypeMUT             -0.725  0.120  0.244  0.244
timepoint10:SLC_GenotypeHET  0.241  0.000 -0.791 -0.395
timepoint15:SLC_GenotypeHET  0.241  0.000 -0.395 -0.791
timepoint30:SLC_GenotypeHET  0.241  0.000 -0.395 -0.395
timepoint45:SLC_GenotypeHET  0.241  0.000 -0.395 -0.395
timepoint60:SLC_GenotypeHET  0.241  0.000 -0.395 -0.395
timepoint10:SLC_GenotypeMUT  0.226  0.000 -0.742 -0.371
timepoint15:SLC_GenotypeMUT  0.226  0.000 -0.371 -0.742
timepoint30:SLC_GenotypeMUT  0.226  0.000 -0.371 -0.371
timepoint45:SLC_GenotypeMUT  0.226  0.000 -0.371 -0.371
timepoint60:SLC_GenotypeMUT  0.226  0.000 -0.371 -0.371
                            tmpn30 tmpn45 tmpn60 SLC_GH
SexMale                                                
timepoint10                                            
timepoint15                                            
timepoint30                                            
timepoint45                  0.500                     
timepoint60                  0.500  0.500              
SLC_GenotypeHET              0.261  0.261  0.261       
SLC_GenotypeMUT              0.244  0.244  0.244  0.573
timepoint10:SLC_GenotypeHET -0.395 -0.395 -0.395 -0.330
timepoint15:SLC_GenotypeHET -0.395 -0.395 -0.395 -0.330
timepoint30:SLC_GenotypeHET -0.791 -0.395 -0.395 -0.330
timepoint45:SLC_GenotypeHET -0.395 -0.791 -0.395 -0.330
timepoint60:SLC_GenotypeHET -0.395 -0.395 -0.791 -0.330
timepoint10:SLC_GenotypeMUT -0.371 -0.371 -0.371 -0.194
timepoint15:SLC_GenotypeMUT -0.371 -0.371 -0.371 -0.194
timepoint30:SLC_GenotypeMUT -0.742 -0.371 -0.371 -0.194
timepoint45:SLC_GenotypeMUT -0.371 -0.742 -0.371 -0.194
timepoint60:SLC_GenotypeMUT -0.371 -0.371 -0.742 -0.194
                            SLC_GM t10:SLC_GH t15:SLC_GH
SexMale                                                 
timepoint10                                             
timepoint15                                             
timepoint30                                             
timepoint45                                             
timepoint60                                             
SLC_GenotypeHET                                         
SLC_GenotypeMUT                                         
timepoint10:SLC_GenotypeHET -0.193                      
timepoint15:SLC_GenotypeHET -0.193  0.500               
timepoint30:SLC_GenotypeHET -0.193  0.500      0.500    
timepoint45:SLC_GenotypeHET -0.193  0.500      0.500    
timepoint60:SLC_GenotypeHET -0.193  0.500      0.500    
timepoint10:SLC_GenotypeMUT -0.328  0.586      0.293    
timepoint15:SLC_GenotypeMUT -0.328  0.293      0.586    
timepoint30:SLC_GenotypeMUT -0.328  0.293      0.293    
timepoint45:SLC_GenotypeMUT -0.328  0.293      0.293    
timepoint60:SLC_GenotypeMUT -0.328  0.293      0.293    
                            t30:SLC_GH t45:SLC_GH
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
timepoint45:SLC_GenotypeHET  0.500               
timepoint60:SLC_GenotypeHET  0.500      0.500    
timepoint10:SLC_GenotypeMUT  0.293      0.293    
timepoint15:SLC_GenotypeMUT  0.293      0.293    
timepoint30:SLC_GenotypeMUT  0.586      0.293    
timepoint45:SLC_GenotypeMUT  0.293      0.586    
timepoint60:SLC_GenotypeMUT  0.293      0.293    
                            t60:SLC_GH t10:SLC_GM
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
timepoint10:SLC_GenotypeMUT  0.293               
timepoint15:SLC_GenotypeMUT  0.293      0.500    
timepoint30:SLC_GenotypeMUT  0.293      0.500    
timepoint45:SLC_GenotypeMUT  0.293      0.500    
timepoint60:SLC_GenotypeMUT  0.586      0.500    
                            t15:SLC_GM t30:SLC_GM
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
timepoint60:SLC_GenotypeMUT  0.500      0.500    
                            t45:SLC_GM
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
timepoint30:SLC_GenotypeMUT           
timepoint45:SLC_GenotypeMUT           
timepoint60:SLC_GenotypeMUT  0.500    

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3 
-2.27465021 -0.57235726  0.02441021  0.49067136 
        Max 
 3.25061674 

Number of Observations: 210
Number of Groups: 35 


Summary for Tg Neg:
Linear mixed-effects model fit by REML
  Data: neg 
       AIC     BIC    logLik
  1131.456 1203.38 -544.7282

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    3.105187 1.903275

Fixed effects:  FP_output ~ Sex + timepoint * SLC_Genotype 
                                Value Std.Error  DF
(Intercept)                  3.440789 1.3884200 190
SexMale                     -1.631579 1.0385177  37
timepoint10                  1.000000 0.9516376 190
timepoint15                  2.250000 0.9516376 190
timepoint30                  4.000000 0.9516376 190
timepoint45                  5.875000 0.9516376 190
timepoint60                  6.625000 0.9516376 190
SLC_GenotypeHET              0.818158 1.4830547  37
SLC_GenotypeMUT             -1.407895 1.8394478  37
timepoint10:SLC_GenotypeHET  0.480000 1.0933483 190
timepoint15:SLC_GenotypeHET  0.150000 1.0933483 190
timepoint30:SLC_GenotypeHET  0.280000 1.0933483 190
timepoint45:SLC_GenotypeHET -0.075000 1.0933483 190
timepoint60:SLC_GenotypeHET  0.335000 1.0933483 190
timepoint10:SLC_GenotypeMUT  0.750000 1.3458187 190
timepoint15:SLC_GenotypeMUT  0.125000 1.3458187 190
timepoint30:SLC_GenotypeMUT  0.500000 1.3458187 190
timepoint45:SLC_GenotypeMUT -0.375000 1.3458187 190
timepoint60:SLC_GenotypeMUT  0.000000 1.3458187 190
                              t-value p-value
(Intercept)                  2.478205  0.0141
SexMale                     -1.571065  0.1247
timepoint10                  1.050820  0.2947
timepoint15                  2.364346  0.0191
timepoint30                  4.203281  0.0000
timepoint45                  6.173569  0.0000
timepoint60                  6.961684  0.0000
SLC_GenotypeHET              0.551671  0.5845
SLC_GenotypeMUT             -0.765390  0.4489
timepoint10:SLC_GenotypeHET  0.439018  0.6611
timepoint15:SLC_GenotypeHET  0.137193  0.8910
timepoint30:SLC_GenotypeHET  0.256094  0.7982
timepoint45:SLC_GenotypeHET -0.068597  0.9454
timepoint60:SLC_GenotypeHET  0.306398  0.7596
timepoint10:SLC_GenotypeMUT  0.557282  0.5780
timepoint15:SLC_GenotypeMUT  0.092880  0.9261
timepoint30:SLC_GenotypeMUT  0.371521  0.7107
timepoint45:SLC_GenotypeMUT -0.278641  0.7808
timepoint60:SLC_GenotypeMUT  0.000000  1.0000
 Correlation: 
                            (Intr) SexMal tmpn10 tmpn15
SexMale                     -0.374                     
timepoint10                 -0.343  0.000              
timepoint15                 -0.343  0.000  0.500       
timepoint30                 -0.343  0.000  0.500  0.500
timepoint45                 -0.343  0.000  0.500  0.500
timepoint60                 -0.343  0.000  0.500  0.500
SLC_GenotypeHET             -0.779 -0.070  0.321  0.321
SLC_GenotypeMUT             -0.702  0.141  0.259  0.259
timepoint10:SLC_GenotypeHET  0.298  0.000 -0.870 -0.435
timepoint15:SLC_GenotypeHET  0.298  0.000 -0.435 -0.870
timepoint30:SLC_GenotypeHET  0.298  0.000 -0.435 -0.435
timepoint45:SLC_GenotypeHET  0.298  0.000 -0.435 -0.435
timepoint60:SLC_GenotypeHET  0.298  0.000 -0.435 -0.435
timepoint10:SLC_GenotypeMUT  0.242  0.000 -0.707 -0.354
timepoint15:SLC_GenotypeMUT  0.242  0.000 -0.354 -0.707
timepoint30:SLC_GenotypeMUT  0.242  0.000 -0.354 -0.354
timepoint45:SLC_GenotypeMUT  0.242  0.000 -0.354 -0.354
timepoint60:SLC_GenotypeMUT  0.242  0.000 -0.354 -0.354
                            tmpn30 tmpn45 tmpn60 SLC_GH
SexMale                                                
timepoint10                                            
timepoint15                                            
timepoint30                                            
timepoint45                  0.500                     
timepoint60                  0.500  0.500              
SLC_GenotypeHET              0.321  0.321  0.321       
SLC_GenotypeMUT              0.259  0.259  0.259  0.598
timepoint10:SLC_GenotypeHET -0.435 -0.435 -0.435 -0.369
timepoint15:SLC_GenotypeHET -0.435 -0.435 -0.435 -0.369
timepoint30:SLC_GenotypeHET -0.870 -0.435 -0.435 -0.369
timepoint45:SLC_GenotypeHET -0.435 -0.870 -0.435 -0.369
timepoint60:SLC_GenotypeHET -0.435 -0.435 -0.870 -0.369
timepoint10:SLC_GenotypeMUT -0.354 -0.354 -0.354 -0.227
timepoint15:SLC_GenotypeMUT -0.354 -0.354 -0.354 -0.227
timepoint30:SLC_GenotypeMUT -0.707 -0.354 -0.354 -0.227
timepoint45:SLC_GenotypeMUT -0.354 -0.707 -0.354 -0.227
timepoint60:SLC_GenotypeMUT -0.354 -0.354 -0.707 -0.227
                            SLC_GM t10:SLC_GH t15:SLC_GH
SexMale                                                 
timepoint10                                             
timepoint15                                             
timepoint30                                             
timepoint45                                             
timepoint60                                             
SLC_GenotypeHET                                         
SLC_GenotypeMUT                                         
timepoint10:SLC_GenotypeHET -0.225                      
timepoint15:SLC_GenotypeHET -0.225  0.500               
timepoint30:SLC_GenotypeHET -0.225  0.500      0.500    
timepoint45:SLC_GenotypeHET -0.225  0.500      0.500    
timepoint60:SLC_GenotypeHET -0.225  0.500      0.500    
timepoint10:SLC_GenotypeMUT -0.366  0.615      0.308    
timepoint15:SLC_GenotypeMUT -0.366  0.308      0.615    
timepoint30:SLC_GenotypeMUT -0.366  0.308      0.308    
timepoint45:SLC_GenotypeMUT -0.366  0.308      0.308    
timepoint60:SLC_GenotypeMUT -0.366  0.308      0.308    
                            t30:SLC_GH t45:SLC_GH
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
timepoint45:SLC_GenotypeHET  0.500               
timepoint60:SLC_GenotypeHET  0.500      0.500    
timepoint10:SLC_GenotypeMUT  0.308      0.308    
timepoint15:SLC_GenotypeMUT  0.308      0.308    
timepoint30:SLC_GenotypeMUT  0.615      0.308    
timepoint45:SLC_GenotypeMUT  0.308      0.615    
timepoint60:SLC_GenotypeMUT  0.308      0.308    
                            t60:SLC_GH t10:SLC_GM
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
timepoint10:SLC_GenotypeMUT  0.308               
timepoint15:SLC_GenotypeMUT  0.308      0.500    
timepoint30:SLC_GenotypeMUT  0.308      0.500    
timepoint45:SLC_GenotypeMUT  0.308      0.500    
timepoint60:SLC_GenotypeMUT  0.615      0.500    
                            t15:SLC_GM t30:SLC_GM
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
timepoint60:SLC_GenotypeMUT  0.500      0.500    
                            t45:SLC_GM
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
timepoint30:SLC_GenotypeMUT           
timepoint45:SLC_GenotypeMUT           
timepoint60:SLC_GenotypeMUT  0.500    

Standardized Within-Group Residuals:
         Min           Q1          Med           Q3 
-2.560186930 -0.603302744 -0.001531113  0.531203504 
         Max 
 2.874849776 

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
                                Value Std.Error DF
(Intercept)                  1.750000  1.483269 60
timepoint10                  2.000000  1.039136 60
timepoint15                  2.750000  1.039136 60
timepoint30                  4.750000  1.039136 60
timepoint45                  5.500000  1.039136 60
timepoint60                  7.250000  1.039136 60
SLC_GenotypeHET              1.625000  1.816626 12
SLC_GenotypeMUT             -1.750000  2.265731 12
timepoint10:SLC_GenotypeHET  0.000000  1.272676 60
timepoint15:SLC_GenotypeHET  0.000000  1.272676 60
timepoint30:SLC_GenotypeHET -0.250000  1.272676 60
timepoint45:SLC_GenotypeHET -0.250000  1.272676 60
timepoint60:SLC_GenotypeHET -1.125000  1.272676 60
timepoint10:SLC_GenotypeMUT -1.666667  1.587306 60
timepoint15:SLC_GenotypeMUT -0.750000  1.587306 60
timepoint30:SLC_GenotypeMUT -1.750000  1.587306 60
timepoint45:SLC_GenotypeMUT -1.833333  1.587306 60
timepoint60:SLC_GenotypeMUT -2.916667  1.587306 60
                              t-value p-value
(Intercept)                  1.179826  0.2427
timepoint10                  1.924676  0.0590
timepoint15                  2.646430  0.0104
timepoint30                  4.571106  0.0000
timepoint45                  5.292860  0.0000
timepoint60                  6.976951  0.0000
SLC_GenotypeHET              0.894515  0.3886
SLC_GenotypeMUT             -0.772378  0.4548
timepoint10:SLC_GenotypeHET  0.000000  1.0000
timepoint15:SLC_GenotypeHET  0.000000  1.0000
timepoint30:SLC_GenotypeHET -0.196436  0.8449
timepoint45:SLC_GenotypeHET -0.196436  0.8449
timepoint60:SLC_GenotypeHET -0.883964  0.3802
timepoint10:SLC_GenotypeMUT -1.049997  0.2979
timepoint15:SLC_GenotypeMUT -0.472499  0.6383
timepoint30:SLC_GenotypeMUT -1.102497  0.2746
timepoint45:SLC_GenotypeMUT -1.154997  0.2527
timepoint60:SLC_GenotypeMUT -1.837495  0.0711
 Correlation: 
                            (Intr) tmpn10 tmpn15 tmpn30
timepoint10                 -0.350                     
timepoint15                 -0.350  0.500              
timepoint30                 -0.350  0.500  0.500       
timepoint45                 -0.350  0.500  0.500  0.500
timepoint60                 -0.350  0.500  0.500  0.500
SLC_GenotypeHET             -0.816  0.286  0.286  0.286
SLC_GenotypeMUT             -0.655  0.229  0.229  0.229
timepoint10:SLC_GenotypeHET  0.286 -0.816 -0.408 -0.408
timepoint15:SLC_GenotypeHET  0.286 -0.408 -0.816 -0.408
timepoint30:SLC_GenotypeHET  0.286 -0.408 -0.408 -0.816
timepoint45:SLC_GenotypeHET  0.286 -0.408 -0.408 -0.408
timepoint60:SLC_GenotypeHET  0.286 -0.408 -0.408 -0.408
timepoint10:SLC_GenotypeMUT  0.229 -0.655 -0.327 -0.327
timepoint15:SLC_GenotypeMUT  0.229 -0.327 -0.655 -0.327
timepoint30:SLC_GenotypeMUT  0.229 -0.327 -0.327 -0.655
timepoint45:SLC_GenotypeMUT  0.229 -0.327 -0.327 -0.327
timepoint60:SLC_GenotypeMUT  0.229 -0.327 -0.327 -0.327
                            tmpn45 tmpn60 SLC_GH SLC_GM
timepoint10                                            
timepoint15                                            
timepoint30                                            
timepoint45                                            
timepoint60                  0.500                     
SLC_GenotypeHET              0.286  0.286              
SLC_GenotypeMUT              0.229  0.229  0.535       
timepoint10:SLC_GenotypeHET -0.408 -0.408 -0.350 -0.187
timepoint15:SLC_GenotypeHET -0.408 -0.408 -0.350 -0.187
timepoint30:SLC_GenotypeHET -0.408 -0.408 -0.350 -0.187
timepoint45:SLC_GenotypeHET -0.816 -0.408 -0.350 -0.187
timepoint60:SLC_GenotypeHET -0.408 -0.816 -0.350 -0.187
timepoint10:SLC_GenotypeMUT -0.327 -0.327 -0.187 -0.350
timepoint15:SLC_GenotypeMUT -0.327 -0.327 -0.187 -0.350
timepoint30:SLC_GenotypeMUT -0.327 -0.327 -0.187 -0.350
timepoint45:SLC_GenotypeMUT -0.655 -0.327 -0.187 -0.350
timepoint60:SLC_GenotypeMUT -0.327 -0.655 -0.187 -0.350
                            t10:SLC_GH t15:SLC_GH
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
timepoint45:SLC_GenotypeHET  0.500      0.500    
timepoint60:SLC_GenotypeHET  0.500      0.500    
timepoint10:SLC_GenotypeMUT  0.535      0.267    
timepoint15:SLC_GenotypeMUT  0.267      0.535    
timepoint30:SLC_GenotypeMUT  0.267      0.267    
timepoint45:SLC_GenotypeMUT  0.267      0.267    
timepoint60:SLC_GenotypeMUT  0.267      0.267    
                            t30:SLC_GH t45:SLC_GH
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
timepoint45:SLC_GenotypeHET  0.500               
timepoint60:SLC_GenotypeHET  0.500      0.500    
timepoint10:SLC_GenotypeMUT  0.267      0.267    
timepoint15:SLC_GenotypeMUT  0.267      0.267    
timepoint30:SLC_GenotypeMUT  0.535      0.267    
timepoint45:SLC_GenotypeMUT  0.267      0.535    
timepoint60:SLC_GenotypeMUT  0.267      0.267    
                            t60:SLC_GH t10:SLC_GM
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
timepoint30:SLC_GenotypeMUT  0.267      0.500    
timepoint45:SLC_GenotypeMUT  0.267      0.500    
timepoint60:SLC_GenotypeMUT  0.535      0.500    
                            t15:SLC_GM t30:SLC_GM
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
timepoint60:SLC_GenotypeMUT  0.500      0.500    
                            t45:SLC_GM
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
timepoint45:SLC_GenotypeMUT           
timepoint60:SLC_GenotypeMUT  0.500    

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3 
-2.12743371 -0.45503521 -0.03394715  0.54728372 
        Max 
 2.22302670 

Number of Observations: 90
Number of Groups: 15 


Summary for Males Tg Neg:
Linear mixed-effects model fit by REML
  Data: neg_males 
       AIC      BIC    logLik
  540.4107 594.0533 -250.2053

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    2.641747  1.71176

Fixed effects:  FP_output ~ timepoint * SLC_Genotype 
                                Value Std.Error DF
(Intercept)                  2.250000  1.573924 90
timepoint10                  0.750000  1.210397 90
timepoint15                  2.500000  1.210397 90
timepoint30                  4.250000  1.210397 90
timepoint45                  6.250000  1.210397 90
timepoint60                  7.250000  1.210397 90
SLC_GenotypeHET              0.750000  1.771393 18
SLC_GenotypeMUT             -1.250000  2.726117 18
timepoint10:SLC_GenotypeHET  0.250000  1.362257 90
timepoint15:SLC_GenotypeHET -0.500000  1.362257 90
timepoint30:SLC_GenotypeHET -0.916667  1.362257 90
timepoint45:SLC_GenotypeHET -1.716667  1.362257 90
timepoint60:SLC_GenotypeHET -1.650000  1.362257 90
timepoint10:SLC_GenotypeMUT  2.250000  2.096470 90
timepoint15:SLC_GenotypeMUT  1.000000  2.096470 90
timepoint30:SLC_GenotypeMUT  1.750000  2.096470 90
timepoint45:SLC_GenotypeMUT  0.250000  2.096470 90
timepoint60:SLC_GenotypeMUT -0.250000  2.096470 90
                              t-value p-value
(Intercept)                  1.429548  0.1563
timepoint10                  0.619631  0.5371
timepoint15                  2.065437  0.0418
timepoint30                  3.511244  0.0007
timepoint45                  5.163594  0.0000
timepoint60                  5.989769  0.0000
SLC_GenotypeHET              0.423396  0.6770
SLC_GenotypeMUT             -0.458528  0.6521
timepoint10:SLC_GenotypeHET  0.183519  0.8548
timepoint15:SLC_GenotypeHET -0.367038  0.7145
timepoint30:SLC_GenotypeHET -0.672903  0.5027
timepoint45:SLC_GenotypeHET -1.260163  0.2109
timepoint60:SLC_GenotypeHET -1.211225  0.2290
timepoint10:SLC_GenotypeMUT  1.073233  0.2860
timepoint15:SLC_GenotypeMUT  0.476992  0.6345
timepoint30:SLC_GenotypeMUT  0.834737  0.4061
timepoint45:SLC_GenotypeMUT  0.119248  0.9053
timepoint60:SLC_GenotypeMUT -0.119248  0.9053
 Correlation: 
                            (Intr) tmpn10 tmpn15 tmpn30
timepoint10                 -0.385                     
timepoint15                 -0.385  0.500              
timepoint30                 -0.385  0.500  0.500       
timepoint45                 -0.385  0.500  0.500  0.500
timepoint60                 -0.385  0.500  0.500  0.500
SLC_GenotypeHET             -0.889  0.342  0.342  0.342
SLC_GenotypeMUT             -0.577  0.222  0.222  0.222
timepoint10:SLC_GenotypeHET  0.342 -0.889 -0.444 -0.444
timepoint15:SLC_GenotypeHET  0.342 -0.444 -0.889 -0.444
timepoint30:SLC_GenotypeHET  0.342 -0.444 -0.444 -0.889
timepoint45:SLC_GenotypeHET  0.342 -0.444 -0.444 -0.444
timepoint60:SLC_GenotypeHET  0.342 -0.444 -0.444 -0.444
timepoint10:SLC_GenotypeMUT  0.222 -0.577 -0.289 -0.289
timepoint15:SLC_GenotypeMUT  0.222 -0.289 -0.577 -0.289
timepoint30:SLC_GenotypeMUT  0.222 -0.289 -0.289 -0.577
timepoint45:SLC_GenotypeMUT  0.222 -0.289 -0.289 -0.289
timepoint60:SLC_GenotypeMUT  0.222 -0.289 -0.289 -0.289
                            tmpn45 tmpn60 SLC_GH SLC_GM
timepoint10                                            
timepoint15                                            
timepoint30                                            
timepoint45                                            
timepoint60                  0.500                     
SLC_GenotypeHET              0.342  0.342              
SLC_GenotypeMUT              0.222  0.222  0.513       
timepoint10:SLC_GenotypeHET -0.444 -0.444 -0.385 -0.197
timepoint15:SLC_GenotypeHET -0.444 -0.444 -0.385 -0.197
timepoint30:SLC_GenotypeHET -0.444 -0.444 -0.385 -0.197
timepoint45:SLC_GenotypeHET -0.889 -0.444 -0.385 -0.197
timepoint60:SLC_GenotypeHET -0.444 -0.889 -0.385 -0.197
timepoint10:SLC_GenotypeMUT -0.289 -0.289 -0.197 -0.385
timepoint15:SLC_GenotypeMUT -0.289 -0.289 -0.197 -0.385
timepoint30:SLC_GenotypeMUT -0.289 -0.289 -0.197 -0.385
timepoint45:SLC_GenotypeMUT -0.577 -0.289 -0.197 -0.385
timepoint60:SLC_GenotypeMUT -0.289 -0.577 -0.197 -0.385
                            t10:SLC_GH t15:SLC_GH
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
timepoint45:SLC_GenotypeHET  0.500      0.500    
timepoint60:SLC_GenotypeHET  0.500      0.500    
timepoint10:SLC_GenotypeMUT  0.513      0.256    
timepoint15:SLC_GenotypeMUT  0.256      0.513    
timepoint30:SLC_GenotypeMUT  0.256      0.256    
timepoint45:SLC_GenotypeMUT  0.256      0.256    
timepoint60:SLC_GenotypeMUT  0.256      0.256    
                            t30:SLC_GH t45:SLC_GH
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
timepoint45:SLC_GenotypeHET  0.500               
timepoint60:SLC_GenotypeHET  0.500      0.500    
timepoint10:SLC_GenotypeMUT  0.256      0.256    
timepoint15:SLC_GenotypeMUT  0.256      0.256    
timepoint30:SLC_GenotypeMUT  0.513      0.256    
timepoint45:SLC_GenotypeMUT  0.256      0.513    
timepoint60:SLC_GenotypeMUT  0.256      0.256    
                            t60:SLC_GH t10:SLC_GM
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
timepoint10:SLC_GenotypeMUT  0.256               
timepoint15:SLC_GenotypeMUT  0.256      0.500    
timepoint30:SLC_GenotypeMUT  0.256      0.500    
timepoint45:SLC_GenotypeMUT  0.256      0.500    
timepoint60:SLC_GenotypeMUT  0.513      0.500    
                            t15:SLC_GM t30:SLC_GM
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
timepoint60:SLC_GenotypeMUT  0.500      0.500    
                            t45:SLC_GM
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
timepoint45:SLC_GenotypeMUT           
timepoint60:SLC_GenotypeMUT  0.500    

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3 
-3.25708103 -0.51712885 -0.08933071  0.51037582 
        Max 
 2.84178220 

Number of Observations: 126
Number of Groups: 21 


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
                                Value Std.Error DF
(Intercept)                  1.800000  1.688323 85
timepoint10                  0.800000  1.126776 85
timepoint15                  1.400000  1.126776 85
timepoint30                  3.200000  1.126776 85
timepoint45                  4.400000  1.126776 85
timepoint60                  5.000000  1.126776 85
SLC_GenotypeHET              0.057143  2.210534 17
SLC_GenotypeMUT             -0.300000  2.152198 17
timepoint10:SLC_GenotypeHET  0.914286  1.475296 85
timepoint15:SLC_GenotypeHET  2.314286  1.475296 85
timepoint30:SLC_GenotypeHET  1.800000  1.475296 85
timepoint45:SLC_GenotypeHET  1.742857  1.475296 85
timepoint60:SLC_GenotypeHET  2.428571  1.475296 85
timepoint10:SLC_GenotypeMUT  0.700000  1.436363 85
timepoint15:SLC_GenotypeMUT  2.100000  1.436363 85
timepoint30:SLC_GenotypeMUT  2.300000  1.436363 85
timepoint45:SLC_GenotypeMUT  2.475000  1.436363 85
timepoint60:SLC_GenotypeMUT  3.375000  1.436363 85
                              t-value p-value
(Intercept)                  1.066147  0.2894
timepoint10                  0.709990  0.4797
timepoint15                  1.242483  0.2175
timepoint30                  2.839961  0.0056
timepoint45                  3.904946  0.0002
timepoint60                  4.437438  0.0000
SLC_GenotypeHET              0.025850  0.9797
SLC_GenotypeMUT             -0.139392  0.8908
timepoint10:SLC_GenotypeHET  0.619730  0.5371
timepoint15:SLC_GenotypeHET  1.568692  0.1204
timepoint30:SLC_GenotypeHET  1.220094  0.2258
timepoint45:SLC_GenotypeHET  1.181361  0.2408
timepoint60:SLC_GenotypeHET  1.646158  0.1034
timepoint10:SLC_GenotypeMUT  0.487342  0.6273
timepoint15:SLC_GenotypeMUT  1.462025  0.1474
timepoint30:SLC_GenotypeMUT  1.601266  0.1130
timepoint45:SLC_GenotypeMUT  1.723101  0.0885
timepoint60:SLC_GenotypeMUT  2.349684  0.0211
 Correlation: 
                            (Intr) tmpn10 tmpn15 tmpn30
timepoint10                 -0.334                     
timepoint15                 -0.334  0.500              
timepoint30                 -0.334  0.500  0.500       
timepoint45                 -0.334  0.500  0.500  0.500
timepoint60                 -0.334  0.500  0.500  0.500
SLC_GenotypeHET             -0.764  0.255  0.255  0.255
SLC_GenotypeMUT             -0.784  0.262  0.262  0.262
timepoint10:SLC_GenotypeHET  0.255 -0.764 -0.382 -0.382
timepoint15:SLC_GenotypeHET  0.255 -0.382 -0.764 -0.382
timepoint30:SLC_GenotypeHET  0.255 -0.382 -0.382 -0.764
timepoint45:SLC_GenotypeHET  0.255 -0.382 -0.382 -0.382
timepoint60:SLC_GenotypeHET  0.255 -0.382 -0.382 -0.382
timepoint10:SLC_GenotypeMUT  0.262 -0.784 -0.392 -0.392
timepoint15:SLC_GenotypeMUT  0.262 -0.392 -0.784 -0.392
timepoint30:SLC_GenotypeMUT  0.262 -0.392 -0.392 -0.784
timepoint45:SLC_GenotypeMUT  0.262 -0.392 -0.392 -0.392
timepoint60:SLC_GenotypeMUT  0.262 -0.392 -0.392 -0.392
                            tmpn45 tmpn60 SLC_GH SLC_GM
timepoint10                                            
timepoint15                                            
timepoint30                                            
timepoint45                                            
timepoint60                  0.500                     
SLC_GenotypeHET              0.255  0.255              
SLC_GenotypeMUT              0.262  0.262  0.599       
timepoint10:SLC_GenotypeHET -0.382 -0.382 -0.334 -0.200
timepoint15:SLC_GenotypeHET -0.382 -0.382 -0.334 -0.200
timepoint30:SLC_GenotypeHET -0.382 -0.382 -0.334 -0.200
timepoint45:SLC_GenotypeHET -0.764 -0.382 -0.334 -0.200
timepoint60:SLC_GenotypeHET -0.382 -0.764 -0.334 -0.200
timepoint10:SLC_GenotypeMUT -0.392 -0.392 -0.200 -0.334
timepoint15:SLC_GenotypeMUT -0.392 -0.392 -0.200 -0.334
timepoint30:SLC_GenotypeMUT -0.392 -0.392 -0.200 -0.334
timepoint45:SLC_GenotypeMUT -0.784 -0.392 -0.200 -0.334
timepoint60:SLC_GenotypeMUT -0.392 -0.784 -0.200 -0.334
                            t10:SLC_GH t15:SLC_GH
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
timepoint45:SLC_GenotypeHET  0.500      0.500    
timepoint60:SLC_GenotypeHET  0.500      0.500    
timepoint10:SLC_GenotypeMUT  0.599      0.300    
timepoint15:SLC_GenotypeMUT  0.300      0.599    
timepoint30:SLC_GenotypeMUT  0.300      0.300    
timepoint45:SLC_GenotypeMUT  0.300      0.300    
timepoint60:SLC_GenotypeMUT  0.300      0.300    
                            t30:SLC_GH t45:SLC_GH
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
timepoint45:SLC_GenotypeHET  0.500               
timepoint60:SLC_GenotypeHET  0.500      0.500    
timepoint10:SLC_GenotypeMUT  0.300      0.300    
timepoint15:SLC_GenotypeMUT  0.300      0.300    
timepoint30:SLC_GenotypeMUT  0.599      0.300    
timepoint45:SLC_GenotypeMUT  0.300      0.599    
timepoint60:SLC_GenotypeMUT  0.300      0.300    
                            t60:SLC_GH t10:SLC_GM
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
timepoint30:SLC_GenotypeMUT  0.300      0.500    
timepoint45:SLC_GenotypeMUT  0.300      0.500    
timepoint60:SLC_GenotypeMUT  0.599      0.500    
                            t15:SLC_GM t30:SLC_GM
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
timepoint60:SLC_GenotypeMUT  0.500      0.500    
                            t45:SLC_GM
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
timepoint45:SLC_GenotypeMUT           
timepoint60:SLC_GenotypeMUT  0.500    

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3 
-2.07428165 -0.60634068  0.04431058  0.47898305 
        Max 
 2.68879313 

Number of Observations: 120
Number of Groups: 20 


Summary for Males Tg Neg:
Linear mixed-effects model fit by REML
  Data: neg_females 
       AIC      BIC    logLik
  560.4563 612.9558 -260.2281

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    3.583577 2.065781

Fixed effects:  FP_output ~ timepoint * SLC_Genotype 
                                Value Std.Error DF
(Intercept)                  3.000000  2.068180 85
timepoint10                  1.250000  1.460728 85
timepoint15                  2.000000  1.460728 85
timepoint30                  3.750000  1.460728 85
timepoint45                  5.500000  1.460728 85
timepoint60                  6.000000  1.460728 85
SLC_GenotypeHET              0.700000  2.447104 17
SLC_GenotypeMUT             -1.166667  2.670009 17
timepoint10:SLC_GenotypeHET  0.950000  1.728356 85
timepoint15:SLC_GenotypeHET  1.000000  1.728356 85
timepoint30:SLC_GenotypeHET  1.950000  1.728356 85
timepoint45:SLC_GenotypeHET  2.200000  1.728356 85
timepoint60:SLC_GenotypeHET  3.000000  1.728356 85
timepoint10:SLC_GenotypeMUT  0.083333  1.885791 85
timepoint15:SLC_GenotypeMUT  0.000000  1.885791 85
timepoint30:SLC_GenotypeMUT  0.250000  1.885791 85
timepoint45:SLC_GenotypeMUT -0.333333  1.885791 85
timepoint60:SLC_GenotypeMUT  0.500000  1.885791 85
                              t-value p-value
(Intercept)                  1.450551  0.1506
timepoint10                  0.855738  0.3945
timepoint15                  1.369181  0.1745
timepoint30                  2.567214  0.0120
timepoint45                  3.765247  0.0003
timepoint60                  4.107542  0.0001
SLC_GenotypeHET              0.286052  0.7783
SLC_GenotypeMUT             -0.436952  0.6676
timepoint10:SLC_GenotypeHET  0.549655  0.5840
timepoint15:SLC_GenotypeHET  0.578584  0.5644
timepoint30:SLC_GenotypeHET  1.128240  0.2624
timepoint45:SLC_GenotypeHET  1.272886  0.2065
timepoint60:SLC_GenotypeHET  1.735753  0.0862
timepoint10:SLC_GenotypeMUT  0.044190  0.9649
timepoint15:SLC_GenotypeMUT  0.000000  1.0000
timepoint30:SLC_GenotypeMUT  0.132570  0.8948
timepoint45:SLC_GenotypeMUT -0.176760  0.8601
timepoint60:SLC_GenotypeMUT  0.265141  0.7915
 Correlation: 
                            (Intr) tmpn10 tmpn15 tmpn30
timepoint10                 -0.353                     
timepoint15                 -0.353  0.500              
timepoint30                 -0.353  0.500  0.500       
timepoint45                 -0.353  0.500  0.500  0.500
timepoint60                 -0.353  0.500  0.500  0.500
SLC_GenotypeHET             -0.845  0.298  0.298  0.298
SLC_GenotypeMUT             -0.775  0.274  0.274  0.274
timepoint10:SLC_GenotypeHET  0.298 -0.845 -0.423 -0.423
timepoint15:SLC_GenotypeHET  0.298 -0.423 -0.845 -0.423
timepoint30:SLC_GenotypeHET  0.298 -0.423 -0.423 -0.845
timepoint45:SLC_GenotypeHET  0.298 -0.423 -0.423 -0.423
timepoint60:SLC_GenotypeHET  0.298 -0.423 -0.423 -0.423
timepoint10:SLC_GenotypeMUT  0.274 -0.775 -0.387 -0.387
timepoint15:SLC_GenotypeMUT  0.274 -0.387 -0.775 -0.387
timepoint30:SLC_GenotypeMUT  0.274 -0.387 -0.387 -0.775
timepoint45:SLC_GenotypeMUT  0.274 -0.387 -0.387 -0.387
timepoint60:SLC_GenotypeMUT  0.274 -0.387 -0.387 -0.387
                            tmpn45 tmpn60 SLC_GH SLC_GM
timepoint10                                            
timepoint15                                            
timepoint30                                            
timepoint45                                            
timepoint60                  0.500                     
SLC_GenotypeHET              0.298  0.298              
SLC_GenotypeMUT              0.274  0.274  0.655       
timepoint10:SLC_GenotypeHET -0.423 -0.423 -0.353 -0.231
timepoint15:SLC_GenotypeHET -0.423 -0.423 -0.353 -0.231
timepoint30:SLC_GenotypeHET -0.423 -0.423 -0.353 -0.231
timepoint45:SLC_GenotypeHET -0.845 -0.423 -0.353 -0.231
timepoint60:SLC_GenotypeHET -0.423 -0.845 -0.353 -0.231
timepoint10:SLC_GenotypeMUT -0.387 -0.387 -0.231 -0.353
timepoint15:SLC_GenotypeMUT -0.387 -0.387 -0.231 -0.353
timepoint30:SLC_GenotypeMUT -0.387 -0.387 -0.231 -0.353
timepoint45:SLC_GenotypeMUT -0.775 -0.387 -0.231 -0.353
timepoint60:SLC_GenotypeMUT -0.387 -0.775 -0.231 -0.353
                            t10:SLC_GH t15:SLC_GH
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
timepoint45:SLC_GenotypeHET  0.500      0.500    
timepoint60:SLC_GenotypeHET  0.500      0.500    
timepoint10:SLC_GenotypeMUT  0.655      0.327    
timepoint15:SLC_GenotypeMUT  0.327      0.655    
timepoint30:SLC_GenotypeMUT  0.327      0.327    
timepoint45:SLC_GenotypeMUT  0.327      0.327    
timepoint60:SLC_GenotypeMUT  0.327      0.327    
                            t30:SLC_GH t45:SLC_GH
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
timepoint45:SLC_GenotypeHET  0.500               
timepoint60:SLC_GenotypeHET  0.500      0.500    
timepoint10:SLC_GenotypeMUT  0.327      0.327    
timepoint15:SLC_GenotypeMUT  0.327      0.327    
timepoint30:SLC_GenotypeMUT  0.655      0.327    
timepoint45:SLC_GenotypeMUT  0.327      0.655    
timepoint60:SLC_GenotypeMUT  0.327      0.327    
                            t60:SLC_GH t10:SLC_GM
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
timepoint10:SLC_GenotypeMUT  0.327               
timepoint15:SLC_GenotypeMUT  0.327      0.500    
timepoint30:SLC_GenotypeMUT  0.327      0.500    
timepoint45:SLC_GenotypeMUT  0.327      0.500    
timepoint60:SLC_GenotypeMUT  0.655      0.500    
                            t15:SLC_GM t30:SLC_GM
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
timepoint60:SLC_GenotypeMUT  0.500      0.500    
                            t45:SLC_GM
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
timepoint45:SLC_GenotypeMUT           
timepoint60:SLC_GenotypeMUT  0.500    

Standardized Within-Group Residuals:
         Min           Q1          Med           Q3 
-2.034401270 -0.512281767  0.006796956  0.558048916 
         Max 
 2.564343794 

Number of Observations: 120
Number of Groups: 20 
