clear;
clc;

I = [37.3930 70.5710 23.3550;49.6670 66.1870 30.2680;35.6150 51.4370 42.5790];

aver = sum(sum(I))/9;
summ = abs(I(1,1)-aver) + abs(I(1,3)-aver) + abs(I(3,1)-aver) + abs(I(3,3)-aver);
Si = 0.1968;

x = zeros(3);
s = zeros(4);

for i=1:2
    for j=1:2
        if j==2
            j = j+1;
        end
        if i==2
            i = i+1;
        end
        x(i,j) = Si*(abs(I(i,j)-aver)/summ);
    end
end