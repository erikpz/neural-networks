clc;
clear;

archivo = input("Que archivo quieres procesar, en cuanto a numero de clases?(2,4,6): ");

if archivo == 2
    i_file = 'input_p2.txt';
    t_file = 'target2.txt';
    neuronas = ceil(log2(2));
elseif archivo == 4    
    i_file = 'input_p4.txt';
    t_file = 'target4.txt';
    neuronas = ceil(log2(4));
elseif archivo == 6  
    i_file = 'input_p6.txt';
    t_file = 'target6.txt';
    neuronas = ceil(log2(6));
end 

S = neuronas;
tamR = input("Cuantos vectores son de entrada?: ");
R = input("Cuantos valores tiene cada vector de entrada P?: ");
file_i = fopen(i_file,'r');
P = fscanf(file_i,'%d', [R tamR]);
fclose(file_i);

tamT = tamR;
file_t = fopen(t_file,'r');
T = fscanf(file_t,'%d', [S tamT]);
fclose(file_t);

[Min,~] = min(P(:));
[Max,~] = max(P(:));
    
maxepoch = input("Cuantas epocas desea?: ");

repetir = 1;

while repetir == 1
    
    W = Min +(Max-Min)*rand(S,R);
    B = Min +(Max-Min)*rand(S,1);
%     W = [3 -2;1 4;2 5];
%     B = [6;1;-15];

    % W = randi([-15,15],S,R);
    % B = randi([-15,15],S,1);

    cont = true;
    criterio = 'max';
    for i = 1:maxepoch
        for j = 1:tamR
            p = P(:,j);
            t = T(:,j);
            a = mhardlim(W*p,B);
            if a == t
                cont=true;
                e = t - a;
                if e ~= 0
                    W = W + (e*p');
                    B = B + e;
                end    
            else
                cont = false;
                break;
            end   
        end
        if cont == true
            criterio = 'clas';
            break
        else
            cont = false;
        end    
    end    

    salida = fopen('valores_finales_wyb.txt','w');
    fprintf(salida,'Matriz de pesos W:\n');
    for i = 1:S
        for j = 1:R
            fprintf(salida,'%f ',W(i,j));
        end    
        fprintf(salida,'\n');
    end
    fprintf(salida,'\n\nVector Bias:\n');
    for i = 1:S
        for j = 1:1
            fprintf(salida,'%f ',B(i,j));
        end    
        fprintf(salida,'\n');
    end
    fclose(salida);
    disp('Dataset de entrada(Prototipos): ');
    P
    disp('Dataset de salida(Targets): ');
    T
    disp('Matriz de pesos W: ');
    W
    disp('Vector Bias: ');
    B
    if strcmp(criterio,'max')
        disp("El criterio de finalización fue: maximo de epocas alcanzado");
    else
        disp("El criterio de finalización fue: correcta clasificacion");
    end
    repetir = input('Deseas hacer de nuevo el aprendizaje con los mismos datos? Si=1, No=0: ');
end    




