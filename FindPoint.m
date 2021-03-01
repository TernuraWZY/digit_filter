function  index = FindPoint(xy0,xm,ym)
% xy0为多行2列的矩阵，xy为包含2个元素的向量
% 假设在一个点周围随机分布着一些点且坐标都是已知的，如何快速定位它附近的四个点？
% 这里，“附近”的涵义是以该点为原点，将平面划分为四个象限，分别从这四个象限中
% 找一个与该点距离最近的点出来。
x = xy0(:,1) - xm;%xm and ym is single data however xy0 is arry
y = xy0(:,2) - ym;
xysize=size(xy0,1);%the num of row in xy0
index = zeros(1,4);
j=1;

for i=1:xysize
    if(x(i)>0 && y(i)>0)
        xPoint = [];
        x1(j) = x(i);
        y1(j) = y(i);
        distance(j,:) = x1(j).^2 + y1(j).^2;%row j in all matrix
        xPoint = x1(1,find(distance == min(distance)));%1 represent column 1, find return the num if row
        yPoint = y1(1,find(distance == min(distance)));
         a=find(x == xPoint);%return the pair of coordinate
         b=find(y == yPoint);
         index(1,1) = intersect(a,b);
        j=j+1;
    end;
end;

j=1;
for i=1:xysize
    if(x(i)<0 && y(i)>0)
        xPoint2 = [];
        x2(j) = x(i);
        y2(j) = y(i);
        distance1(j,:) = x2(j).^2 + y2(j).^2;
        xPoint2 = x2(1,find(distance1 == min(distance1)));
        yPoint2 = y2(1,find(distance1 == min(distance1)));
         a2=find(x == xPoint2);
         b2=find(y == yPoint2);
         index(1,2) = intersect(a2,b2);
        j=j+1;
    end;
end;

j=1;
for i=1:xysize
    if(x(i)<0 && y(i)<0)
        xPoint3 = [];
        x3(j) = x(i);
        y3(j) = y(i);
        distance2(j,:) = x3(j).^2 + y3(j).^2;
        xPoint3 = x3(1,find(distance2 == min(distance2)));
        yPoint3 = y3(1,find(distance2 == min(distance2)));
         a3=find(x == xPoint3);
         b3=find(y == yPoint3);
         index(1,3) = intersect(a3,b3);
        j=j+1;
    end;
end;

j=1;
for i=1:xysize
    if(x(i)>0 && y(i)<0)
        xPoint4 = [];
        x4(j) = x(i);
        y4(j) = y(i);
        distance3(j,:) = x4(j).^2 + y4(j).^2;
        xPoint4 = x4(1,find(distance3 == min(distance3)));
         yPoint4 = y4(1,find(distance3 == min(distance3)));
         a4=find(x == xPoint4);
         b4=find(y == yPoint4);
         index(1,4) = intersect(a4,b4);
        j=j+1;
    end;
end;







