clear
clf
clc
load('trace.mat')
figure(1)
!subplot(1,2,1)
plot(otrcanol,'b-','lineWidth',1);
hold on;
plot(trcanol,'r-','lineWidth',1);
xlabel('T [MeV]')
ylabel({'$$(\epsilon-3p)/T^4$$'},'interpreter','latex')
set(gca,'FontSize',14,'LineWidth',1.5,'XTick',[0,50,100,150,200,250,300]);
lg1=legend({'$$Z^{\|}_{\phi,k}=Z^{\bot}_{\phi,k}$$','$$Z^{\|}_{\phi,k}\neq Z^{\bot}_{\phi,k}$$'},'interpreter','latex','Location','Northwest');
set(lg1,'Fontname','Tims new roman','FontWeight','bold','FontSize',14,'Box','off')
!subplot(1,2,2)
!plot(otrcp,'b-','lineWidth',1);
!hold on;
!plot(trcp,'r-','lineWidth',1);
!xlabel('T [MeV]')
!ylabel({'$$(\epsilon-3p)/T^4$$'},'interpreter','latex')
!set(gca,'FontSize',14,'LineWidth',1.5,'XTick',[0,50,100,150,200,250,300]);


