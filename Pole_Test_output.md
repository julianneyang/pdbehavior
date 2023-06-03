## Average_Tturn 

## Average_Tturn 

 Call: lm(formula = formula_lm_full, data = data_long)  Residuals:     Min      1Q  Median      3Q     Max  -5.4156 -1.0950  0.2091  1.1838  2.8077   Coefficients:                  Estimate Std. Error t value Pr(>|t|)     (Intercept)      4.282826   0.212217  20.181  < 2e-16 *** SexMale         -0.049306   0.099639  -0.495  0.62077     SLC_GenotypeHET  0.295397   0.099594   2.966  0.00306 **  SLC_GenotypeMUT -0.643300   0.114341  -5.626 2.12e-08 *** Weight           0.108944   0.006268  17.381  < 2e-16 *** ASO_TgPositive   0.751720   0.078765   9.544  < 2e-16 *** --- Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1  Residual standard error: 1.662 on 1869 degrees of freedom Multiple R-squared:  0.2737,	Adjusted R-squared:  0.2718  F-statistic: 140.9 on 5 and 1869 DF,  p-value: < 2.2e-16  

## Average_Tturn  (Positive ASO_Tg)

 Call: lm(formula = formula_lm_pos, data = data_long_pos)  Residuals:     Min      1Q  Median      3Q     Max  -5.4416 -0.7069  0.0303  0.8741  2.3484   Coefficients:                  Estimate Std. Error t value Pr(>|t|)     (Intercept)      5.496269   0.259458  21.184  < 2e-16 *** SexMale         -0.172193   0.136271  -1.264 0.206710     SLC_GenotypeHET  0.433945   0.125093   3.469 0.000548 *** SLC_GenotypeMUT -0.315653   0.133081  -2.372 0.017914 *   Weight           0.092503   0.008371  11.051  < 2e-16 *** --- Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1  Residual standard error: 1.453 on 870 degrees of freedom Multiple R-squared:  0.2403,	Adjusted R-squared:  0.2368  F-statistic:  68.8 on 4 and 870 DF,  p-value: < 2.2e-16  

## Average_Tturn  (Negative ASO_Tg)

 Call: lm(formula = formula_lm_neg, data = data_long_neg)  Residuals:     Min      1Q  Median      3Q     Max  -3.9539 -1.3987  0.3927  1.2127  2.9871   Coefficients:                  Estimate Std. Error t value Pr(>|t|)     (Intercept)      3.872926   0.336971  11.493  < 2e-16 *** SexMale          0.070417   0.141675   0.497    0.619     SLC_GenotypeHET  0.183525   0.155403   1.181    0.238     SLC_GenotypeMUT -0.989578   0.192241  -5.148 3.18e-07 *** Weight           0.122863   0.009286  13.230  < 2e-16 *** --- Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1  Residual standard error: 1.804 on 995 degrees of freedom Multiple R-squared:  0.2834,	Adjusted R-squared:  0.2805  F-statistic: 98.39 on 4 and 995 DF,  p-value: < 2.2e-16  

## Average_Ttotal 

 Call: lm(formula = formula_lm_full, data = data_long)  Residuals:     Min      1Q  Median      3Q     Max  -6.7124 -1.7069  0.3135  1.5994  3.6501   Coefficients:                  Estimate Std. Error t value Pr(>|t|)     (Intercept)      6.262165   0.286941  21.824  < 2e-16 *** SexMale         -0.124284   0.134723  -0.923  0.35638     SLC_GenotypeHET  0.410031   0.134662   3.045  0.00236 **  SLC_GenotypeMUT -1.363544   0.154602  -8.820  < 2e-16 *** Weight           0.173918   0.008475  20.521  < 2e-16 *** ASO_TgPositive   1.035421   0.106500   9.722  < 2e-16 *** --- Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1  Residual standard error: 2.247 on 1869 degrees of freedom Multiple R-squared:  0.3513,	Adjusted R-squared:  0.3496  F-statistic: 202.4 on 5 and 1869 DF,  p-value: < 2.2e-16  

## Average_Ttotal  (Positive ASO_Tg)

 Call: lm(formula = formula_lm_pos, data = data_long_pos)  Residuals:     Min      1Q  Median      3Q     Max  -7.0266 -1.1321  0.3439  1.4026  3.2478   Coefficients:                 Estimate Std. Error t value Pr(>|t|)     (Intercept)      8.34192    0.37567  22.206  < 2e-16 *** SexMale         -0.29702    0.19731  -1.505    0.133     SLC_GenotypeHET  0.25672    0.18112   1.417    0.157     SLC_GenotypeMUT -1.19495    0.19269  -6.202 8.63e-10 *** Weight           0.14636    0.01212  12.077  < 2e-16 *** --- Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1  Residual standard error: 2.104 on 870 degrees of freedom Multiple R-squared:  0.2855,	Adjusted R-squared:  0.2822  F-statistic: 86.91 on 4 and 870 DF,  p-value: < 2.2e-16  

## Average_Ttotal  (Negative ASO_Tg)

 Call: lm(formula = formula_lm_neg, data = data_long_neg)  Residuals:     Min      1Q  Median      3Q     Max  -5.5342 -1.8805  0.6391  1.6923  3.6084   Coefficients:                 Estimate Std. Error t value Pr(>|t|)     (Intercept)      4.96038    0.43424  11.423  < 2e-16 *** SexMale          0.01070    0.18257   0.059 0.953267     SLC_GenotypeHET  0.66316    0.20026   3.311 0.000962 *** SLC_GenotypeMUT -1.41786    0.24774  -5.723 1.38e-08 *** Weight           0.20494    0.01197  17.125  < 2e-16 *** --- Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1  Residual standard error: 2.324 on 995 degrees of freedom Multiple R-squared:  0.394,	Adjusted R-squared:  0.3916  F-statistic: 161.8 on 4 and 995 DF,  p-value: < 2.2e-16  

## Fastest_Tturn 

 Call: lm(formula = formula_lm_full, data = data_long)  Residuals:     Min      1Q  Median      3Q     Max  -5.5524 -2.6018 -0.1138  2.7013  6.3427   Coefficients:                 Estimate Std. Error t value Pr(>|t|)     (Intercept)     -2.46578    0.39832  -6.190 7.36e-10 *** SexMale         -0.91739    0.18702  -4.905 1.01e-06 *** SLC_GenotypeHET -0.16654    0.18693  -0.891  0.37311     SLC_GenotypeMUT -0.63426    0.21461  -2.955  0.00316 **  Weight           0.25288    0.01176  21.494  < 2e-16 *** ASO_TgPositive   0.86656    0.14784   5.861 5.41e-09 *** --- Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1  Residual standard error: 3.119 on 1869 degrees of freedom Multiple R-squared:  0.2535,	Adjusted R-squared:  0.2515  F-statistic: 126.9 on 5 and 1869 DF,  p-value: < 2.2e-16  

## Fastest_Tturn  (Positive ASO_Tg)

 Call: lm(formula = formula_lm_pos, data = data_long_pos)  Residuals:    Min     1Q Median     3Q    Max  -5.286 -2.519 -1.023  2.244  6.005   Coefficients:                 Estimate Std. Error t value Pr(>|t|)     (Intercept)     -2.54486    0.53249  -4.779 2.07e-06 *** SexMale         -1.65416    0.27967  -5.915 4.78e-09 *** SLC_GenotypeHET  0.43240    0.25673   1.684   0.0925 .   SLC_GenotypeMUT -0.51063    0.27312  -1.870   0.0619 .   Weight           0.28067    0.01718  16.338  < 2e-16 *** --- Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1  Residual standard error: 2.983 on 870 degrees of freedom Multiple R-squared:  0.2919,	Adjusted R-squared:  0.2887  F-statistic: 89.67 on 4 and 870 DF,  p-value: < 2.2e-16  

## Fastest_Tturn  (Negative ASO_Tg)

 Call: lm(formula = formula_lm_neg, data = data_long_neg)  Residuals:     Min      1Q  Median      3Q     Max  -5.6632 -2.3532 -0.4133  3.0503  6.0849   Coefficients:                 Estimate Std. Error t value Pr(>|t|)     (Intercept)     -1.34049    0.59826  -2.241  0.02527 *   SexMale         -0.31605    0.25153  -1.257  0.20923     SLC_GenotypeHET -0.85765    0.27591  -3.108  0.00193 **  SLC_GenotypeMUT -0.91319    0.34131  -2.676  0.00758 **  Weight           0.22559    0.01649  13.682  < 2e-16 *** --- Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1  Residual standard error: 3.202 on 995 degrees of freedom Multiple R-squared:  0.2196,	Adjusted R-squared:  0.2165  F-statistic:    70 on 4 and 995 DF,  p-value: < 2.2e-16  

## Fastest_Ttotal 

 Call: lm(formula = formula_lm_full, data = data_long)  Residuals:     Min      1Q  Median      3Q     Max  -7.3627 -3.5651 -0.2339  3.4682  9.0537   Coefficients:                 Estimate Std. Error t value Pr(>|t|)     (Intercept)     -2.26991    0.53460  -4.246 2.28e-05 *** SexMale         -1.36952    0.25100  -5.456 5.51e-08 *** SLC_GenotypeHET -0.95978    0.25089  -3.825 0.000135 *** SLC_GenotypeMUT -2.00081    0.28804  -6.946 5.16e-12 *** Weight           0.37002    0.01579  23.434  < 2e-16 *** ASO_TgPositive   1.14670    0.19842   5.779 8.78e-09 *** --- Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1  Residual standard error: 4.186 on 1869 degrees of freedom Multiple R-squared:  0.2972,	Adjusted R-squared:  0.2954  F-statistic: 158.1 on 5 and 1869 DF,  p-value: < 2.2e-16  

## Fastest_Ttotal  (Positive ASO_Tg)

 Call: lm(formula = formula_lm_pos, data = data_long_pos)  Residuals:     Min      1Q  Median      3Q     Max  -7.2766 -3.9142  0.0782  2.7816  7.8101   Coefficients:                 Estimate Std. Error t value Pr(>|t|)     (Intercept)     -1.38819    0.76459  -1.816  0.06978 .   SexMale         -1.45101    0.40158  -3.613  0.00032 *** SLC_GenotypeHET -0.86680    0.36863  -2.351  0.01893 *   SLC_GenotypeMUT -2.20116    0.39217  -5.613 2.68e-08 *** Weight           0.37931    0.02467  15.377  < 2e-16 *** --- Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1  Residual standard error: 4.283 on 870 degrees of freedom Multiple R-squared:  0.2931,	Adjusted R-squared:  0.2899  F-statistic: 90.19 on 4 and 870 DF,  p-value: < 2.2e-16  

## Fastest_Ttotal  (Negative ASO_Tg)

 Call: lm(formula = formula_lm_neg, data = data_long_neg)  Residuals:    Min     1Q Median     3Q    Max  -6.907 -3.151 -0.839  3.872  9.045   Coefficients:                 Estimate Std. Error t value Pr(>|t|)     (Intercept)     -2.01407    0.76682  -2.627  0.00876 **  SexMale         -1.29901    0.32240  -4.029 6.02e-05 *** SLC_GenotypeHET -1.04449    0.35364  -2.954  0.00322 **  SLC_GenotypeMUT -1.77084    0.43747  -4.048 5.57e-05 *** Weight           0.36183    0.02113  17.122  < 2e-16 *** --- Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1  Residual standard error: 4.104 on 995 degrees of freedom Multiple R-squared:  0.2835,	Adjusted R-squared:  0.2806  F-statistic: 98.41 on 4 and 995 DF,  p-value: < 2.2e-16  

## Average_Tturn 

## Average_Tturn 

|                |   Estimate| Std. Error|    t value| Pr(>&#124;t&#124;)| |:---------------|----------:|----------:|----------:|------------------:| |(Intercept)     |  4.2828255|  0.2122166| 20.1813913|          0.0000000| |SexMale         | -0.0493061|  0.0996387| -0.4948487|          0.6207651| |SLC_GenotypeHET |  0.2953973|  0.0995938|  2.9660202|          0.0030551| |SLC_GenotypeMUT | -0.6432996|  0.1143411| -5.6261458|          0.0000000| |Weight          |  0.1089443|  0.0062680| 17.3811425|          0.0000000| |ASO_TgPositive  |  0.7517196|  0.0787652|  9.5438001|          0.0000000| 

## Average_Tturn  (Positive ASO_Tg)

|                |   Estimate| Std. Error|   t value| Pr(>&#124;t&#124;)| |:---------------|----------:|----------:|---------:|------------------:| |(Intercept)     |  5.4962693|  0.2594581| 21.183647|          0.0000000| |SexMale         | -0.1721933|  0.1362715| -1.263605|          0.2067104| |SLC_GenotypeHET |  0.4339454|  0.1250930|  3.468982|          0.0005481| |SLC_GenotypeMUT | -0.3156528|  0.1330807| -2.371891|          0.0179140| |Weight          |  0.0925029|  0.0083705| 11.051016|          0.0000000| 

## Average_Tturn  (Negative ASO_Tg)

|                |   Estimate| Std. Error|    t value| Pr(>&#124;t&#124;)| |:---------------|----------:|----------:|----------:|------------------:| |(Intercept)     |  3.8729259|  0.3369709| 11.4933528|          0.0000000| |SexMale         |  0.0704173|  0.1416754|  0.4970329|          0.6192757| |SLC_GenotypeHET |  0.1835252|  0.1554029|  1.1809643|          0.2378991| |SLC_GenotypeMUT | -0.9895782|  0.1922412| -5.1475880|          0.0000003| |Weight          |  0.1228632|  0.0092865| 13.2303576|          0.0000000| 

## Average_Ttotal 

|                |   Estimate| Std. Error|    t value| Pr(>&#124;t&#124;)| |:---------------|----------:|----------:|----------:|------------------:| |(Intercept)     |  6.2621651|  0.2869408| 21.8238895|          0.0000000| |SexMale         | -0.1242840|  0.1347228| -0.9225163|          0.3563784| |SLC_GenotypeHET |  0.4100308|  0.1346622|  3.0448853|          0.0023602| |SLC_GenotypeMUT | -1.3635444|  0.1546021| -8.8197026|          0.0000000| |Weight          |  0.1739175|  0.0084750| 20.5212613|          0.0000000| |ASO_TgPositive  |  1.0354212|  0.1064995|  9.7223088|          0.0000000| 

## Average_Ttotal  (Positive ASO_Tg)

|                |   Estimate| Std. Error|   t value| Pr(>&#124;t&#124;)| |:---------------|----------:|----------:|---------:|------------------:| |(Intercept)     |  8.3419181|  0.3756650| 22.205734|          0.0000000| |SexMale         | -0.2970237|  0.1973052| -1.505402|          0.1325836| |SLC_GenotypeHET |  0.2567197|  0.1811200|  1.417401|          0.1567237| |SLC_GenotypeMUT | -1.1949521|  0.1926852| -6.201575|          0.0000000| |Weight          |  0.1463646|  0.0121195| 12.076736|          0.0000000| 

## Average_Ttotal  (Negative ASO_Tg)

|                |   Estimate| Std. Error|    t value| Pr(>&#124;t&#124;)| |:---------------|----------:|----------:|----------:|------------------:| |(Intercept)     |  4.9603843|  0.4342450| 11.4230086|          0.0000000| |SexMale         |  0.0107023|  0.1825731|  0.0586195|          0.9532670| |SLC_GenotypeHET |  0.6631594|  0.2002633|  3.3114377|          0.0009616| |SLC_GenotypeMUT | -1.4178584|  0.2477358| -5.7232685|          0.0000000| |Weight          |  0.2049365|  0.0119672| 17.1248513|          0.0000000| 

## Fastest_Tturn 

|                |   Estimate| Std. Error|    t value| Pr(>&#124;t&#124;)| |:---------------|----------:|----------:|----------:|------------------:| |(Intercept)     | -2.4657758|  0.3983229| -6.1903936|          0.0000000| |SexMale         | -0.9173882|  0.1870183| -4.9053403|          0.0000010| |SLC_GenotypeHET | -0.1665368|  0.1869341| -0.8908849|          0.3731056| |SLC_GenotypeMUT | -0.6342560|  0.2146141| -2.9553319|          0.0031624| |Weight          |  0.2528760|  0.0117647| 21.4944037|          0.0000000| |ASO_TgPositive  |  0.8665561|  0.1478395|  5.8614636|          0.0000000| 

## Fastest_Tturn  (Positive ASO_Tg)

|                |   Estimate| Std. Error|   t value| Pr(>&#124;t&#124;)| |:---------------|----------:|----------:|---------:|------------------:| |(Intercept)     | -2.5448646|  0.5324909| -4.779171|          0.0000021| |SexMale         | -1.6541612|  0.2796726| -5.914635|          0.0000000| |SLC_GenotypeHET |  0.4324019|  0.2567307|  1.684262|          0.0924896| |SLC_GenotypeMUT | -0.5106305|  0.2731240| -1.869593|          0.0618761| |Weight          |  0.2806672|  0.0171790| 16.337810|          0.0000000| 

## Fastest_Tturn  (Negative ASO_Tg)

|                |   Estimate| Std. Error|   t value| Pr(>&#124;t&#124;)| |:---------------|----------:|----------:|---------:|------------------:| |(Intercept)     | -1.3404879|  0.5982643| -2.240628|          0.0252702| |SexMale         | -0.3160522|  0.2515330| -1.256504|          0.2092282| |SLC_GenotypeHET | -0.8576489|  0.2759050| -3.108493|          0.0019339| |SLC_GenotypeMUT | -0.9131916|  0.3413084| -2.675562|          0.0075829| |Weight          |  0.2255875|  0.0164873| 13.682462|          0.0000000| 

## Fastest_Ttotal 

|                |   Estimate| Std. Error|   t value| Pr(>&#124;t&#124;)| |:---------------|----------:|----------:|---------:|------------------:| |(Intercept)     | -2.2699119|  0.5346020| -4.245985|          0.0000228| |SexMale         | -1.3695178|  0.2510032| -5.456177|          0.0000001| |SLC_GenotypeHET | -0.9597755|  0.2508902| -3.825480|          0.0001348| |SLC_GenotypeMUT | -2.0008108|  0.2880405| -6.946283|          0.0000000| |Weight          |  0.3700188|  0.0157898| 23.433993|          0.0000000| |ASO_TgPositive  |  1.1466973|  0.1984202|  5.779137|          0.0000000| 

## Fastest_Ttotal  (Positive ASO_Tg)

|                |   Estimate| Std. Error|   t value| Pr(>&#124;t&#124;)| |:---------------|----------:|----------:|---------:|------------------:| |(Intercept)     | -1.3881934|  0.7645916| -1.815601|          0.0697757| |SexMale         | -1.4510118|  0.4015756| -3.613297|          0.0003197| |SLC_GenotypeHET | -0.8668025|  0.3686339| -2.351392|          0.0189255| |SLC_GenotypeMUT | -2.2011605|  0.3921725| -5.612735|          0.0000000| |Weight          |  0.3793133|  0.0246669| 15.377400|          0.0000000| 

## Fastest_Ttotal  (Negative ASO_Tg)

|                |   Estimate| Std. Error|   t value| Pr(>&#124;t&#124;)| |:---------------|----------:|----------:|---------:|------------------:| |(Intercept)     | -2.0140732|  0.7668151| -2.626544|          0.0087582| |SexMale         | -1.2990102|  0.3223982| -4.029210|          0.0000602| |SLC_GenotypeHET | -1.0444871|  0.3536366| -2.953561|          0.0032152| |SLC_GenotypeMUT | -1.7708447|  0.4374662| -4.047957|          0.0000557| |Weight          |  0.3618343|  0.0211324| 17.122274|          0.0000000| 

