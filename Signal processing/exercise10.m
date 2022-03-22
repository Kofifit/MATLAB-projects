s = [1 2 3 1 4 5 2 3 1 1];
r1 = [0 1 0 1 0 1 0 1 1 0];
r2 = [2 4 6 2 8 10 4 6 2 2];

r2=r2+randn(1,length(r2));   

linearI = mean(r2)/mean(s);
linearII = mean(r2/s);