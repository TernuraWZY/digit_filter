filename = 'fuelnode'; 
J=importdata(filename); 
filename = '25Dpipe'; 
M=importdata(filename);    
Jsize=size(J.data,1);%get the number of node
Msize=size(M.data,1);%get the number of old data

%list of Mfile input
%1.nodenumber
%2.x-coordinate,       
%3.y-coordinate,
%4.z-coordinate,
%5.x-velocity
%6.uu-reynolds-stress
%7.vv-reynolds-stress
%8.ww-reynolds-stress
%9.uv-reynolds-stress
%10.vw-reynolds-stress
%11.uw-reynolds-stress
%12.turb-diss-rate    e
%13.turb-kinetic-energy    k
for i=1:Msize
     M.data(i,13)=(sqrt(M.data(i,13)))^3/M.data(i,12);
end;       % L = k^(3/2)/e  integral length scale
xy0(:,1)=M.data(:,3);%3.y-coordinate,
xy0(:,2)=M.data(:,4);%4.z-coordinate,
for i=1:Jsize%fileNode
    xm=J.data(i,2);%y
    ym=J.data(i,3);%z
    index1=FindPoint(xy0,xm,ym);
%14-17 is the coordinate of points with min distance in four quadrant
    J.data(i,14)=index1(1,1);
    J.data(i,15)=index1(1,2);
    J.data(i,16)=index1(1,3);
    J.data(i,17)=index1(1,4);
    
    if(J.data(i,14)~=0&&J.data(i,15)~=0&&J.data(i,16)~=0&&J.data(i,17)~=0)
        xa=M.data(J.data(i,14),3);
        ya=M.data(J.data(i,14),4);
        xb=M.data(J.data(i,15),3);
        yb=M.data(J.data(i,15),4);
        xc=M.data(J.data(i,16),3);
        yc=M.data(J.data(i,16),4);
        xd=M.data(J.data(i,17),3);
        yd=M.data(J.data(i,17),4);
        lba=sqrt((xa-xb)^2+(ya-yb)^2);
        lcd=sqrt((xc-xd)^2+(yc-yd)^2);
        ye=(ya-yb)/(xa-xb)*(xm-xb)+yb;
        lbe=sqrt((xm-xb)^2+(ye-yb)^2);
        temp=lbe/lba;
        for a=5:13
            J.data(i,a+13)=(M.data(J.data(i,14),a)-M.data(J.data(i,15),a))*temp+M.data(J.data(i,15),a);
        end;
        yf=(yd-yc)/(xd-xc)*(xm-xc)+yc;
        lcf=sqrt((xm-xc)^2+(yf-yc)^2);
        temp=lcf/lcd;
        for a=5:13
            J.data(i,a+26)=(M.data(J.data(i,17),a)-M.data(J.data(i,16),a))*temp+M.data(J.data(i,16),a);
        end;
        for a=5:13
            J.data(i,a)=(ym-ye)/(yf-ye)*(J.data(i,a+26)-J.data(i,a+13))+J.data(i,a+13);
        end;
    elseif(J.data(i,14)==0)
            xb=M.data(J.data(i,15),3);
            yb=M.data(J.data(i,15),4);
            xc=M.data(J.data(i,16),3);
            yc=M.data(J.data(i,16),4);
            xd=M.data(J.data(i,17),3);
            yd=M.data(J.data(i,17),4);
            lbd=sqrt((xd-xb)^2+(yd-yb)^2);
            lcd=sqrt((xc-xd)^2+(yc-yd)^2);
            ye=(yd-yb)/(xd-xb)*(xm-xb)+yb;
            lbe=sqrt((xm-xb)^2+(ye-yb)^2);
            temp=lbe/lbd;
            for a=5:13
               J.data(i,a+13)=(M.data(J.data(i,17),a)-M.data(J.data(i,15),a))*temp+M.data(J.data(i,15),a);
            end;
            yf=(yd-yc)/(xd-xc)*(xm-xc)+yc;
            lcf=sqrt((xm-xc)^2+(yf-yc)^2);
            temp=lcf/lcd;
            for a=5:13
               J.data(i,a+26)=(M.data(J.data(i,17),a)-M.data(J.data(i,16),a))*temp+M.data(J.data(i,16),a);
            end;
            for a=5:13
               J.data(i,a)=(ym-ye)/(yf-ye)*(J.data(i,a+26)-J.data(i,a+13))+J.data(i,a+13);
            end; 
    elseif(J.data(i,15)==0)
        xa=M.data(J.data(i,14),3);
        ya=M.data(J.data(i,14),4);
        xc=M.data(J.data(i,16),3);
        yc=M.data(J.data(i,16),4);
        xd=M.data(J.data(i,17),3);
        yd=M.data(J.data(i,17),4);
        lca=sqrt((xa-xc)^2+(ya-yc)^2);
        lcd=sqrt((xc-xd)^2+(yc-yd)^2);
        ye=(ya-yc)/(xa-xc)*(xm-xc)+yc;
        lce=sqrt((xm-xc)^2+(ye-yc)^2);
        temp=lce/lca;
        for a=5:13
            J.data(i,a+13)=(M.data(J.data(i,14),a)-M.data(J.data(i,16),a))*temp+M.data(J.data(i,16),a);
        end;
        yf=(yd-yc)/(xd-xc)*(xm-xc)+yc;
        lcf=sqrt((xm-xc)^2+(yf-yc)^2);
        temp=lcf/lcd;
        for a=5:13
            J.data(i,a+26)=(M.data(J.data(i,17),a)-M.data(J.data(i,16),a))*temp+M.data(J.data(i,16),a);
        end;
        for a=5:13
            J.data(i,a)=(ym-ye)/(yf-ye)*(J.data(i,a+26)-J.data(i,a+13))+J.data(i,a+13);
        end;
     elseif(J.data(i,16)==0)
         xa=M.data(J.data(i,14),3);
         ya=M.data(J.data(i,14),4);
         xb=M.data(J.data(i,15),3);
         yb=M.data(J.data(i,15),4);
         xd=M.data(J.data(i,17),3);
         yd=M.data(J.data(i,17),4);
         lba=sqrt((xa-xb)^2+(ya-yb)^2);
         lbd=sqrt((xb-xd)^2+(yb-yd)^2);
         ye=(ya-yb)/(xa-xb)*(xm-xb)+yb;
         lbe=sqrt((xm-xb)^2+(ye-yb)^2);
         temp=lbe/lba;
         for a=5:13
            J.data(i,a+13)=(M.data(J.data(i,14),a)-M.data(J.data(i,15),a))*temp+M.data(J.data(i,15),a);
         end;
         yf=(yd-yb)/(xd-xb)*(xm-xb)+yb;
         lbf=sqrt((xm-xb)^2+(yf-yb)^2);
         temp=lbf/lbd;
         for a=5:13
            J.data(i,a+26)=(M.data(J.data(i,17),a)-M.data(J.data(i,15),a))*temp+M.data(J.data(i,15),a);
         end;
         for a=5:13
            J.data(i,a)=(ym-ye)/(yf-ye)*(J.data(i,a+26)-J.data(i,a+13))+J.data(i,a+13);
         end;
    elseif(J.data(i,17)==0)
         xa=M.data(J.data(i,14),3);
         ya=M.data(J.data(i,14),4);
         xb=M.data(J.data(i,15),3);
         yb=M.data(J.data(i,15),4);
         xc=M.data(J.data(i,16),3);
         yc=M.data(J.data(i,16),4);
         lba=sqrt((xa-xb)^2+(ya-yb)^2);
         lca=sqrt((xc-xa)^2+(yc-ya)^2);
         ye=(ya-yb)/(xa-xb)*(xm-xb)+yb;
         lbe=sqrt((xm-xb)^2+(ye-yb)^2);
         temp=lbe/lba;
         for a=5:13
            J.data(i,a+13)=(M.data(J.data(i,14),a)-M.data(J.data(i,15),a))*temp+M.data(J.data(i,15),a);
         end;
         yf=(ya-yc)/(xa-xc)*(xm-xc)+yc;
         lcf=sqrt((xm-xc)^2+(yf-yc)^2);
         temp=lcf/lca;
         for a=5:13
            J.data(i,a+26)=(M.data(J.data(i,14),a)-M.data(J.data(i,16),a))*temp+M.data(J.data(i,16),a);
         end;
         for a=5:13
            J.data(i,a)=(ym-ye)/(yf-ye)*(J.data(i,a+26)-J.data(i,a+13))+J.data(i,a+13);
         end;  
    end;
end;

 ref=zeros(Jsize,3);
 R=zeros(Jsize,6);
 L=zeros(Jsize,1);
j=1;
for i=1:Jsize 
    ref(j,1)=J.data(i,5);
    ref(j,2)=0;
    ref(j,3)=0;
    R(j,1)=J.data(i,6);
    R(j,2)=J.data(i,9);
    R(j,3)=J.data(i,11);
    R(j,4)=J.data(i,7);
    R(j,5)=J.data(i,10);
    R(j,6)=J.data(i,8);
    L(j,1)=J.data(i,13);
    j=j+1;
    end; 


dlmwrite('ref',ref,'delimiter',',');
dlmwrite('R',R,'delimiter',',');
dlmwrite('L',L,'delimiter',',');
            
        