load matriz_A0064_AF.mat

for k=1:12
   for n = 1:12
        matriz_mi_AF2(k,n) = mi_cont_cont(val(k,:),val(n,:),1);
        matriz_TE1_AF2(k,n) = transferEntropyPartition(val(k,:),val(n,:),1,1);
        matriz_TE2_AF2(k,n) = transferEntropyPartition(val(n,:),val(k,:),1,1);
        
    end
end

diferencia_AF2 = matriz_TE1_AF2-matriz_TE2_AF2;