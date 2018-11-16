clear
clf
clc
load('mf.mat')
figure(1)
plot(omf,'b-','lineWidth',1.5);
hold on;
plot(mf,'r-','lineWidth',1.5);
xlabel('T [MeV]')
ylabel('m [MeV]')
set(gca,'FontSize',14,'LineWidth',1.5);
lg1=legend({'$$Z^{\|}_{\phi,k}=Z^{\bot}_{\phi,k}$$','$$Z^{\|}_{\phi,k}\neq Z^{\bot}_{\phi,k}$$'},'interpreter','latex','Location','Northeast');
set(lg1,'Fontname','Tims new roman','FontWeight','bold','FontSize',14,'Box','off')

