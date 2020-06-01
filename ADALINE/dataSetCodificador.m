function data = dataSetCodificador(tamano)
    k = 2^tamano;
    res = zeros(k,1);
    mat = zeros(k,tamano);
    aux = k/2;
    cont = 1;
    band = 0;
    for i = 1:tamano
        for j = 1:k
            res(j,1) = j-1;
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
        data = [mat res];
end