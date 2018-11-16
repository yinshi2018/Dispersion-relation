clear
clf
clc
load('chi2chi4.mat')
figure(1)
subplot(1,2,1)
plot(ochi2,'b-','lineWidth',1);
hold on;
plot(chi2,'r-','lineWidth',1);
!plot(oldchi2mu100,'b--','lineWidth',1);
!plot(chi2mu100,'r--','lineWidth',1);
xlabel('T [MeV]')
ylabel('\chi^{B}_{2}')
set(gca,'FontSize',14,'LineWidth',1.5,'XTick',[0,50,100,150,200,250,300]);
lg1=legend({'$$Z^{\|}_{\phi,k}=Z^{\bot}_{\phi,k} \chi^{B}_{2} $$','$$Z^{\|}_{\phi,k}\neq Z^{\bot}_{\phi,k} \chi^{B}_{2} $$'},'interpreter','latex','Location','Northwest');
set(lg1,'Fontname','Tims new roman','FontWeight','bold','FontSize',14,'Box','off')
subplot(1,2,2)
plot(ochi4,'b-','lineWidth',1);
hold on;
plot(chi4,'r-','lineWidth',1);
!plot(oldchi4mu100,'b--','lineWidth',1);
!plot(chi4mu100,'r--','lineWidth',1);
xlabel('T [MeV]')
ylabel('\chi^{B}_{4}')
set(gca,'FontSize',14,'LineWidth',1.5,'XTick',[0,50,100,150,200,250,300]);
lg1=legend({'$$Z^{\|}_{\phi,k}=Z^{\bot}_{\phi,k} \chi^{B}_{4} $$','$$Z^{\|}_{\phi,k}\neq Z^{\bot}_{\phi,k} \chi^{B}_{4} $$'},'interpreter','latex','Location','Northwest');
set(lg1,'Fontname','Tims New Roman','FontWeight','bold','FontSize',14,'Box','off')
