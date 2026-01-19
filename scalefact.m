m=[21.0500 54.8100 27.0250 70.4350 23.1130;
25.6600 42.5830 41.4370 27.7380 43.8720;
47.9390 39.4040 37.3930 70.5710 23.3550;
51.1790 63.6850 49.6670 66.1870 30.2680;
55.0800 47.4850 35.6150 51.4370 42.5790];
a = 1;
s = zeros(4);
while(a<5)
    b = 1;
    while(b<5)
        I = zeros(3);
        p = 1;
        for i = a:a+2
            q = 1;
            for j = b:b+2
                I(p,q) = m(i,j);
                q = q+1;
            end
            p = p+1;
        end
        aver = sum(sum(I))/9;
        summ = abs(I(1,1)-aver) + abs(I(1,3)-aver) + abs(I(3,1)-aver) + abs(I(3,3)-aver);
        Si = 0.1968;
        x = zeros(3);
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
        p = 1;
        for i = a:a+1
            q = 1;
            for j = b:b+1
                s(i,j) = x(p,q);
                q = q+2;
            end
            p = p+2;
        end
    b = b+2;
    end
a = a+2;
end