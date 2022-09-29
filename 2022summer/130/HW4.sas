*1a;
data beach;
set "/home/u61723449/sasuser.v94/beach2019.sas7bdat";
run;

proc print data= beach;
run;

*1b;
proc gchart data=beach;
vbar beach;
run;
quit;

*1c;
proc gchart data=beach;
pie beach/ explode="Folly Beach";
*format beach comma8.;			
run;
quit;

*1d;
proc gplot data=beach;
plot items*hours/vaxis=0 to 1000 by 100 regeqn;
symbol v=dot c=green i=rl ;
where hours<=25 ;
label items='Items Cleaned Up'
	  	hours=	"Hours of Cleanup";
run;
quit;

*2a;
data airforce 
	 army(keep=code city state) 
	 marines (keep=city state country airport awards)
	 naval(keep=city airport);
set "/home/u61723449/sasuser.v94/military2.sas7bdat";
if type = 'Army' then output army;
else if type = "Air Force" then output airforce;
else if type = "Marines" then output marines;
else if type= "Naval" then output naval;
run;

*2b;
*The data set WORK.AIRFORCE has 59 observations and 7 variables.
 NOTE: The data set WORK.ARMY has 40 observations and 7 variables.
 NOTE: The data set WORK.MARINES has 0 observations and 7 variables.
 NOTE: The data set WORK.NAVAL has 27 observations and 7 variables.
 There were 130 observations read from the data set military2
;


*2c;
data m1;
set "/home/u61723449/sasuser.v94/military2.sas7bdat";
AwardsRT =  sum(AwardsRT,Awards);
retain;
run;
proc print data=m1;
run;

data m2;
set "/home/u61723449/sasuser.v94/military2.sas7bdat";
AwardsRT+Awards;
retain;
run;
proc print data=m2;
run;

*2d;
data pre_m3;
set "/home/u61723449/sasuser.v94/military2.sas7bdat";
proc sort data=pre_m3 out=pre_m3_2; 
by type;
run;
data m3;
set pre_m3_2;
by type;
if First.type then TotalAwards=0; 
TotalAwards+awards;
if Last.type;
keep TotalAwards type;
run;




*3a;
data car;
set "/home/u61723449/sasuser.v94/cars.sas7bdat";
run;
proc format;
value hrspowr 
      low-150="Less than 150 hp"
      150-300="Between 150 and 300 hp"
      300-high="More than 300 hp";
run;      
ods listing file="/home/u61723449/sasuser.v94/cars1.lst";
proc report data=car;
column Type horsepower MSRP;
define Type / width=12 "Vehicle Type";
define horsepower / width=25 format= hrspowr.;
define MSRP / width=40 "Manufacturer’s Suggested Retail Price";
format MSRP dollar12.0;
title 'Vehicle Prices: List Report';
options pageno=5;
run;
ods listing close;


*3b;
ods listing file="/home/u61723449/sasuser.v94/cars2.lst";
proc report data=car headline headskip;
column Type horsepower MSRP;
title 'Vehicle Prices: Summary Report';
define MSRP / format=dollar12.;
define type/group;
define horsepower/ group;
break after TYPE / summarize ol dul;
rbreak after/summarize dul;
run; 
ods listing close;


















