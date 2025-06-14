

Summary for all data:
Linear mixed-effects model fit by REML
 Data: data_long 
       AIC     BIC    logLik
  2020.052 2070.77 -998.0259

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    2.205942 1.320871

Fixed effects: FP_output ~ timepoint + Treatment + Sex + SLC_Genotype 
                    Value Std.Error  DF   t-value p-value
(Intercept)      0.868912 0.5890983 425  1.474987  0.1410
timepoint10      1.127907 0.2014310 425  5.599471  0.0000
timepoint15      2.127907 0.2014310 425 10.563950  0.0000
timepoint30      3.523256 0.2014310 425 17.491130  0.0000
timepoint45      4.430233 0.2014310 425 21.993797  0.0000
timepoint60      5.430233 0.2014310 425 26.958276  0.0000
TreatmentSaline  0.792226 0.4936367  81  1.604877  0.1124
SexMale         -0.623527 0.4965238  81 -1.255784  0.2128
SLC_GenotypeHET  0.736118 0.6096211  81  1.207501  0.2308
SLC_GenotypeMUT -0.543782 0.6501587  81 -0.836384  0.4054
 Correlation: 
                (Intr) tmpn10 tmpn15 tmpn30 tmpn45 tmpn60 TrtmnS SexMal SLC_GH
timepoint10     -0.171                                                        
timepoint15     -0.171  0.500                                                 
timepoint30     -0.171  0.500  0.500                                          
timepoint45     -0.171  0.500  0.500  0.500                                   
timepoint60     -0.171  0.500  0.500  0.500  0.500                            
TreatmentSaline -0.378  0.000  0.000  0.000  0.000  0.000                     
SexMale         -0.415  0.000  0.000  0.000  0.000  0.000  0.034              
SLC_GenotypeHET -0.543  0.000  0.000  0.000  0.000  0.000 -0.090 -0.120       
SLC_GenotypeMUT -0.582  0.000  0.000  0.000  0.000  0.000  0.008 -0.016  0.567

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3         Max 
-2.76866402 -0.57298905 -0.04558715  0.61844790  2.63871807 

Number of Observations: 516
Number of Groups: 86 


Summary for all data, non parametric:

	Kruskal-Wallis rank sum test

data:  FP_output by Treatment
Kruskal-Wallis chi-squared = 11.701, df = 1, p-value = 0.0006247



Summary for all data, time*ASO:
Linear mixed-effects model fit by REML
 Data: data_long 
       AIC      BIC    logLik
  2028.472 2100.155 -997.2362

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:     2.20565 1.323792

Fixed effects: FP_output ~ timepoint * Treatment + Sex + SLC_Genotype 
                                Value Std.Error  DF   t-value p-value
(Intercept)                  1.049575 0.6021487 420  1.743050  0.0821
timepoint10                  0.844444 0.2790799 420  3.025817  0.0026
timepoint15                  1.955556 0.2790799 420  7.007154  0.0000
timepoint30                  3.377778 0.2790799 420 12.103266  0.0000
timepoint45                  4.244444 0.2790799 420 15.208709  0.0000
timepoint60                  5.133333 0.2790799 420 18.393779  0.0000
TreatmentSaline              0.413274 0.5583439  81  0.740178  0.4613
SexMale                     -0.623527 0.4965238  81 -1.255784  0.2128
SLC_GenotypeHET              0.736118 0.6096211  81  1.207501  0.2308
SLC_GenotypeMUT             -0.543782 0.6501587  81 -0.836384  0.4054
timepoint10:TreatmentSaline  0.594580 0.4041902 420  1.471040  0.1420
timepoint15:TreatmentSaline  0.361518 0.4041902 420  0.894424  0.3716
timepoint30:TreatmentSaline  0.305149 0.4041902 420  0.754964  0.4507
timepoint45:TreatmentSaline  0.389702 0.4041902 420  0.964155  0.3355
timepoint60:TreatmentSaline  0.622764 0.4041902 420  1.540770  0.1241
 Correlation: 
                            (Intr) tmpn10 tmpn15 tmpn30 tmpn45 tmpn60 TrtmnS SexMal SLC_GH
timepoint10                 -0.232                                                        
timepoint15                 -0.232  0.500                                                 
timepoint30                 -0.232  0.500  0.500                                          
timepoint45                 -0.232  0.500  0.500  0.500                                   
timepoint60                 -0.232  0.500  0.500  0.500  0.500                            
TreatmentSaline             -0.423  0.250  0.250  0.250  0.250  0.250                     
SexMale                     -0.406  0.000  0.000  0.000  0.000  0.000  0.030              
SLC_GenotypeHET             -0.532  0.000  0.000  0.000  0.000  0.000 -0.079 -0.120       
SLC_GenotypeMUT             -0.569  0.000  0.000  0.000  0.000  0.000  0.007 -0.016  0.567
timepoint10:TreatmentSaline  0.160 -0.690 -0.345 -0.345 -0.345 -0.345 -0.362  0.000  0.000
timepoint15:TreatmentSaline  0.160 -0.345 -0.690 -0.345 -0.345 -0.345 -0.362  0.000  0.000
timepoint30:TreatmentSaline  0.160 -0.345 -0.345 -0.690 -0.345 -0.345 -0.362  0.000  0.000
timepoint45:TreatmentSaline  0.160 -0.345 -0.345 -0.345 -0.690 -0.345 -0.362  0.000  0.000
timepoint60:TreatmentSaline  0.160 -0.345 -0.345 -0.345 -0.345 -0.690 -0.362  0.000  0.000
                            SLC_GM t10:TS t15:TS t30:TS t45:TS
timepoint10                                                   
timepoint15                                                   
timepoint30                                                   
timepoint45                                                   
timepoint60                                                   
TreatmentSaline                                               
SexMale                                                       
SLC_GenotypeHET                                               
SLC_GenotypeMUT                                               
timepoint10:TreatmentSaline  0.000                            
timepoint15:TreatmentSaline  0.000  0.500                     
timepoint30:TreatmentSaline  0.000  0.500  0.500              
timepoint45:TreatmentSaline  0.000  0.500  0.500  0.500       
timepoint60:TreatmentSaline  0.000  0.500  0.500  0.500  0.500

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3         Max 
-2.89823931 -0.56091608 -0.02209926  0.62296177  2.72117799 

Number of Observations: 516
Number of Groups: 86 


Summary for all data, SLC*ASO:
Linear mixed-effects model fit by REML
 Data: data_long 
       AIC      BIC    logLik
  2017.565 2076.681 -994.7826

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    2.201994 1.320871

Fixed effects: FP_output ~ timepoint + Treatment * SLC_Genotype + Sex 
                                    Value Std.Error  DF   t-value p-value
(Intercept)                      0.553680 0.6957307 425  0.795825  0.4266
timepoint10                      1.127907 0.2014310 425  5.599471  0.0000
timepoint15                      2.127907 0.2014310 425 10.563950  0.0000
timepoint30                      3.523256 0.2014310 425 17.491130  0.0000
timepoint45                      4.430233 0.2014310 425 21.993797  0.0000
timepoint60                      5.430233 0.2014310 425 26.958276  0.0000
TreatmentSaline                  1.525455 0.9560616  79  1.595561  0.1146
SLC_GenotypeHET                  0.887364 0.8356385  79  1.061899  0.2915
SLC_GenotypeMUT                  0.242918 0.8590664  79  0.282770  0.7781
SexMale                         -0.630976 0.4975763  79 -1.268099  0.2085
TreatmentSaline:SLC_GenotypeHET -0.421286 1.2159517  79 -0.346466  0.7299
TreatmentSaline:SLC_GenotypeMUT -1.838804 1.3115104  79 -1.402051  0.1648
 Correlation: 
                                (Intr) tmpn10 tmpn15 tmpn30 tmpn45 tmpn60 TrtmnS SLC_GH
timepoint10                     -0.145                                                 
timepoint15                     -0.145  0.500                                          
timepoint30                     -0.145  0.500  0.500                                   
timepoint45                     -0.145  0.500  0.500  0.500                            
timepoint60                     -0.145  0.500  0.500  0.500  0.500                     
TreatmentSaline                 -0.622  0.000  0.000  0.000  0.000  0.000              
SLC_GenotypeHET                 -0.669  0.000  0.000  0.000  0.000  0.000  0.493       
SLC_GenotypeMUT                 -0.663  0.000  0.000  0.000  0.000  0.000  0.482  0.551
SexMale                         -0.385  0.000  0.000  0.000  0.000  0.000  0.072 -0.030
TreatmentSaline:SLC_GenotypeHET  0.499  0.000  0.000  0.000  0.000  0.000 -0.788 -0.684
TreatmentSaline:SLC_GenotypeMUT  0.442  0.000  0.000  0.000  0.000  0.000 -0.727 -0.360
                                SLC_GM SexMal TS:SLC_GH
timepoint10                                            
timepoint15                                            
timepoint30                                            
timepoint45                                            
timepoint60                                            
TreatmentSaline                                        
SLC_GenotypeHET                                        
SLC_GenotypeMUT                                        
SexMale                          0.003                 
TreatmentSaline:SLC_GenotypeHET -0.379 -0.082          
TreatmentSaline:SLC_GenotypeMUT -0.655 -0.023  0.572   

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3         Max 
-2.78793368 -0.56159947 -0.05383361  0.61253737  2.61920752 

Number of Observations: 516
Number of Groups: 86 


Summary for Tg Pos:
Linear mixed-effects model fit by REML
 Data: pos 
       AIC      BIC    logLik
  1093.999 1168.034 -525.9996

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    2.231901 1.412036

Fixed effects: FP_output ~ Sex + timepoint * SLC_Genotype 
                                Value Std.Error  DF   t-value p-value
(Intercept)                  0.289458 0.8219382 210  0.352165  0.7251
SexMale                      0.176720 0.6924587  41  0.255207  0.7998
timepoint10                  0.769231 0.5538462 210  1.388889  0.1663
timepoint15                  1.692308 0.5538462 210  3.055556  0.0025
timepoint30                  3.307692 0.5538462 210  5.972222  0.0000
timepoint45                  4.384615 0.5538462 210  7.916667  0.0000
timepoint60                  5.461538 0.5538462 210  9.861111  0.0000
SLC_GenotypeHET              1.194824 0.9736793  41  1.227123  0.2268
SLC_GenotypeMUT             -0.117042 1.0007916  41 -0.116950  0.9075
timepoint10:SLC_GenotypeHET  0.054299 0.7357416 210  0.073801  0.9412
timepoint15:SLC_GenotypeHET  0.190045 0.7357416 210  0.258304  0.7964
timepoint30:SLC_GenotypeHET -0.542986 0.7357416 210 -0.738012  0.4613
timepoint45:SLC_GenotypeHET -0.678733 0.7357416 210 -0.922516  0.3573
timepoint60:SLC_GenotypeHET -1.108597 0.7357416 210 -1.506775  0.1334
timepoint10:SLC_GenotypeMUT  0.164103 0.7566979 210  0.216867  0.8285
timepoint15:SLC_GenotypeMUT  0.574359 0.7566979 210  0.759033  0.4487
timepoint30:SLC_GenotypeMUT  0.825641 0.7566979 210  1.091110  0.2765
timepoint45:SLC_GenotypeMUT  0.348718 0.7566979 210  0.460842  0.6454
timepoint60:SLC_GenotypeMUT  0.271795 0.7566979 210  0.359185  0.7198
 Correlation: 
                            (Intr) SexMal tmpn10 tmpn15 tmpn30 tmpn45 tmpn60 SLC_GH SLC_GM
SexMale                     -0.454                                                        
timepoint10                 -0.337  0.000                                                 
timepoint15                 -0.337  0.000  0.500                                          
timepoint30                 -0.337  0.000  0.500  0.500                                   
timepoint45                 -0.337  0.000  0.500  0.500  0.500                            
timepoint60                 -0.337  0.000  0.500  0.500  0.500  0.500                     
SLC_GenotypeHET             -0.654 -0.035  0.284  0.284  0.284  0.284  0.284              
SLC_GenotypeMUT             -0.654  0.004  0.277  0.277  0.277  0.277  0.277  0.550       
timepoint10:SLC_GenotypeHET  0.254  0.000 -0.753 -0.376 -0.376 -0.376 -0.376 -0.378 -0.208
timepoint15:SLC_GenotypeHET  0.254  0.000 -0.376 -0.753 -0.376 -0.376 -0.376 -0.378 -0.208
timepoint30:SLC_GenotypeHET  0.254  0.000 -0.376 -0.376 -0.753 -0.376 -0.376 -0.378 -0.208
timepoint45:SLC_GenotypeHET  0.254  0.000 -0.376 -0.376 -0.376 -0.753 -0.376 -0.378 -0.208
timepoint60:SLC_GenotypeHET  0.254  0.000 -0.376 -0.376 -0.376 -0.376 -0.753 -0.378 -0.208
timepoint10:SLC_GenotypeMUT  0.247  0.000 -0.732 -0.366 -0.366 -0.366 -0.366 -0.208 -0.378
timepoint15:SLC_GenotypeMUT  0.247  0.000 -0.366 -0.732 -0.366 -0.366 -0.366 -0.208 -0.378
timepoint30:SLC_GenotypeMUT  0.247  0.000 -0.366 -0.366 -0.732 -0.366 -0.366 -0.208 -0.378
timepoint45:SLC_GenotypeMUT  0.247  0.000 -0.366 -0.366 -0.366 -0.732 -0.366 -0.208 -0.378
timepoint60:SLC_GenotypeMUT  0.247  0.000 -0.366 -0.366 -0.366 -0.366 -0.732 -0.208 -0.378
                            t10:SLC_GH t15:SLC_GH t30:SLC_GH t45:SLC_GH t60:SLC_GH
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
timepoint60:SLC_GenotypeHET  0.500      0.500      0.500      0.500               
timepoint10:SLC_GenotypeMUT  0.551      0.275      0.275      0.275      0.275    
timepoint15:SLC_GenotypeMUT  0.275      0.551      0.275      0.275      0.275    
timepoint30:SLC_GenotypeMUT  0.275      0.275      0.551      0.275      0.275    
timepoint45:SLC_GenotypeMUT  0.275      0.275      0.275      0.551      0.275    
timepoint60:SLC_GenotypeMUT  0.275      0.275      0.275      0.275      0.551    
                            t10:SLC_GM t15:SLC_GM t30:SLC_GM t45:SLC_GM
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
timepoint15:SLC_GenotypeMUT  0.500                                     
timepoint30:SLC_GenotypeMUT  0.500      0.500                          
timepoint45:SLC_GenotypeMUT  0.500      0.500      0.500               
timepoint60:SLC_GenotypeMUT  0.500      0.500      0.500      0.500    

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3         Max 
-2.47192219 -0.65676531  0.01307903  0.66949521  2.36442931 

Number of Observations: 270
Number of Groups: 45 


Summary for Tg Neg:
Linear mixed-effects model fit by REML
 Data: neg 
       AIC     BIC    logLik
  934.5257 1006.45 -446.2628

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    2.102216  1.21755

Fixed effects: FP_output ~ Sex + timepoint * SLC_Genotype 
                                Value Std.Error  DF   t-value p-value
(Intercept)                  1.622358 0.8169002 190  1.985993  0.0485
SexMale                     -1.555895 0.6944063  37 -2.240612  0.0311
timepoint10                  2.200000 0.5445050 190  4.040367  0.0001
timepoint15                  3.200000 0.5445050 190  5.876898  0.0000
timepoint30                  4.600000 0.5445050 190  8.448041  0.0000
timepoint45                  5.400000 0.5445050 190  9.917265  0.0000
timepoint60                  6.200000 0.5445050 190 11.386490  0.0000
SLC_GenotypeHET              1.288974 0.9567645  37  1.347221  0.1861
SLC_GenotypeMUT             -0.278769 1.0621347  37 -0.262461  0.7944
timepoint10:SLC_GenotypeHET -0.900000 0.6668797 190 -1.349569  0.1788
timepoint15:SLC_GenotypeHET -0.950000 0.6668797 190 -1.424545  0.1559
timepoint30:SLC_GenotypeHET -0.950000 0.6668797 190 -1.424545  0.1559
timepoint45:SLC_GenotypeHET -0.600000 0.6668797 190 -0.899713  0.3694
timepoint60:SLC_GenotypeHET -0.150000 0.6668797 190 -0.224928  0.8223
timepoint10:SLC_GenotypeMUT -1.200000 0.7523417 190 -1.595020  0.1124
timepoint15:SLC_GenotypeMUT -1.563636 0.7523417 190 -2.078359  0.0390
timepoint30:SLC_GenotypeMUT -1.690909 0.7523417 190 -2.247528  0.0258
timepoint45:SLC_GenotypeMUT -1.763636 0.7523417 190 -2.344196  0.0201
timepoint60:SLC_GenotypeMUT -1.381818 0.7523417 190 -1.836690  0.0678
 Correlation: 
                            (Intr) SexMal tmpn10 tmpn15 tmpn30 tmpn45 tmpn60 SLC_GH SLC_GM
SexMale                     -0.340                                                        
timepoint10                 -0.333  0.000                                                 
timepoint15                 -0.333  0.000  0.500                                          
timepoint30                 -0.333  0.000  0.500  0.500                                   
timepoint45                 -0.333  0.000  0.500  0.500  0.500                            
timepoint60                 -0.333  0.000  0.500  0.500  0.500  0.500                     
SLC_GenotypeHET             -0.693 -0.181  0.285  0.285  0.285  0.285  0.285              
SLC_GenotypeMUT             -0.668 -0.036  0.256  0.256  0.256  0.256  0.256  0.587       
timepoint10:SLC_GenotypeHET  0.272  0.000 -0.816 -0.408 -0.408 -0.408 -0.408 -0.349 -0.209
timepoint15:SLC_GenotypeHET  0.272  0.000 -0.408 -0.816 -0.408 -0.408 -0.408 -0.349 -0.209
timepoint30:SLC_GenotypeHET  0.272  0.000 -0.408 -0.408 -0.816 -0.408 -0.408 -0.349 -0.209
timepoint45:SLC_GenotypeHET  0.272  0.000 -0.408 -0.408 -0.408 -0.816 -0.408 -0.349 -0.209
timepoint60:SLC_GenotypeHET  0.272  0.000 -0.408 -0.408 -0.408 -0.408 -0.816 -0.349 -0.209
timepoint10:SLC_GenotypeMUT  0.241  0.000 -0.724 -0.362 -0.362 -0.362 -0.362 -0.206 -0.354
timepoint15:SLC_GenotypeMUT  0.241  0.000 -0.362 -0.724 -0.362 -0.362 -0.362 -0.206 -0.354
timepoint30:SLC_GenotypeMUT  0.241  0.000 -0.362 -0.362 -0.724 -0.362 -0.362 -0.206 -0.354
timepoint45:SLC_GenotypeMUT  0.241  0.000 -0.362 -0.362 -0.362 -0.724 -0.362 -0.206 -0.354
timepoint60:SLC_GenotypeMUT  0.241  0.000 -0.362 -0.362 -0.362 -0.362 -0.724 -0.206 -0.354
                            t10:SLC_GH t15:SLC_GH t30:SLC_GH t45:SLC_GH t60:SLC_GH
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
timepoint60:SLC_GenotypeHET  0.500      0.500      0.500      0.500               
timepoint10:SLC_GenotypeMUT  0.591      0.295      0.295      0.295      0.295    
timepoint15:SLC_GenotypeMUT  0.295      0.591      0.295      0.295      0.295    
timepoint30:SLC_GenotypeMUT  0.295      0.295      0.591      0.295      0.295    
timepoint45:SLC_GenotypeMUT  0.295      0.295      0.295      0.591      0.295    
timepoint60:SLC_GenotypeMUT  0.295      0.295      0.295      0.295      0.591    
                            t10:SLC_GM t15:SLC_GM t30:SLC_GM t45:SLC_GM
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
timepoint15:SLC_GenotypeMUT  0.500                                     
timepoint30:SLC_GenotypeMUT  0.500      0.500                          
timepoint45:SLC_GenotypeMUT  0.500      0.500      0.500               
timepoint60:SLC_GenotypeMUT  0.500      0.500      0.500      0.500    

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3         Max 
-2.28050076 -0.47982953 -0.03307568  0.56312975  2.53637542 

Number of Observations: 246
Number of Groups: 41 


Summary for Males Tg Pos:
Linear mixed-effects model fit by REML
 Data: pos_males 
       AIC      BIC    logLik
  597.9026 655.5587 -278.9513

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    2.308166 1.361398

Fixed effects: FP_output ~ timepoint * SLC_Genotype 
                                Value Std.Error  DF   t-value p-value
(Intercept)                  0.142857 1.0128484 110  0.141045  0.8881
timepoint10                  0.571429 0.7276977 110  0.785255  0.4340
timepoint15                  1.571429 0.7276977 110  2.159453  0.0330
timepoint30                  2.428571 0.7276977 110  3.337336  0.0012
timepoint45                  3.142857 0.7276977 110  4.318905  0.0000
timepoint60                  4.285714 0.7276977 110  5.889416  0.0000
SLC_GenotypeHET              1.357143 1.3205928  22  1.027677  0.3153
SLC_GenotypeMUT              0.357143 1.3868998  22  0.257512  0.7992
timepoint10:SLC_GenotypeHET  0.028571 0.9488017 110  0.030113  0.9760
timepoint15:SLC_GenotypeHET  0.128571 0.9488017 110  0.135509  0.8925
timepoint30:SLC_GenotypeHET  0.171429 0.9488017 110  0.180679  0.8570
timepoint45:SLC_GenotypeHET  0.457143 0.9488017 110  0.481811  0.6309
timepoint60:SLC_GenotypeHET -0.185714 0.9488017 110 -0.195736  0.8452
timepoint10:SLC_GenotypeMUT  0.803571 0.9964411 110  0.806441  0.4217
timepoint15:SLC_GenotypeMUT  1.803571 0.9964411 110  1.810013  0.0730
timepoint30:SLC_GenotypeMUT  3.196429 0.9964411 110  3.207845  0.0018
timepoint45:SLC_GenotypeMUT  3.107143 0.9964411 110  3.118240  0.0023
timepoint60:SLC_GenotypeMUT  3.214286 0.9964411 110  3.225766  0.0017
 Correlation: 
                            (Intr) tmpn10 tmpn15 tmpn30 tmpn45 tmpn60 SLC_GH SLC_GM
timepoint10                 -0.359                                                 
timepoint15                 -0.359  0.500                                          
timepoint30                 -0.359  0.500  0.500                                   
timepoint45                 -0.359  0.500  0.500  0.500                            
timepoint60                 -0.359  0.500  0.500  0.500  0.500                     
SLC_GenotypeHET             -0.767  0.276  0.276  0.276  0.276  0.276              
SLC_GenotypeMUT             -0.730  0.262  0.262  0.262  0.262  0.262  0.560       
timepoint10:SLC_GenotypeHET  0.276 -0.767 -0.383 -0.383 -0.383 -0.383 -0.359 -0.201
timepoint15:SLC_GenotypeHET  0.276 -0.383 -0.767 -0.383 -0.383 -0.383 -0.359 -0.201
timepoint30:SLC_GenotypeHET  0.276 -0.383 -0.383 -0.767 -0.383 -0.383 -0.359 -0.201
timepoint45:SLC_GenotypeHET  0.276 -0.383 -0.383 -0.383 -0.767 -0.383 -0.359 -0.201
timepoint60:SLC_GenotypeHET  0.276 -0.383 -0.383 -0.383 -0.383 -0.767 -0.359 -0.201
timepoint10:SLC_GenotypeMUT  0.262 -0.730 -0.365 -0.365 -0.365 -0.365 -0.201 -0.359
timepoint15:SLC_GenotypeMUT  0.262 -0.365 -0.730 -0.365 -0.365 -0.365 -0.201 -0.359
timepoint30:SLC_GenotypeMUT  0.262 -0.365 -0.365 -0.730 -0.365 -0.365 -0.201 -0.359
timepoint45:SLC_GenotypeMUT  0.262 -0.365 -0.365 -0.365 -0.730 -0.365 -0.201 -0.359
timepoint60:SLC_GenotypeMUT  0.262 -0.365 -0.365 -0.365 -0.365 -0.730 -0.201 -0.359
                            t10:SLC_GH t15:SLC_GH t30:SLC_GH t45:SLC_GH t60:SLC_GH
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
timepoint60:SLC_GenotypeHET  0.500      0.500      0.500      0.500               
timepoint10:SLC_GenotypeMUT  0.560      0.280      0.280      0.280      0.280    
timepoint15:SLC_GenotypeMUT  0.280      0.560      0.280      0.280      0.280    
timepoint30:SLC_GenotypeMUT  0.280      0.280      0.560      0.280      0.280    
timepoint45:SLC_GenotypeMUT  0.280      0.280      0.280      0.560      0.280    
timepoint60:SLC_GenotypeMUT  0.280      0.280      0.280      0.280      0.560    
                            t10:SLC_GM t15:SLC_GM t30:SLC_GM t45:SLC_GM
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
timepoint15:SLC_GenotypeMUT  0.500                                     
timepoint30:SLC_GenotypeMUT  0.500      0.500                          
timepoint45:SLC_GenotypeMUT  0.500      0.500      0.500               
timepoint60:SLC_GenotypeMUT  0.500      0.500      0.500      0.500    

Standardized Within-Group Residuals:
          Min            Q1           Med            Q3           Max 
-2.2822533766 -0.5386446341 -0.0003608265  0.6427316534  2.3086167492 

Number of Observations: 150
Number of Groups: 25 


Summary for Males Tg Neg:
Linear mixed-effects model fit by REML
 Data: neg_males 
       AIC     BIC    logLik
  498.2591 552.983 -229.1295

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    2.255642 1.205685

Fixed effects: FP_output ~ timepoint * SLC_Genotype 
                                Value Std.Error DF   t-value p-value
(Intercept)                  0.750000 1.2788275 95  0.586475  0.5589
timepoint10                  2.250000 0.8525484 95  2.639146  0.0097
timepoint15                  3.250000 0.8525484 95  3.812100  0.0002
timepoint30                  3.750000 0.8525484 95  4.398577  0.0000
timepoint45                  5.000000 0.8525484 95  5.864770  0.0000
timepoint60                  5.000000 0.8525484 95  5.864770  0.0000
SLC_GenotypeHET              0.942308 1.4623952 19  0.644359  0.5270
SLC_GenotypeMUT             -0.550000 1.7157271 19 -0.320564  0.7520
timepoint10:SLC_GenotypeHET -1.173077 0.9749264 95 -1.203247  0.2319
timepoint15:SLC_GenotypeHET -1.096154 0.9749264 95 -1.124345  0.2637
timepoint30:SLC_GenotypeHET -0.288462 0.9749264 95 -0.295880  0.7680
timepoint45:SLC_GenotypeHET -0.461538 0.9749264 95 -0.473409  0.6370
timepoint60:SLC_GenotypeHET  0.384615 0.9749264 95  0.394507  0.6941
timepoint10:SLC_GenotypeMUT -2.250000 1.1438137 95 -1.967104  0.0521
timepoint15:SLC_GenotypeMUT -2.450000 1.1438137 95 -2.141957  0.0348
timepoint30:SLC_GenotypeMUT -1.350000 1.1438137 95 -1.180262  0.2408
timepoint45:SLC_GenotypeMUT -2.600000 1.1438137 95 -2.273098  0.0253
timepoint60:SLC_GenotypeMUT -2.000000 1.1438137 95 -1.748537  0.0836
 Correlation: 
                            (Intr) tmpn10 tmpn15 tmpn30 tmpn45 tmpn60 SLC_GH SLC_GM
timepoint10                 -0.333                                                 
timepoint15                 -0.333  0.500                                          
timepoint30                 -0.333  0.500  0.500                                   
timepoint45                 -0.333  0.500  0.500  0.500                            
timepoint60                 -0.333  0.500  0.500  0.500  0.500                     
SLC_GenotypeHET             -0.874  0.291  0.291  0.291  0.291  0.291              
SLC_GenotypeMUT             -0.745  0.248  0.248  0.248  0.248  0.248  0.652       
timepoint10:SLC_GenotypeHET  0.291 -0.874 -0.437 -0.437 -0.437 -0.437 -0.333 -0.217
timepoint15:SLC_GenotypeHET  0.291 -0.437 -0.874 -0.437 -0.437 -0.437 -0.333 -0.217
timepoint30:SLC_GenotypeHET  0.291 -0.437 -0.437 -0.874 -0.437 -0.437 -0.333 -0.217
timepoint45:SLC_GenotypeHET  0.291 -0.437 -0.437 -0.437 -0.874 -0.437 -0.333 -0.217
timepoint60:SLC_GenotypeHET  0.291 -0.437 -0.437 -0.437 -0.437 -0.874 -0.333 -0.217
timepoint10:SLC_GenotypeMUT  0.248 -0.745 -0.373 -0.373 -0.373 -0.373 -0.217 -0.333
timepoint15:SLC_GenotypeMUT  0.248 -0.373 -0.745 -0.373 -0.373 -0.373 -0.217 -0.333
timepoint30:SLC_GenotypeMUT  0.248 -0.373 -0.373 -0.745 -0.373 -0.373 -0.217 -0.333
timepoint45:SLC_GenotypeMUT  0.248 -0.373 -0.373 -0.373 -0.745 -0.373 -0.217 -0.333
timepoint60:SLC_GenotypeMUT  0.248 -0.373 -0.373 -0.373 -0.373 -0.745 -0.217 -0.333
                            t10:SLC_GH t15:SLC_GH t30:SLC_GH t45:SLC_GH t60:SLC_GH
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
timepoint60:SLC_GenotypeHET  0.500      0.500      0.500      0.500               
timepoint10:SLC_GenotypeMUT  0.652      0.326      0.326      0.326      0.326    
timepoint15:SLC_GenotypeMUT  0.326      0.652      0.326      0.326      0.326    
timepoint30:SLC_GenotypeMUT  0.326      0.326      0.652      0.326      0.326    
timepoint45:SLC_GenotypeMUT  0.326      0.326      0.326      0.652      0.326    
timepoint60:SLC_GenotypeMUT  0.326      0.326      0.326      0.326      0.652    
                            t10:SLC_GM t15:SLC_GM t30:SLC_GM t45:SLC_GM
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
timepoint15:SLC_GenotypeMUT  0.500                                     
timepoint30:SLC_GenotypeMUT  0.500      0.500                          
timepoint45:SLC_GenotypeMUT  0.500      0.500      0.500               
timepoint60:SLC_GenotypeMUT  0.500      0.500      0.500      0.500    

Standardized Within-Group Residuals:
         Min           Q1          Med           Q3          Max 
-2.307250976 -0.496554209  0.003770244  0.574565038  3.332694221 

Number of Observations: 132
Number of Groups: 22 


Summary for Males Tg Pos:
Linear mixed-effects model fit by REML
 Data: pos_females 
       AIC      BIC    logLik
  461.1172 513.6167 -210.5586

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    1.690447 1.323052

Fixed effects: FP_output ~ timepoint * SLC_Genotype 
                                Value Std.Error DF   t-value p-value
(Intercept)                  0.666667 0.8763634 85  0.760719  0.4489
timepoint10                  1.000000 0.7638645 85  1.309133  0.1940
timepoint15                  1.833333 0.7638645 85  2.400077  0.0186
timepoint30                  4.333333 0.7638645 85  5.672909  0.0000
timepoint45                  5.833333 0.7638645 85  7.636608  0.0000
timepoint60                  6.833333 0.7638645 85  8.945740  0.0000
SLC_GenotypeHET              1.047619 1.1942820 17  0.877196  0.3926
SLC_GenotypeMUT             -0.666667 1.1942820 17 -0.558215  0.5840
timepoint10:SLC_GenotypeHET  0.142857 1.0409718 85  0.137234  0.8912
timepoint15:SLC_GenotypeHET  0.309524 1.0409718 85  0.297341  0.7669
timepoint30:SLC_GenotypeHET -1.333333 1.0409718 85 -1.280854  0.2037
timepoint45:SLC_GenotypeHET -1.976190 1.0409718 85 -1.898409  0.0610
timepoint60:SLC_GenotypeHET -2.119048 1.0409718 85 -2.035644  0.0449
timepoint10:SLC_GenotypeMUT -0.571429 1.0409718 85 -0.548938  0.5845
timepoint15:SLC_GenotypeMUT -0.833333 1.0409718 85 -0.800534  0.4256
timepoint30:SLC_GenotypeMUT -1.904762 1.0409718 85 -1.829792  0.0708
timepoint45:SLC_GenotypeMUT -2.833333 1.0409718 85 -2.721816  0.0079
timepoint60:SLC_GenotypeMUT -3.119048 1.0409718 85 -2.996284  0.0036
 Correlation: 
                            (Intr) tmpn10 tmpn15 tmpn30 tmpn45 tmpn60 SLC_GH SLC_GM
timepoint10                 -0.436                                                 
timepoint15                 -0.436  0.500                                          
timepoint30                 -0.436  0.500  0.500                                   
timepoint45                 -0.436  0.500  0.500  0.500                            
timepoint60                 -0.436  0.500  0.500  0.500  0.500                     
SLC_GenotypeHET             -0.734  0.320  0.320  0.320  0.320  0.320              
SLC_GenotypeMUT             -0.734  0.320  0.320  0.320  0.320  0.320  0.538       
timepoint10:SLC_GenotypeHET  0.320 -0.734 -0.367 -0.367 -0.367 -0.367 -0.436 -0.235
timepoint15:SLC_GenotypeHET  0.320 -0.367 -0.734 -0.367 -0.367 -0.367 -0.436 -0.235
timepoint30:SLC_GenotypeHET  0.320 -0.367 -0.367 -0.734 -0.367 -0.367 -0.436 -0.235
timepoint45:SLC_GenotypeHET  0.320 -0.367 -0.367 -0.367 -0.734 -0.367 -0.436 -0.235
timepoint60:SLC_GenotypeHET  0.320 -0.367 -0.367 -0.367 -0.367 -0.734 -0.436 -0.235
timepoint10:SLC_GenotypeMUT  0.320 -0.734 -0.367 -0.367 -0.367 -0.367 -0.235 -0.436
timepoint15:SLC_GenotypeMUT  0.320 -0.367 -0.734 -0.367 -0.367 -0.367 -0.235 -0.436
timepoint30:SLC_GenotypeMUT  0.320 -0.367 -0.367 -0.734 -0.367 -0.367 -0.235 -0.436
timepoint45:SLC_GenotypeMUT  0.320 -0.367 -0.367 -0.367 -0.734 -0.367 -0.235 -0.436
timepoint60:SLC_GenotypeMUT  0.320 -0.367 -0.367 -0.367 -0.367 -0.734 -0.235 -0.436
                            t10:SLC_GH t15:SLC_GH t30:SLC_GH t45:SLC_GH t60:SLC_GH
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
timepoint60:SLC_GenotypeHET  0.500      0.500      0.500      0.500               
timepoint10:SLC_GenotypeMUT  0.538      0.269      0.269      0.269      0.269    
timepoint15:SLC_GenotypeMUT  0.269      0.538      0.269      0.269      0.269    
timepoint30:SLC_GenotypeMUT  0.269      0.269      0.538      0.269      0.269    
timepoint45:SLC_GenotypeMUT  0.269      0.269      0.269      0.538      0.269    
timepoint60:SLC_GenotypeMUT  0.269      0.269      0.269      0.269      0.538    
                            t10:SLC_GM t15:SLC_GM t30:SLC_GM t45:SLC_GM
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
timepoint15:SLC_GenotypeMUT  0.500                                     
timepoint30:SLC_GenotypeMUT  0.500      0.500                          
timepoint45:SLC_GenotypeMUT  0.500      0.500      0.500               
timepoint60:SLC_GenotypeMUT  0.500      0.500      0.500      0.500    

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3         Max 
-1.63023306 -0.67112375 -0.01307272  0.58035686  2.14890762 

Number of Observations: 120
Number of Groups: 20 


Summary for Males Tg Neg:
Linear mixed-effects model fit by REML
 Data: neg_females 
       AIC      BIC    logLik
  420.5415 471.8285 -190.2707

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    2.011253 1.154915

Fixed effects: FP_output ~ timepoint * SLC_Genotype 
                                Value Std.Error DF   t-value p-value
(Intercept)                  1.166667 0.9468340 80  1.232177  0.2215
timepoint10                  2.166667 0.6667907 80  3.249396  0.0017
timepoint15                  3.166667 0.6667907 80  4.749117  0.0000
timepoint30                  5.166667 0.6667907 80  7.748559  0.0000
timepoint45                  5.666667 0.6667907 80  8.498419  0.0000
timepoint60                  7.000000 0.6667907 80 10.498047  0.0000
SLC_GenotypeHET              1.119048 1.2903173 16  0.867265  0.3986
SLC_GenotypeMUT             -0.166667 1.3390255 16 -0.124469  0.9025
timepoint10:SLC_GenotypeHET -0.452381 0.9086825 80 -0.497843  0.6200
timepoint15:SLC_GenotypeHET -0.738095 0.9086825 80 -0.812270  0.4190
timepoint30:SLC_GenotypeHET -1.166667 0.9086825 80 -1.283910  0.2029
timepoint45:SLC_GenotypeHET -0.380952 0.9086825 80 -0.419236  0.6762
timepoint60:SLC_GenotypeHET  0.285714 0.9086825 80  0.314427  0.7540
timepoint10:SLC_GenotypeMUT -0.333333 0.9429844 80 -0.353488  0.7247
timepoint15:SLC_GenotypeMUT -0.833333 0.9429844 80 -0.883719  0.3795
timepoint30:SLC_GenotypeMUT -1.833333 0.9429844 80 -1.944182  0.0554
timepoint45:SLC_GenotypeMUT -1.000000 0.9429844 80 -1.060463  0.2921
timepoint60:SLC_GenotypeMUT -0.666667 0.9429844 80 -0.706975  0.4816
 Correlation: 
                            (Intr) tmpn10 tmpn15 tmpn30 tmpn45 tmpn60 SLC_GH SLC_GM
timepoint10                 -0.352                                                 
timepoint15                 -0.352  0.500                                          
timepoint30                 -0.352  0.500  0.500                                   
timepoint45                 -0.352  0.500  0.500  0.500                            
timepoint60                 -0.352  0.500  0.500  0.500  0.500                     
SLC_GenotypeHET             -0.734  0.258  0.258  0.258  0.258  0.258              
SLC_GenotypeMUT             -0.707  0.249  0.249  0.249  0.249  0.249  0.519       
timepoint10:SLC_GenotypeHET  0.258 -0.734 -0.367 -0.367 -0.367 -0.367 -0.352 -0.183
timepoint15:SLC_GenotypeHET  0.258 -0.367 -0.734 -0.367 -0.367 -0.367 -0.352 -0.183
timepoint30:SLC_GenotypeHET  0.258 -0.367 -0.367 -0.734 -0.367 -0.367 -0.352 -0.183
timepoint45:SLC_GenotypeHET  0.258 -0.367 -0.367 -0.367 -0.734 -0.367 -0.352 -0.183
timepoint60:SLC_GenotypeHET  0.258 -0.367 -0.367 -0.367 -0.367 -0.734 -0.352 -0.183
timepoint10:SLC_GenotypeMUT  0.249 -0.707 -0.354 -0.354 -0.354 -0.354 -0.183 -0.352
timepoint15:SLC_GenotypeMUT  0.249 -0.354 -0.707 -0.354 -0.354 -0.354 -0.183 -0.352
timepoint30:SLC_GenotypeMUT  0.249 -0.354 -0.354 -0.707 -0.354 -0.354 -0.183 -0.352
timepoint45:SLC_GenotypeMUT  0.249 -0.354 -0.354 -0.354 -0.707 -0.354 -0.183 -0.352
timepoint60:SLC_GenotypeMUT  0.249 -0.354 -0.354 -0.354 -0.354 -0.707 -0.183 -0.352
                            t10:SLC_GH t15:SLC_GH t30:SLC_GH t45:SLC_GH t60:SLC_GH
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
timepoint60:SLC_GenotypeHET  0.500      0.500      0.500      0.500               
timepoint10:SLC_GenotypeMUT  0.519      0.259      0.259      0.259      0.259    
timepoint15:SLC_GenotypeMUT  0.259      0.519      0.259      0.259      0.259    
timepoint30:SLC_GenotypeMUT  0.259      0.259      0.519      0.259      0.259    
timepoint45:SLC_GenotypeMUT  0.259      0.259      0.259      0.519      0.259    
timepoint60:SLC_GenotypeMUT  0.259      0.259      0.259      0.259      0.519    
                            t10:SLC_GM t15:SLC_GM t30:SLC_GM t45:SLC_GM
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
timepoint15:SLC_GenotypeMUT  0.500                                     
timepoint30:SLC_GenotypeMUT  0.500      0.500                          
timepoint45:SLC_GenotypeMUT  0.500      0.500      0.500               
timepoint60:SLC_GenotypeMUT  0.500      0.500      0.500      0.500    

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3         Max 
-3.07737662 -0.46463600 -0.03495591  0.42941939  2.36519934 

Number of Observations: 114
Number of Groups: 19 
