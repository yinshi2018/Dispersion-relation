clear
clf
clc
load('mphi.mat')
figure(1)
subplot(1,2,1)
plot(ofmSigma,'b-','lineWidth',1);
hold on;
plot(fmSigma,'r-','lineWidth',1);
plot(ofmPion,'b--','lineWidth',1);
plot(fmPion,'r--','lineWidth',1);
xlabel('T [MeV]')
ylabel('m [MeV]')
set(gca,'FontSize',14,'LineWidth',1.5,'XTick',[0,50,100,150,200,250,300]);
lg1=legend({'$$Z^{\|}_{\phi,k}=Z^{\bot}_{\phi,k} m_{\sigma}$$','$$Z^{\|}_{\phi,k}\neq Z^{\bot}_{\phi,k} m_{\sigma}$$','$$Z^{\|}_{\phi,k}=Z^{\bot}_{\phi,k} m_{\pi}$$','$$Z^{\|}_{\phi,k}\neq Z^{\bot}_{\phi,k} m_{\pi}$$'},'interpreter','latex','Location','West');
set(lg1,'Fontname','Tims new roman','FontWeight','bold','FontSize',14,'Box','off')
subplot(1,2,2)
plot(opmSigma,'b-','lineWidth',1);
hold on;
plot(pmSigma,'r-','lineWidth',1);
plot(opmPion,'b--','lineWidth',1);
plot(pmPion,'r--','lineWidth',1);
xlabel('T [MeV]')
ylabel('m [MeV]')
set(gca,'FontSize',14,'LineWidth',1.5,'XTick',[0,50,100,150,200,250,300]);
lg1=legend({'$$Z^{\|}_{\phi,k}=Z^{\bot}_{\phi,k} m_{\sigma}$$','$$Z^{\|}_{\phi,k}\neq Z^{\bot}_{\phi,k} m_{\sigma}$$','$$Z^{\|}_{\phi,k}=Z^{\bot}_{\phi,k} m_{\pi}$$','$$Z^{\|}_{\phi,k}\neq Z^{\bot}_{\phi,k} m_{\pi}$$'},'interpreter','latex','Location','Northwest');
set(lg1,'Fontname','Tims New Roman','FontWeight','bold','FontSize',14,'Box','off')
