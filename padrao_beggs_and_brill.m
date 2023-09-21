clc;
clear all;

##funcoes

##funcao para gerar o grafico
function A = grafico(a1,a2,a3,a4)

  xx = a1:0.0001:a2;##intervalo do grafico
  int = length(xx);##tamanho do intervalo

  ##aplica os valores do intervalo na equacao do L
  for i=1:1:int
    yy(1,i) = (a3*(xx(1,i)^(a4)));
  end

  ##plota o grafico (escala logaritmica)
  loglog(xx,yy);
  axis([0.0001 1 0.1 1000]);
  title("Padrao de escoamento", 'Fontsize', 15);
  hold on;

end


##funcao para determinar os parametros aux
function B = funcao(b1, b2, b3)
  B = (b1*(b3^(b2)));
end

##codigo

##propriedades dos fluidos
printf("____________________Bem-Vindo____________________\n");
printf("\nINFORMACOES DOS FLUIDOS:\n\n");
##vazoes
qo = input('Vazao de Oleo: ');
qg = input('Vazao de Gas: ');

##propriedades do duto
##diametro
printf("\nINFORMACOES DO DUTO:\n\n");
D = input('Diametro: ');

printf("\nPadrao de Escoamento: ");
##area
Area = pi * (D^2)/4;

##velocidades
vl = qo/Area;
vg = qg/Area;
vm = (vl+vg);

##huldup
hut = ((vl)/(vl+vg));
frt = ((vm^2)/(D*9.81));
fr2t = (frt^2);

##parametros aux (para as condicoes)
aux1 = funcao(316, 0.302, hut);
aux2 = funcao(0.000925, -2.4684, hut);
aux3 = funcao(0.1, -1.4516, hut);
aux4 = funcao(0.5, -6.738, hut);

##condicoes para cada regime
if(hut<0.01)

    if(fr2t<aux1)
    printf("Segregado");
    r=1;
    else
    printf("Fora do intervalo");
    r=0;
    end

else if(hut>=0.01)

    if(fr2t<aux2)
      printf("Segregado");
      r=1;
    else if(fr2t>=aux2 && fr2t<=aux3)
      printf("Transicao");
      r=2;
    else

        if(hut<=0.4)

              if(fr2t>=aux3 && fr2t<=aux1)
                printf("Intermitente");
                r=3
              else if(fr2t>=aux1)
                printf("Distribuido");
                r=4;
              else
                printf("Fora do intervalo");
                r=0;
              end
              end

        else

              if(fr2t>=aux3 && fr2t<=aux4)
                printf("Intermitente");
                r=3;
              else if(fr2t>aux4)
                printf("Distribuido");
                r=4;
              else
                printf("Fora do intervalo");
                r=0;

              end
              end

  end
  end


end
end
end


printf("\n\n__________________________________________________");
##chama a funcao para gerar o grafico de cada l
##cada chamada plota um grafico de l1,l2,l3,l4
grafico(0.0001, 0.4, 316, 0.302);
grafico(0.01, 0.2, 0.000925, -2.4684);
grafico(0.01, 1, 0.1, -1.4516);
grafico(0.4, 1, 0.5, -6.738);

##plot do ponto dado
loglog(hut, fr2t, '.', 'MarkerSize', 20);
hold on

switch r

  case 1
    text(hut, fr2t+1.6, "Segregado", 'FontSize', 14);
  case 2
    text(hut, fr2t+1.6, "Transicao",'FontSize', 14);
  case 3
    text(hut, fr2t+1.6, "Intermitente", 'FontSize', 14);
  case 4
    text(hut, fr2t+1.6, "Distribuido", 'FontSize', 14);
  otherwise
    text(0.005, 3, "Fora do intervalo", 'FontSize', 14);
end
##padrao de cada intervalo
text(0.002, 2, "segregado");
text(0.08, 0.9, "transicao");
text(0.1, 10, "intermitente");
text(0.002, 200, "distribuido");
##nomes dos eixos
xlabel('Hold-up-Non Slip', 'Fontsize', 15);
ylabel('Fr^2', 'FontSize', 15);
