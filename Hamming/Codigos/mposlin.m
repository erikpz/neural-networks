function a2 = mposlin(w,a)
    n = w*a;
    [f,~] = size(n);
    for j = 1:f
        if n(j,1) < 0
            n(j,1) = 0;
        end    
    end  
    a2 = n;
end