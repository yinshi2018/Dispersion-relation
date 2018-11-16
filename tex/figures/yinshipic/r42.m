clear
clf
clc
load('r42.mat')
plot(or42,'b-','lineWidth',1);
axis([100 300 0 1.2]);
hold on;
plot(r42,'r-','lineWidth',1);
axis([100 300 0 1.2]);
xlabel('T [MeV]')
ylabel('\chi^{B}_{4}/\chi^{B}_{2}')
set(gca,'FontSize',14,'LineWidth',1.5,'XTick',[100,150,200,250,300]);
lg1=legend({'$$Z^{\|}_{\phi,k}=Z^{\bot}_{\phi,k} \chi^{B}_{4}/\chi^{B}_{2}$$','$$Z^{\|}_{\phi,k}\neq Z^{\bot}_{\phi,k} \chi^{B}_{4}/\chi^{B}_{2}$$'},'interpreter','latex','Location','Northeast');
set(lg1,'Fontname','Tims New Roman','FontWeight','bold','FontSize',14,'Box','off')