clc;
clear;

archivo = input("Que archivo quieres procesar, en cuanto a clases?(3,5,8): ");

if archivo == 3
    w_file = 'w1.txt';
    p_file = 'p_new.txt';
    ncar = 4;
elseif archivo == 5    
    w_file = 'w15.txt';
    p_file = 'p_new5.txt';
    ncar = 6;
elseif archivo == 8  
    w_file = 'w18.txt';
    p_file = 'p_new8.txt';
    ncar = 8;
end 
file_w1 = fopen(w_file,'r');
w1 = fscanf(file_w1,'%d', [ncar Inf]);
fclose(file_w1);
w1 = w1';

file_p = fopen(p_file,'r');
p_new = fscanf(file_p,'%d');
fclose(file_p);

[nvec,ncar] = size(w1);
bias = zeros(nvec,1);
for i = 1:nvec 
    bias(i,1) = ncar;
end

a1 = mpurelin(w1,p_new,bias);

s = nvec;
epsilon = 1/(s-1);
nrand = 0 + (epsilon - 0)*rand(1,1);
%nrand = 0.7;

w2 = zeros(nvec,nvec);
for q = 1:nvec
    for p = 1:nvec
        if q == p
            w2(q,p) = 1;
        else
            w2(q,p) = nrand*(-1);
        end
    end
end    

salida = fopen('salidahamming.txt','w');
iter = 1;
cont = 0;
a2 = mposlin(w2,a1);
for z = 1:nvec
    fprintf(salida,'%f\n',a2(z,1));
end

while true
    aux = 0;
    for i = 1:nvec
        if a2(i,1) ~= 0
            aux = aux+1;
        end
    end
    if aux == 1
        cont = cont+1;
        if cont == 2
            break
        end    
    else
        cont = 0;
    end
    a2 = mposlin(w2,a2);
    iter = iter + 1;
    for z = 1:nvec
        fprintf(salida,'%f\n',a2(z,1));
    end    
end 
fclose(salida);
nuevo = fopen ('SalidaHamming.txt', 'r');
while ~feof (nuevo)
    [r, count] = fscanf (nuevo, '%f\n', [nvec iter]);
end
for i = 1:nvec
    hold on;
    plot (r (i,:), 'o-');
    grid, ylabel('Valor'), xlabel('Iteración');
end
fclose(nuevo);
a2
for h = 1:nvec
    if a2(h,1) ~= 0
        clase = h;
    end    
end    
fprintf("La red convergió en la iteracion %d en la clase %d. ",iter,clase);




