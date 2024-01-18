clc;
clear all;
datadir='E:\ucas\work\Weatherdealed\SA\LC\SSD\18\';%%%%%load in sunshine hours
hour=dir([datadir,'*.txt']);
k=length(hour);
    for i=1:k
        filename{i}=hour(i).name;
        hour_year{i}=load([datadir,filename{i}]);
        hours{i}=hour_year{i}*0.1;
    end

    

datadir='E:\ucas\work\Weatherdealed\SA\LC\LATITUDE\18\';%%%%%load in Latitude
Latitude=dir([datadir,'*.txt']);
k=length(Latitude);
    for i=1:k
        filename{i}=Latitude(i).name;
        Latitude_year{i}=load([datadir,filename{i}]);
    end


for t=1:length(Latitude_year)
    temp1=num2str(Latitude_year{1,t});
    for m=1:length(temp1)   
        a=str2num(temp1(m,1:2));
        b=str2num(temp1(m,3:end));
        latitude{1,t}(m,1)=a+b/60;
        latitude{1,t}(m,1)=deg2rad(latitude{1,t}(m,1));
        
    end
end
    


    for i=1:k %%%%%%%%%%Caculate Rs
        for J=1:length(hours{1,i})

            delta{1,i}(J,1)=0.408*sin(2*pi/365*J-1.39);    
            dr{1,i}(J,1)=1+0.033*cos(2*pi/365*J);   
            Ws{1,i}(J,1)=acos(-tan(latitude{1,i}(J,1))*tan(delta{1,i}(J,1)));  
            N{1,i}(J,1)=24/pi*Ws{1,i}(J,1);   
            Ra{1,i}(J,1)=37.6*dr{1,i}(J,1)*(Ws{1,i}(J,1)*sin(latitude{1,i}(J,1))*sin(delta{1,i}(J,1))+cos(latitude{1,i}(J,1))*cos(delta{1,i}(J,1))*sin(Ws{1,i}(J,1))); 
            Rs{1,i}(J,1)=(0.25+0.5*hours{1,i}(J,1)/N{1,i}(J,1))*Ra{1,i}(J,1); 

        end
    end
    
    
%%%%%%%%%%%%cell to mat 
R0=0;
for i=1:k
n=length(Rs{1,i})
for j=1:n
    Rs_double(i,j)=Rs{1,i}(j,1)-R0;
end
end

Rs_double=Rs_double';


yeardate=[1990;1991;1992;1993;1994;1995;1996;1997;1998;1999;2000;2001;2002;2003;2004;2005;2006;2007;2008;2009;2010;2011;2012;2013;2014;2015];


for i=1:2
    n=length(Rs{1,i})
    for j=1:n
    year_date=num2str(yeardate(i));
    fid=fopen(['E:\ucas\work\Weatherdealed\SA\LC\RAD\18\',year_date,'.txt'],'wt');
    fprintf(fid,'%.3g\n',Rs_double(1:n,i));
    fclose(fid);
    end
end
    
