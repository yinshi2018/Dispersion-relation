clear
clf
clc
load('freeze.mat')
figure(1)
semilogx(s,ot32,'bs-','lineWidth',1);
hold on;
semilogx(s,t32,'rs-','lineWidth',1);
semilogx(s,ot21,'b^-','lineWidth',1);
semilogx(s,t21,'r^-','lineWidth',1);
axis([6 250 -1 1]);
xlabel({'$$\sqrt{S} [GeV]$$'},'interpreter','latex')
ylabel('\kappa\sigma^2')
set(gca,'FontSize',14,'LineWidth',1.5);
lg1=legend({'$$Z^{\|}_{\phi,k}=Z^{\bot}_{\phi,k} T_f(\chi^{B}_{3}/\chi^{B}_{2})$$','$$Z^{\|}_{\phi,k}\neq Z^{\bot}_{\phi,k} T_f(\chi^{B}_{3}/\chi^{B}_{2})$$','$$Z^{\|}_{\phi,k}=Z^{\bot}_{\phi,k} T_f(\chi^{B}_{2}/\chi^{B}_{1})$$','$$Z^{\|}_{\phi,k}\neq Z^{\bot}_{\phi,k} T_f(\chi^{B}_{2}/\chi^{B}_{1})$$'},'interpreter','latex','Location','Southeast');
set(lg1,'Fontname','Tims new roman','FontWeight','bold','FontSize',14,'Box','off')

