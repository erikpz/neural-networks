clear
clc
tipo = input("Ingresa tipo compuerta (AND/OR/NOT): ", 's');
if tipo == "not"
    n = 1;
    tabv = tabla_verdad(tipo,n);
else
    n = input("Ingresa dimension compuerta: ");
    tabv = tabla_verdad(tipo,n);
end
epocas = input("Ingresa numero de epocas deseado (epoach>50): ");
apren = 0;   
ques = 1;
while apren == 0 && ques == 1
    for e = 1:epocas
        w = zeros(1,n);
        teth = 0;
        for k = 1:n
            w(1,k) = randi([-10,10],1,1);
            if k == n
                teth = randi([-10,10],1,1);
            end    
        end

        for j = 1 : 2^n
            m = 0;
            for i = 1 : n
                m = m + (tabv(j,i)*w(1,i));
            end 
            if m > teth
                a = 1;
            else
                a = 0;
            end
            t = tabv(j,n+1);
            if a == t
                apren = 1;
                continue
            else
                apren = 0;
                break;
            end    
        end

        if apren == 0
            continue
        else
            break
        end    
    end       
    if apren == 0
        w
        teth
        disp("Aprendizaje NO exitoso");
        ques = input("Quieres repetir? Si=1, No=0: ");
    else
        w
        teth
        disp("Aprendizaje EXITOSO");
        if tipo == "not"
            archivo = fopen("not.txt", "w");
            fprintf(archivo,"---APRENDIZAJE EXITOSO---\n");
            fprintf(archivo,"Matriz W de pesos sinapticos para la compuerta NOT de %d entradas: \n\n",n);
            for h = 1:n 
                fprintf(archivo," w%d ",h);
            end
            fprintf(archivo,"\n");
            for i = 1:n 
                fprintf(archivo,"  %d  ",w(1,i));
            end
            fprintf(archivo,"\n\nTHETA = %d\n", teth);
            fclose(archivo);
        elseif tipo == "and"
            archivo = fopen("and.txt", "w");
            fprintf(archivo,"---APRENDIZAJE EXITOSO---\n");
            fprintf(archivo,"Matriz W de pesos sinapticos para la compuerta AND de %d entradas: \n\n",n);
            for h = 1:n 
                fprintf(archivo," w%d ",h);
            end
            fprintf(archivo,"\n");
            for i = 1:n 
                fprintf(archivo,"  %d  ",w(1,i));
            end
            fprintf(archivo,"\n\nTHETA = %d\n", teth);
            fclose(archivo);
        elseif tipo == "or"    
            archivo = fopen("or.txt", "w");
            fprintf(archivo,"---APRENDIZAJE EXITOSO---\n");
            fprintf(archivo,"Matriz W de pesos sinapticos para la compuerta OR de %d entradas: \n\n",n);
            for h = 1:n 
                fprintf(archivo," w%d ",h);
            end
            fprintf(archivo,"\n");
            for i = 1:n 
                fprintf(archivo,"  %d  ",w(1,i));
            end
            fprintf(archivo,"\n\nTHETA = %d\n", teth);
            fclose(archivo);
        end    
    end    
end    