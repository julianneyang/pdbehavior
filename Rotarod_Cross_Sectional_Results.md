

LMEM on Full Dataset, Tg + vs Tg -:
Linear mixed-effects model fit by REML
  Data: data 
       AIC      BIC    logLik
  2063.255 2103.703 -1019.627

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    23.20094 19.22881

Fixed effects:  Average_Latency ~ ASO_Tg * Day + Weight + SLC_Genotype + Sex 
                            Value Std.Error  DF   t-value p-value
(Intercept)             163.61612 17.077119 146  9.581014  0.0000
ASO_TgPositive           14.02732  7.095248  69  1.977003  0.0520
DayTwo                   13.23000  4.299692 146  3.076965  0.0025
DayThree                 14.94583  4.299692 146  3.476024  0.0007
Weight                   -3.12102  0.500645  69 -6.234002  0.0000
SLC_GenotypeHET           9.29524  7.705059  69  1.206381  0.2318
SLC_GenotypeMUT          11.34695  8.850117  69  1.282124  0.2041
SexMale                  -4.82562  7.746281  69 -0.622959  0.5354
ASO_TgPositive:DayTwo     6.40667  6.294104 146  1.017884  0.3104
ASO_TgPositive:DayThree  -4.82821  6.294104 146 -0.767101  0.4443
 Correlation: 
                        (Intr) ASO_TgP DayTwo DayThr Weight SLC_GH SLC_GM SexMal
ASO_TgPositive          -0.184                                                  
DayTwo                  -0.126  0.303                                           
DayThree                -0.126  0.303   0.500                                   
Weight                  -0.872 -0.054   0.000  0.000                            
SLC_GenotypeHET         -0.314  0.125   0.000  0.000 -0.023                     
SLC_GenotypeMUT         -0.321 -0.003   0.000  0.000  0.021  0.596              
SexMale                  0.375  0.072   0.000  0.000 -0.605 -0.027  0.118       
ASO_TgPositive:DayTwo    0.086 -0.444  -0.683 -0.342  0.000  0.000  0.000  0.000
ASO_TgPositive:DayThree  0.086 -0.444  -0.342 -0.683  0.000  0.000  0.000  0.000
                        ASO_TgPstv:DyTw
ASO_TgPositive                         
DayTwo                                 
DayThree                               
Weight                                 
SLC_GenotypeHET                        
SLC_GenotypeMUT                        
SexMale                                
ASO_TgPositive:DayTwo                  
ASO_TgPositive:DayThree  0.500         

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3         Max 
-2.25906969 -0.51487790 -0.05738133  0.47414717  2.37881306 

Number of Observations: 225
Number of Groups: 75 


LMEM on Tg Pos:
Linear mixed-effects model fit by REML
  Data: subset(data, ASO_Tg == "Positive") 
      AIC      BIC   logLik
  940.008 973.0708 -457.004

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    25.56681 19.65513

Fixed effects:  Average_Latency ~ SLC_Genotype * Day + Weight + SLC_Genotype +      Sex 
                             Value Std.Error DF   t-value p-value
(Intercept)              201.54049 26.993550 64  7.466246  0.0000
SLC_GenotypeHET           22.67366 13.721878 30  1.652373  0.1089
SLC_GenotypeMUT           35.32875 14.629654 30  2.414873  0.0220
DayTwo                    29.45556  9.265515 64  3.179052  0.0023
DayThree                  20.59630  9.265515 64  2.222898  0.0298
Weight                    -4.28010  0.850490 30 -5.032517  0.0000
SexMale                    1.90238 13.518767 30  0.140721  0.8890
SLC_GenotypeHET:DayTwo   -19.53556 11.720053 64 -1.666849  0.1004
SLC_GenotypeMUT:DayTwo    -4.60253 12.493618 64 -0.368390  0.7138
SLC_GenotypeHET:DayThree -11.76074 11.720053 64 -1.003472  0.3194
SLC_GenotypeMUT:DayThree -17.30387 12.493618 64 -1.385017  0.1709
 Correlation: 
                         (Intr) SLC_GnHET SLC_GnMUT DayTwo DayThr Weight SexMal
SLC_GenotypeHET          -0.195                                                
SLC_GenotypeMUT          -0.247  0.577                                         
DayTwo                   -0.172  0.338     0.317                               
DayThree                 -0.172  0.338     0.317     0.500                     
Weight                   -0.903 -0.118    -0.071     0.000  0.000              
SexMale                   0.504  0.035     0.133     0.000  0.000 -0.688       
SLC_GenotypeHET:DayTwo    0.136 -0.427    -0.250    -0.791 -0.395  0.000  0.000
SLC_GenotypeMUT:DayTwo    0.127 -0.250    -0.427    -0.742 -0.371  0.000  0.000
SLC_GenotypeHET:DayThree  0.136 -0.427    -0.250    -0.395 -0.791  0.000  0.000
SLC_GenotypeMUT:DayThree  0.127 -0.250    -0.427    -0.371 -0.742  0.000  0.000
                         SLC_GntypHET:DyTw SLC_GntypMUT:DyTw SLC_GntypHET:DyTh
SLC_GenotypeHET                                                               
SLC_GenotypeMUT                                                               
DayTwo                                                                        
DayThree                                                                      
Weight                                                                        
SexMale                                                                       
SLC_GenotypeHET:DayTwo                                                        
SLC_GenotypeMUT:DayTwo    0.586                                               
SLC_GenotypeHET:DayThree  0.500             0.293                             
SLC_GenotypeMUT:DayThree  0.293             0.500             0.586           

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3         Max 
-2.16547724 -0.39835211 -0.05476895  0.43432694  2.48339877 

Number of Observations: 105
Number of Groups: 35 


LMEM on Tg Neg:
Linear mixed-effects model fit by REML
  Data: subset(data, ASO_Tg == "Negative") 
       AIC      BIC    logLik
  1053.472 1088.459 -513.7359

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    17.49233 18.83432

Fixed effects:  Average_Latency ~ SLC_Genotype * Day + Weight + SLC_Genotype +      Sex 
                             Value Std.Error DF   t-value p-value
(Intercept)              145.92540 20.094076 74  7.262110  0.0000
SLC_GenotypeHET           -0.73506 11.019602 35 -0.066705  0.9472
SLC_GenotypeMUT          -10.26581 13.551695 35 -0.757529  0.4538
DayTwo                     7.46190 10.067368 74  0.741197  0.4609
DayThree                   4.86190 10.067368 74  0.482937  0.6306
Weight                    -2.26312  0.535067 35 -4.229594  0.0002
SexMale                   -7.82166  7.990594 35 -0.978859  0.3344
SLC_GenotypeHET:DayTwo     9.40476 11.389927 74  0.825709  0.4116
SLC_GenotypeMUT:DayTwo    -0.54940 13.785312 74 -0.039854  0.9683
SLC_GenotypeHET:DayThree  12.95676 11.389927 74  1.137563  0.2590
SLC_GenotypeMUT:DayThree   9.92976 13.785312 74  0.720315  0.4736
 Correlation: 
                         (Intr) SLC_GnHET SLC_GnMUT DayTwo DayThr Weight SexMal
SLC_GenotypeHET          -0.482                                                
SLC_GenotypeMUT          -0.465  0.636                                         
DayTwo                   -0.251  0.457     0.371                               
DayThree                 -0.251  0.457     0.371     0.500                     
Weight                   -0.854  0.069     0.102     0.000  0.000              
SexMale                   0.287 -0.051     0.083     0.000  0.000 -0.528       
SLC_GenotypeHET:DayTwo    0.221 -0.517    -0.328    -0.884 -0.442  0.000  0.000
SLC_GenotypeMUT:DayTwo    0.183 -0.334    -0.509    -0.730 -0.365  0.000  0.000
SLC_GenotypeHET:DayThree  0.221 -0.517    -0.328    -0.442 -0.884  0.000  0.000
SLC_GenotypeMUT:DayThree  0.183 -0.334    -0.509    -0.365 -0.730  0.000  0.000
                         SLC_GntypHET:DyTw SLC_GntypMUT:DyTw SLC_GntypHET:DyTh
SLC_GenotypeHET                                                               
SLC_GenotypeMUT                                                               
DayTwo                                                                        
DayThree                                                                      
Weight                                                                        
SexMale                                                                       
SLC_GenotypeHET:DayTwo                                                        
SLC_GenotypeMUT:DayTwo    0.645                                               
SLC_GenotypeHET:DayThree  0.500             0.323                             
SLC_GenotypeMUT:DayThree  0.323             0.500             0.645           

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3         Max 
-1.93852332 -0.60433798 -0.01154835  0.47536488  2.29971021 

Number of Observations: 120
Number of Groups: 40 
