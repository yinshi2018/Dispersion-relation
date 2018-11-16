clear
clf
clc
load('fpi.mat')
figure(1)
plot(ofpi,'b-','lineWidth',1);
hold on;
plot(fpi,'r-','lineWidth',1);
xlabel('T [MeV]')
ylabel({'$$f_{\pi}$$ [MeV]'},'interpreter','latex')
set(gca,'FontSize',14,'LineWidth',1.5,'XTick',[0,50,100,150,200,250,300]);
lg1=legend({'$$Z^{\|}_{\phi,k}=Z^{\bot}_{\phi,k}$$','$$Z^{\|}_{\phi,k}\neq Z^{\bot}_{\phi,k}$$'},'interpreter','latex','Location','Northeast');
set(lg1,'Fontname','Tims new roman','FontWeight','bold','FontSize',14,'Box','off')

