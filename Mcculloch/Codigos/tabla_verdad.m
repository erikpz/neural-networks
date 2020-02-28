function dataSet = tabla_verdad(tipoCompuerta, tamano)
    if tipoCompuerta == "and" || tipoCompuerta == "or"
        k = 2^tamano;
        mat = zeros(k,tamano);
        res = zeros(k,1);
        aux = k/2;
        cont = 1;
        band = 0;
        for i = 1:tamano
            for j = 1:k
                if cont > aux
                    cont = 1;
                    if band == 0
                        band = 1;
                    else 
                        band = 0;
                    end
                end
                cont = cont + 1;
                mat(j,i) = band;
            end
            aux = aux/2;
            cont = 1;
            band = 0;
        end
        if tipoCompuerta == "and"
            bool = 1;
            for i = 1:k
                for j = 1:tamano
                    bool = bool & mat(i,j);
                end
                res(i,1) = bool;
                bool = 1;
            end 
        elseif tipoCompuerta == "or"
            bool = 0;
            for i = 1:k
                for j = 1:tamano
                    bool = bool | mat(i,j);
                end
                res(i,1) = bool;
                bool = 1;
            end
        end 
        dataSet = [mat res];
    elseif tipoCompuerta == "not"
        dataSet = [0 1;1 0];
    end    
end