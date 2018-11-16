clear
clf
clc
load('chi13.mat')
figure(1)
subplot(1,2,1)
plot(oldchi1mu50,'b-','lineWidth',1);
hold on;
plot(chi1mu50,'r-','lineWidth',1);
plot(oldchi1mu100,'b--','lineWidth',1);
plot(chi1mu100,'r--','lineWidth',1);
xlabel('T [MeV]')
ylabel('\chi^{B}_{1}')
set(gca,'FontSize',14,'LineWidth',1.5,'XTick',[0,50,100,150,200,250,300]);
lg1=legend({'$$Z^{\|}_{\phi,k}=Z^{\bot}_{\phi,k} \chi^{B}_{1} \mu=50$$','$$Z^{\|}_{\phi,k}\neq Z^{\bot}_{\phi,k} \chi^{B}_{1} \mu=50$$','$$Z^{\|}_{\phi,k}=Z^{\bot}_{\phi,k} \chi^{B}_{1} \mu=100$$','$$Z^{\|}_{\phi,k}\neq Z^{\bot}_{\phi,k} \chi^{B}_{1} \mu=100$$'},'interpreter','latex','Location','Northwest');
set(lg1,'Fontname','Tims new roman','FontWeight','bold','FontSize',14,'Box','off')
subplot(1,2,2)
plot(oldchi3mu50,'b-','lineWidth',1);
hold on;
plot(chi3mu50,'r-','lineWidth',1);
plot(oldchi3mu100,'b--','lineWidth',1);
plot(chi3mu100,'r--','lineWidth',1);
xlabel('T [MeV]')
ylabel('\chi^{B}_{3}')
set(gca,'FontSize',14,'LineWidth',1.5,'XTick',[0,50,100,150,200,250,300]);
lg1=legend({'$$Z^{\|}_{\phi,k}=Z^{\bot}_{\phi,k} \chi^{B}_{3} \mu=50$$','$$Z^{\|}_{\phi,k}\neq Z^{\bot}_{\phi,k} \chi^{B}_{3} \mu=50$$','$$Z^{\|}_{\phi,k}=Z^{\bot}_{\phi,k} \chi^{B}_{3} \mu=100$$','$$Z^{\|}_{\phi,k}\neq Z^{\bot}_{\phi,k} \chi^{B}_{3} \mu=100$$'},'interpreter','latex','Location','Northwest');
set(lg1,'Fontname','Tims New Roman','FontWeight','bold','FontSize',14,'Box','off')
