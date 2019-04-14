Create useful column names from tabulate output                                                                       
                                                                                                                      
  Unlike 'proc corresp', tabulate output dataset does not honor ods listing layout.                                   
                                                                                                                      
     Method                                                                                                           
                                                                                                                      
         1. Use the fact that tabultate will not display a blank row or heading                                       
            to create a retangular list output                                                                        
         2. Send the the listing to excel with ods excel                                                              
         3. Convert the excel sheet to a SAS dataset                                                                  
                                                                                                                      
                                                                                                                      
https://communities.sas.com/t5/SAS-Programming/name-of-columns-in-output-data-set-of-proc-tabulate/m-p/550870         
                                                                                                                      
*_                   _                                                                                                
(_)_ __  _ __  _   _| |_                                                                                              
| | '_ \| '_ \| | | | __|                                                                                             
| | | | | |_) | |_| | |_                                                                                              
|_|_| |_| .__/ \__,_|\__|                                                                                             
        |_|                                                                                                           
;                                                                                                                     
                                                                                                                      
proc tabulate data = sashelp.cars  out=bbb;                                                                           
class origin;                                                                                                         
var msrp;                                                                                                             
table origin,                                                                                                         
        msrp*mean msrp*max  msrp*min ;                                                                                
run;                                                                                                                  
                                                                                                                      
                                                                                                                      
---------------------------------------------------------------------------------                                     
|                                        |    Mean    |    Min     |    Max     |                                     
|----------------------------------------+------------+------------+------------|                                     
|Asia                                    |    24741.32|    10280.00|    89765.00|                                     
|----------------------------------------+------------+------------+------------|                                     
|Europe                                  |    48349.80|    16999.00|   192465.00|                                     
|----------------------------------------+------------+------------+------------|                                     
|USA                                     |    28377.44|    10995.00|    81795.00|                                     
---------------------------------------------------------------------------------                                     
                                                                                                                      
*            _               _                                                                                        
  ___  _   _| |_ _ __  _   _| |_                                                                                      
 / _ \| | | | __| '_ \| | | | __|                                                                                     
| (_) | |_| | |_| |_) | |_| | |_                                                                                      
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                     
                |_|                                                                                                   
;                                                                                                                     
                                                                                                                      
WORK.WANT total obs=3                                                                                                 
                                                                                                                      
Obs    NONAME      MEAN       MIN       MAX                                                                           
                                                                                                                      
 1     Asia      24741.32    10280     89765                                                                          
 2     Europe    48349.80    16999    192465                                                                          
 3     USA       28377.44    10995     81795                                                                          
                                                                                                                      
                                                                                                                      
*                                                                                                                     
 _ __  _ __ ___   ___ ___  ___ ___                                                                                    
| '_ \| '__/ _ \ / __/ _ \/ __/ __|                                                                                   
| |_) | | | (_) | (_|  __/\__ \__ \                                                                                   
| .__/|_|  \___/ \___\___||___/___/                                                                                   
|_|                                                                                                                   
;                                                                                                                     
                                                                                                                      
                                                                                                                      
* I made some slight chages to your tabulate to create the output below;                                              
* Tabulate does not print blank headers;                                                                              
                                                                                                                      
                                                                                                                      
ods excel file="d:/xls/colnames.xlsx"                                                                                 
options (sheet_name="cars");                                                                                          
proc tabulate data = sashelp.cars;                                                                                    
class origin;                                                                                                         
var msrp;                                                                                                             
table origin="",                                                                                                      
        (msrp="")*(mean min max ) ;                                                                                   
run;                                                                                                                  
ods excel close;                                                                                                      
                                                                                                                      
libname xel "d:/xls/colnames.xlsx";                                                                                   
data want;                                                                                                            
  set xel.'cars$'n;                                                                                                   
run;quit;                                                                                                             
libname xel clear;                                                                                                    
                                                                                                                      
                                                                                                                      
Up to 40 obs WORK.WANT total obs=3                                                                                    
                                                                                                                      
Obs    NONAME      MEAN       MIN       MAX                                                                           
                                                                                                                      
 1     Asia      24741.32    10280     89765                                                                          
 2     Europe    48349.80    16999    192465                                                                          
 3     USA       28377.44    10995     81795                                                                          
                                                                                                                      
                                                                                                                      
                                                                                                                      
