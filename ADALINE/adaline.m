clear;clc;
modo = input('1)Regresor. \n2)Clasificador.\nSeleccionar modo de aprendizaje: ');
epochmax = input('Ingrese maximo de epocas: ');
Eepoch = input('Ingrese el valor del error deseado(Valor pequeno): ');
alfa = input('Ingrese el valor alfa "a"(factor de aprendizaje) en un rango-> {0<a<0.2}: ');
 
if modo == 1
    bits = input('Ingresa numero de bits del decodificador: ');
    dataset = dataSetCodificador(bits);
    
    archivodataset = fopen("dataset"+bits+"bits.txt",'w'); 
    [f,c] = size(dataset);
    for i = 1:f
        for j = 1:c
            fprintf(archivodataset,"%d ",dataset(i,j));
        end    
        fprintf(archivodataset,"\n",dataset(i,j));
    end    
    fclose(archivodataset);
    
    R = bits;
    W = -1 + (1+1).*rand(1,R);
    critepomax = true;
    veca = zeros(1,f);
    graf = zeros(1,R);
    graf2 = [0];
    for i = 1:epochmax
        %fprintf('Epoca %d--------\n', i)
        EEPOCH = 0;
        for j = 1:f
            %disp(dataset(j,1:c-1))
            p = dataset(j,1:c-1);
            a = W*p';
            t = dataset(j,c);
            e = t-a;
            W = W + 2*alfa*e*p;
            EEPOCH = EEPOCH + e;
            veca(1,j) = a;
        end
        graf = [graf;W];
        EEPOCH = EEPOCH/f;
        graf2 = [graf2 EEPOCH];
        if EEPOCH == 0
            criterio = 'crit1';
            critepomax = false;
            break
        elseif EEPOCH < Eepoch
            criterio = 'crit2';
            critepomax = false;
            break 
        end  
    end
    maxepocas = i;
    rango = (0:maxepocas);
    graf = graf';
    [fil,~] = size(graf);
    for i = 1:fil
        figure(1)
        plot(rango,graf(i,:))
        title('Evolucion de la matriz de pesos W.')
        xlabel('Iteraciones.')
        ylabel('Matriz de pesos W.')
        hold on
    end
    figure(2)
    plot(rango,graf2)
    title('Evolucion de EEPOCH.')
    xlabel('Iteraciones.')
    ylabel('EEPOCH.')
else
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    archivo = input("1)Dos clases.\n2)Cuatro clases.\n3)Compuerta XOR.\nQue archivo quieres procesar?: ");

    if archivo == 1
        data_file = 'data2clases.txt';
        target_file = 'target2clases.txt';
        dcol = 3;
        tcol = 1;
        neuronas = 1;
    elseif archivo == 2    
        data_file = 'data4clases.txt';
        target_file = 'target4clases.txt';
        dcol = 2;
        tcol = 2;
        neuronas = 2;
    elseif archivo == 3  
        data_file = 'dataxor.txt';
        target_file = 'targetxor.txt';
        dcol = 2;
        tcol = 1;
        neuronas = 1;
    end 
    file_data = fopen(data_file,'r');
    data = fscanf(file_data,'%d', [dcol Inf]);
    fclose(file_data);

    file_target = fopen(target_file,'r');
    targets = fscanf(file_target,'%d', [tcol Inf]);
    fclose(file_target);

    [fildata,coldata] = size(data);
    [filtarget,coltarget] = size(targets);
    
    W = -1 + (1+1).*rand(neuronas,fildata);
    B = -1 + (1+1).*rand(neuronas,1);
    [f,c] = size(W);

    graf = zeros(1,c*f); 
    graf2 = zeros(1,neuronas);
    graf3 = zeros(1,neuronas);
    
    for i = 1:epochmax
        EEPOCH = 0;
        vec_a = zeros(filtarget,coltarget);
        for j = 1:coldata
            p = data(:,j);
            t = targets(:,j);
            a = W*p + B;
            e = t - a;
            W = W + 2*alfa*e*p';
            B = B + 2*alfa*e;
            EEPOCH = EEPOCH + e;
            vec_a(:,j) = a;
        end    
        aux = [];
        for k = 1:f
            aux = [aux W(k,:)];
        end    
        graf = [graf;aux];
        graf2 = [graf2;B'];
        
        EEPOCH = EEPOCH/coldata;
        graf3 = [graf3;EEPOCH'];
        if EEPOCH == 0
            criterio = 'crit1';
            critepomax = false;
            break
        elseif EEPOCH < Eepoch
            criterio = 'crit2';
            critepomax = false;
            break 
        end 
    end  
    maxepocas = i;
    rango = (0:maxepocas);
    graf = graf';
    graf2 = graf2';
    graf3 = graf3';
    [fil,~] = size(graf);
    [fil2,~] = size(graf2);
    [fil3,~] = size(graf3);
    for i = 1:fil
        figure(1)
        plot(rango,graf(i,:))
        title('Evolucion de la matriz de pesos W.')
        xlabel('Iteraciones.')
        ylabel('Matriz de pesos W.')
        hold on
    end 
    for i = 1:fil2
        figure(2)
        plot(rango,graf2(i,:))
        title('Evolucion del Bias.')
        xlabel('Iteraciones.')
        ylabel('Bias.')
        hold on
    end 
    for i = 1:fil3
        figure(3)
        plot(rango,graf3(i,:))
        title('Evolucion de EEPOCH.')
        xlabel('Iteraciones.')
        ylabel('EEPOCH.')
        hold on
    end 
end
if critepomax
    disp('Criterio de finalizacion: Maximo de epocas alcanzado.');
elseif criterio == 'crit1'
    disp('Criterio de finalizacion: EEPOCH = 0.'); 
elseif criterio == 'crit2' 
    disp('Criterio de finalizacion: Eepoch > EEPOCH.');        
end    
disp('---EEPOCH---');
disp(EEPOCH);
disp('---W---');
disp(W);

[wfil,wcol] = size(W);
if modo == 2
    [bfil,bcol] = size(B);
end    

if modo == 1
    nomarchivo = "valores_finales_codificador"+bits+"bits.txt";
elseif modo == 2
    if archivo == 1
        nomarchivo = 'valores_finales_2clases.txt';
    elseif archivo == 2
        nomarchivo = 'valores_finales_4clases.txt'; 
    elseif archivo == 3
        nomarchivo = 'valores_finales_xor.txt';
    end   
end   
valores_finales_RNA = fopen(nomarchivo,'w');

fprintf(valores_finales_RNA,'---W---\n');
for i = 1:wfil
    for j = 1:wcol
        fprintf(valores_finales_RNA,'%d ',W(i,j));
    end    
    fprintf(valores_finales_RNA,'\n');    
end    
if modo ~= 1
    disp('---B---');
    disp(B);
    fprintf(valores_finales_RNA,'---B---\n');
    for i = 1:bfil
        for j = 1:bcol
            fprintf(valores_finales_RNA,'%d ',B(i,j));
        end    
        fprintf(valores_finales_RNA,'\n');    
    end
end

fclose(valores_finales_RNA);