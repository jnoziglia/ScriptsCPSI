clc; 
close all;
clear;

% Descomentar esta linea y comentar la siguiente para calcular sobre todos
% los electros
% archivos = [dir('../TrainingSet1/*.mat');dir('../TrainingSet2/*.mat');dir('../TrainingSet3/*.mat')];
leads = ["I" "II" "III" "aVR" "aVL" "aVF" "V1" "V2" "V3" "V4" "V5" "V6"];
archivos = ["A0002" "A0016" "A0020" "A0029" "A0030" "A0037" "A0038" "A0041" "A0059" "A0073" "A0075" "A0089" "A0090" "A0094" "A0107" "A0125" "A0133" "A0141" "A0143" "A0149" "A0157" "A0164" "A0166" "A0170" "A0173" "A0175" "A0176" "A0177" "A0179" "A0189" "A0190" "A0192" "A0193" "A0206" "A0208" "A0210" "A0221" "A0229" "A0233" "A0254" "A0264" "A0281" "A0283" "A0285" "A0287" "A0305" "A0312" "A0315" "A0327" "A0330" "A0332" "A0335" "A0344" "A0348" "A0357" "A0365" "A0371" "A0387" "A0395" "A0419" "A0429" "A0448" "A0453" "A0476" "A0480" "A0481" "A0482" "A0497" "A0505" "A0512" "A0520" "A0526" "A0527" "A0528" "A0534" "A0550" "A0565" "A0567" "A0569" "A0576" "A0579" "A0588" "A0597" "A0614" "A0617" "A0632" "A0634" "A0636" "A0640" "A0644" "A0648" "A0653" "A0665" "A0674" "A0683" "A0690" "A0711" "A0716" "A0721" "A0727" "A0736" "A0753" "A0772" "A0774" "A0785" "A0800" "A0803" "A0805" "A0823" "A0824" "A0827" "A0838" "A0841" "A0843" "A0858" "A0864" "A0891" "A0892" "A0904" "A0911" "A0918" "A0929" "A0951" "A0952" "A0955" "A0968" "A0973" "A0983" "A0985" "A0987" "A0991" "A0998" "A1009" "A1012" "A1015" "A1024" "A1035" "A1042" "A1056" "A1077" "A1082" "A1087" "A1096" "A1097" "A1106" "A1115" "A1121" "A1122" "A1126" "A1129" "A1137" "A1141" "A1144" "A1150" "A1151" "A1166" "A1168" "A1175" "A1176" "A1189" "A1208" "A1220" "A1229" "A1234" "A1241" "A1246" "A1251" "A1257" "A1272" "A1301" "A1327" "A1337" "A1339" "A1349" "A1353" "A1376" "A1381" "A1383" "A1401" "A1419" "A1421" "A1437" "A1447" "A1456" "A1459" "A1463" "A1470" "A1480" "A1484" "A1501" "A1507" "A1508" "A1515" "A1531" "A1534" "A1536" "A1542" "A1555" "A1557" "A1558" "A1561" "A1567" "A1582" "A1599" "A1610" "A1613" "A1616" "A1627" "A1629" "A1630" "A1642" "A1649" "A1655" "A1667" "A1668" "A1672" "A1674" "A1685" "A1692" "A1695" "A1698" "A1699" "A1700" "A1702" "A1714" "A1722" "A1736" "A1766" "A1776" "A1778" "A1806" "A1808" "A1831" "A1857" "A1862" "A1864" "A1869" "A1876" "A1880" "A1891" "A1892" "A1893" "A1914" "A1921" "A1924" "A1928" "A1938" "A1943" "A1949" "A1961" "A1964" "A1971" "A1979" "A1983" "A1993" "A2012" "A2014" "A2022" "A2040" "A2043" "A2046" "A2052" "A2057" "A2060" "A2070" "A2086" "A2089" "A2110" "A2112" "A2125" "A2126" "A2127" "A2131" "A2142" "A2151" "A2154" "A2165" "A2168" "A2170" "A2197" "A2204" "A2205" "A2206" "A2219" "A2225" "A2233" "A2242" "A2246" "A2253" "A2257" "A2261" "A2262" "A2264" "A2273" "A2275" "A2285" "A2301" "A2306" "A2317" "A2337" "A2347" "A2350" "A2370" "A2371" "A2377" "A2380" "A2383" "A2398" "A2401" "A2402" "A2403" "A2419" "A2426" "A2428" "A2433" "A2441" "A2442" "A2454" "A2462" "A2469" "A2473" "A2475" "A2484" "A2493" "A2495" "A2496" "A2498" "A2501" "A2505" "A2507" "A2518" "A2538" "A2543" "A2544" "A2547" "A2549" "A2550" "A2569" "A2570" "A2571" "A2582" "A2583" "A2588" "A2591" "A2600" "A2609" "A2626" "A2660" "A2661" "A2667" "A2675" "A2685" "A2687" "A2700" "A2702" "A2722" "A2730" "A2751" "A2770" "A2773" "A2785" "A2792" "A2796" "A2805" "A2817" "A2820" "A2824" "A2841" "A2842" "A2860" "A2868" "A2891" "A2895" "A2909" "A2911" "A2919" "A2921" "A2923" "A2925" "A2944" "A2945" "A2956" "A2971" "A2976" "A2981" "A2982" "A2986" "A2988" "A2990" "A3023" "A3038" "A3044" "A3068" "A3080" "A3081" "A3085" "A3086" "A3100" "A3128" "A3129" "A3134" "A3137" "A3153" "A3155" "A3157" "A3175" "A3179" "A3186" "A3211" "A3215" "A3217" "A3218" "A3220" "A3221" "A3228" "A3238" "A3239" "A3241" "A3246" "A3250" "A3255" "A3256" "A3261" "A3265" "A3269" "A3272" "A3304" "A3307" "A3311" "A3327" "A3350" "A3351" "A3354" "A3358" "A3363" "A3377" "A3392" "A3394" "A3399" "A3410" "A3413" "A3422" "A3423" "A3424" "A3430" "A3431" "A3435" "A3442" "A3454" "A3465" "A3470" "A3485" "A3498" "A3500" "A3501" "A3503" "A3505" "A3513" "A3529" "A3548" "A3557" "A3569" "A3579" "A3582" "A3586" "A3588" "A3590" "A3600" "A3601" "A3603" "A3608" "A3613" "A3619" "A3625" "A3629" "A3633" "A3643" "A3648" "A3650" "A3651" "A3653" "A3655" "A3657" "A3663" "A3671" "A3680" "A3689" "A3690" "A3713" "A3717" "A3723" "A3732" "A3733" "A3735" "A3739" "A3745" "A3747" "A3751" "A3766" "A3769" "A3776" "A3788" "A3790" "A3791" "A3795" "A3800" "A3806" "A3814" "A3816" "A3818" "A3828" "A3829" "A3832" "A3858" "A3867" "A3869" "A3873" "A3879" "A3886" "A3893" "A3894" "A3898" "A3903" "A3912" "A3920" "A3922" "A3924" "A3925" "A3930" "A3932" "A3947" "A3971" "A3973" "A3975" "A3981" "A3984" "A3987" "A3989" "A3992" "A4007" "A4011" "A4015" "A4019" "A4022" "A4024" "A4032" "A4036" "A4065" "A4066" "A4071" "A4088" "A4093" "A4098" "A4099" "A4102" "A4113" "A4115" "A4146" "A4147" "A4154" "A4160" "A4167" "A4174" "A4176" "A4207" "A4208" "A4209" "A4213" "A4219" "A4228" "A4234" "A4235" "A4237" "A4251" "A4257" "A4262" "A4263" "A4275" "A4284" "A4286" "A4291" "A4299" "A4310" "A4317" "A4327" "A4351" "A4364" "A4366" "A4370" "A4371" "A4374" "A4378" "A4381" "A4396" "A4398" "A4399" "A4401" "A4418" "A4422" "A4429" "A4437" "A4448" "A4451" "A4456" "A4468" "A4474" "A4486" "A4503" "A4504" "A4512" "A4526" "A4532" "A4543" "A4548" "A4550" "A4563" "A4570" "A4571" "A4576" "A4596" "A4597" "A4618" "A4631" "A4644" "A4649" "A4656" "A4660" "A4662" "A4668" "A4678" "A4686" "A4687" "A4702" "A4714" "A4719" "A4737" "A4743" "A4744" "A4751" "A4754" "A4772" "A4781" "A4785" "A4790" "A4791" "A4794" "A4806" "A4808" "A4811" "A4828" "A4832" "A4853" "A4862" "A4867" "A4881" "A4882" "A4883" "A4888" "A4895" "A4910" "A4920" "A4931" "A4940" "A4944" "A4946" "A4947" "A4952" "A4961" "A4963" "A4967" "A4968" "A4973" "A4976" "A4984" "A4994" "A5004" "A5013" "A5046" "A5072" "A5077" "A5094" "A5108" "A5114" "A5125" "A5131" "A5133" "A5137" "A5148" "A5149" "A5155" "A5163" "A5168" "A5175" "A5180" "A5183" "A5194" "A5201" "A5207" "A5223" "A5229" "A5237" "A5239" "A5241" "A5244" "A5248" "A5253" "A5266" "A5268" "A5286" "A5297" "A5322" "A5373" "A5386" "A5387" "A5389" "A5405" "A5422" "A5427" "A5428" "A5429" "A5437" "A5449" "A5452" "A5465" "A5470" "A5477" "A5481" "A5482" "A5486" "A5493" "A5498" "A5499" "A5509" "A5516" "A5566" "A5572" "A5579" "A5586" "A5594" "A5600" "A5602" "A5603" "A5616" "A5620" "A5635" "A5636" "A5644" "A5667" "A5675" "A5687" "A5693" "A5694" "A5697" "A5704" "A5712" "A5713" "A5714" "A5716" "A5727" "A5732" "A5735" "A5737" "A5741" "A5763" "A5765" "A5779" "A5785" "A5802" "A5809" "A5827" "A5838" "A5859" "A5861" "A5866" "A5883" "A5891" "A5905" "A5906" "A5913" "A5916" "A5933" "A5934" "A5937" "A5940" "A5941" "A5944" "A5950" "A5955" "A5959" "A5970" "A5976" "A5984" "A5986" "A5991" "A5992" "A6012" "A6016" "A6020" "A6021" "A6026" "A6030" "A6042" "A6046" "A6064" "A6066" "A6070" "A6093" "A6098" "A6114" "A6118" "A6130" "A6136" "A6154" "A6162" "A6188" "A6195" "A6196" "A6231" "A6249" "A6252" "A6253" "A6258" "A6269" "A6274" "A6284" "A6286" "A6298" "A6304" "A6306" "A6307" "A6309" "A6314" "A6318" "A6323" "A6330" "A6331" "A6347" "A6351" "A6358" "A6363" "A6371" "A6380" "A6390" "A6415" "A6434" "A6437" "A6447" "A6464" "A6466" "A6467" "A6476" "A6478" "A6491" "A6501" "A6504" "A6506" "A6507" "A6521" "A6528" "A6535" "A6536" "A6541" "A6542" "A6549" "A6557" "A6559" "A6560" "A6565" "A6568" "A6569" "A6573" "A6580" "A6585" "A6590" "A6604" "A6606" "A6612" "A6617" "A6621" "A6623" "A6624" "A6643" "A6678" "A6681" "A6697" "A6699" "A6702" "A6709" "A6712" "A6716" "A6734" "A6735" "A6772" "A6780" "A6782" "A6789" "A6801" "A6806" "A6809" "A6821" "A6824" "A6832" "A6845" "A6846" "A6853" "A6870"];
for i=1:length(archivos)
    load(archivos(i))
    val_comp = ECG.data;
    if (size(val_comp, 2) > 5000)
        val_comp = val_comp(:,1:5000);
    end
    if (size(val_comp, 2) < 5000)
        continue;
    end
    val = zeros(12,1000);
    for j=1:12
        val(j,:) = downsample(val_comp(j,:),5);
    end
    for k=1:12
       for n = 1:12
            matriz_mi(i,k,n) = mi_cont_cont(val(k,:),val(n,:),1);
            matriz_TE1(i,k,n) = transferEntropyPartition(val(k,:),val(n,:),1,1);
            matriz_TE2(i,k,n) = transferEntropyPartition(val(n,:),val(k,:),1,1);
        end
    end
    diferencia = matriz_TE1-matriz_TE2;
    
    % Matriz Diferencias pero solo con valores 1 y -1. Visualización
    % gráfica simplificada respecto de la Matriz Diferencias.
    dif_abs = diferencia;
    dif_abs(dif_abs<0) = -1;
    dif_abs(dif_abs>0) = 1;
    i
end

% Heatmap diferencias
pl_dif = tiledlayout(4,3);
title(pl_dif,'Diferencias')
for i=1:length(graphs)
    nexttile
    val = squeeze(diferencia_graphs(i,:,:));
    heatmap(val, 'XData', leads, 'YData', leads)
    title(graphs(i))
    colormap(jet)
end

% Heatmap MI
pl_dif = tiledlayout(3, 4);
graphs = [];
graph_index = [];
for i=1:length(archivos)
    val = squeeze(matriz_mi(i,:,:));
    val_aux = val;
    val_aux(val_aux>7) = -1;
    if (max(val_aux) > 1.65 & max(val_aux) < 3)
        graphs = [graphs;archivos(i)];
        graph_index = [graph_index;i];
        nexttile
        heatmap(val, 'XData', leads, 'YData', leads, 'ColorLimits',[0 5])
        colormap(jet)
    end
end

% Heatmap dif abs
pl_dif_abs = tiledlayout(4,3);
title(pl_dif_abs,'dif abs')
for i=1:length(graphs_TE)
    nexttile
    val = squeeze(dif_graph_abs(i,:,:));
    heatmap(val, 'XData', leads, 'YData', leads, 'ColorLimits',[-1 1])
    title(graphs_TE(i))
    colormap(hot)
end

% Heatmap TE1
pl_te = tiledlayout(3, 4);
graphs_TE = [];
graph_index = [];
for i=1:length(archivos)
    val = squeeze(matriz_TE1(i,:,:));
    if (val(8,10) > 0.4 & val(8,10) < 0.5 & val(8,2) > 0.4 & val(8,2) < 0.5)
        graphs_TE = [graphs_TE;archivos(i)];
        graph_index = [graph_index;i];
        nexttile
        heatmap(val, 'XData', leads, 'YData', leads, 'ColorLimits',[0 0.6])
        colormap(jet)
    end
end

% Contornos diferencias
pl_dif_cont = tiledlayout(5,2);
title(pl_dif_cont,'Diferencias contornos')
for i=1:length(archivos)
    nexttile
    val = squeeze(diferencia(i,:,:));
    contour(val./max(max(val)))
    title(archivos(i))
end



% Contornos MI
pl_mi_cont = tiledlayout(5,2);
title(pl_mi_cont,'MI contornos')
for i=1:length(archivos)
    nexttile
    val = squeeze(matriz_mi(i,:,:));
    contour(val./max(max(val)))
    title(archivos(i))
end



% Contornos TE1
pl_te_cont = tiledlayout(5,2);
title(pl_te_cont,'TE1 contornos')
for i=1:length(archivos)
    nexttile
    val = squeeze(matriz_TE1(i,:,:));
    contour(val./max(max(val)))
    title(archivos(i))
end

% Calculos a realizar:
%%%
% Norma Frobenius
% Norma II
% Autovalores (Calcular cociente entre los 2 autovalores mas grandes)
% Determinante
% Guardar matrices ya calculadas
%%%

load A1880
pl_ecg = tiledlayout(6,2);
for i=1:length(ECG.data)
    nexttile
    plot(ECG.data(i,:))
    title(i)
end

diferencia_graphs = [];
for i=1:length(graphs)
    diferencia_graphs(i,:,:) = matriz_TE1(graph_index(i),:,:)-matriz_TE2(graph_index(i),:,:);
end
    