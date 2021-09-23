%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% .m script of web demo "Insert title here" 
% Written for GNU Octave
% 
% INSTITUTE OF TELECOMMUNICATIONS  
% University of Stuttgart 
% www.inue-uni-stuttgart.de 
% author: Mahmudul Hasan  
% date: 02.18.2016   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%matrixH(select8,text3,text4,select5,hr1,enum4,uploadfile1,filename)
function [LinkMat] = demo_1_main(  code1, code2, code3,enum4, filename)
% function [link_mat] = demo_1_fun(text1, enum1, checkbox1, range1, select1, filename)
% 
% % matrixH takes degree profiles, density in percentage from user and filename to save on
%  % Create an invisible figure.
 
    fig = figure(1); %set(fig, "visible", "off");
 
    set(fig, "visible", "off");



  landscape = "-S930,350";
  portrait  = "-S640,480";

  output_format = portrait;     % default


 set(0, "defaultlinelinewidth", 2);
 set(0, "defaultaxesfontsize", 8);
 set(0, "defaultaxesfontname", "Helvetica");
 set(0, "defaulttextfontsize", 8);
 set(0, "defaulttextfontname", "Helvetica");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t=[];
t1=[];

 if code1==0 && code2==0&& code3==0
     
     H=load('A.mat');
     H=H.ans;
     t3=['n=8'];
     t4=['n-k=8'];
    
         
elseif code1==3 
    
     H = load('docsis_short.mat');
     H=H.B;
     t3=['n=1080'];
     t4=['n-k=270'];
     t=['H of LDPC for Docsis short code with block size ',t3];
     t1=['Degree profiles of LDPC for Docsis short code with block size ',t3];
     
 elseif code1==2 
     H = load('docsis_medium.mat');
     H=H.C;
     t3=['n=5940'];
     t4=['n-k=900'];
    t=['H of LDPC for Docsis medium code with block size ',t3];
    t1=['Degree profiles of LDPC for Docsis medium code with block size ',t3];
    
 elseif code1==1 
     H = load('docsis_long.mat');
     H=H.D;
     t3=['n=16200'];
     t4=['n-k=1800'];
    t=['H of LDPC for Docsis long code with block size ',t3];
    t1=['Degree profiles of LDPC for Docsis long code with block size ',t3];
    
end

if code2==1 
H = load('code_.5_802.11_L_27.mat');
H = H.E;
t3=['n=648'];
     t4=['n-k=324'];
t= ['H of Wifi IEEE 802.11n with Rate  = 0.5 and block size ',t3];
t1=['Degree profiles of Wifi IEEE 802.11n with Rate  = 0.5 and block size',t3];

elseif code2==2 
    H = load('code_.67_802.11_L_27.mat');
H = H.F;
t3=['n=648'];
     t4=['n-k=216'];
t= ['H of Wifi IEEE 802.11n with Rate  = 0.67 and block size ',t3];
t1=['Degree profiles of Wifi IEEE 802.11n with Rate  = 0.67 and block size ',t3];

elseif code2==3 
H = load('code_.75_802.11_L_27.mat');
H = H.G;
t3=['n=648'];
     t4=['n-k=162'];
t= ['H of Wifi IEEE 802.11n with Rate  = 0.75 and block size ',t3];
t1=['Degree profiles of Wifi IEEE 802.11n with Rate  = 0.75 and block size ',t3];

elseif code2==4 
    H = load('code_.83_802.11_L_27.mat');
H = H.H;
t3=['n=648'];
     t4=['n-k=108'];
t= ['H of Wifi IEEE 802.11n with Rate  = 0.83 and block size ',t3];
t1=['Degree profiles of Wifi IEEE 802.11n with Rate  = 0.83 and block size ',t3];

elseif code2==5 
    H = load('code_.5_802.11_L_54.mat');
H = H.I;
t3=['n=1296'];
     t4=['n-k=648'];
t= ['H of Wifi IEEE 802.11n with Rate  = 0.5 and block size ',t3];
t1=['Degree profiles of Wifi IEEE 802.11n with Rate = 0.5 and block size ',t3];

elseif code2==6 
    H = load('code_.67_802.11_L_54.mat');
H = H.J;
t3=['n=1296'];
     t4=['n-k=432'];
t= ['H of Wifi IEEE 802.11n with Rate  = 0.67 and block size ',t3];
t1=['Degree profiles of Wifi IEEE 802.11n with Rate  = 0.67 and block size ',t3];

elseif code2==7 
    H = load('code_.75_802.11_L_54.mat');
H = H.K;
t3=['n=1296'];
     t4=['n-k=324'];
t= ['H of Wifi IEEE 802.11n with Rate  = 0.75 and block size ',t3];
t1=['Degree profiles of Wifi IEEE 802.11n with Rate  = 0.75 and block size ',t3];

elseif code2==8 
    H = load('code_.83_802.11_L_54.mat');
H = H.L;
t3=['n=1296'];
     t4=['n-k=216'];
t= ['H of Wifi IEEE 802.11n with Rate  = 0.83 and block size ',t3];
t1=['Degree profiles of Wifi IEEE 802.11n with Rate  = 0.83 and block size ',t3];

elseif code2==9 
    H = load('code_.5_802.11_L_81.mat');
H = H.M;
t3=['n=1944'];
     t4=['n-k=972'];
t= ['H of Wifi IEEE 802.11n  with Rate  = 0.5 and block size ',t3];
t1=['Degree profiles of Wifi IEEE 802.11n with Rate  = 0.5 and block size ',t3];

elseif code2==10 
    H = load('code_.67_802.11_L_81.mat');
H = H.N;
t3=['n=1944'];
     t4=['n-k=648'];
t= ['H of Wifi IEEE 802.11n  with Rate  = 0.67 and block size ',t3];
t1=['Degree profiles of Wifi IEEE 802.11n  with Rate  = 0.67 and block size ',t3];

elseif code2==11 
    H = load('code_.75_802.11_L_81.mat');
H = H.O;
t3=['n=1944'];
     t4=['n-k=486'];
t= ['H of Wifi IEEE 802.11n with Rate  = 0.75 and block size ',t3];
t1=['Degree profiles of Wifi IEEE 802.11n with Rate  = 0.75 and block size ',t3];

elseif code2==12 
    H = load('code_.83_802.11_L_81.mat');
H = H.P;
t3=['n=1944'];
     t4=['n-k=324'];
t= ['H of Wifi IEEE 802.11n with Rate  = 0.83 and block size ',t3];
t1=['Degree profiles of Wifi IEEE 802.11n with Rate  = 0.83 and block size',t3];


end   
    
    
if code3==1 
    H = load('wimax_.50.mat');
H = H.Q;
t3=['n=2304'];
     t4=['n-k=1152'];
t= ['H of WiMax IEEE 802.16 with Rate  = 0.5 and block size ',t3];
t1=['Degree profiles of WiMax IEEE 802.16 with Rate  = 0.5 and block size ',t3];

elseif code3==2 
    
    H = load('wimax_.67A.mat');
H = H.R;
t3=['n=2304'];
t4=['n-k=768'];
t= ['H of WiMax IEEE 802.16 with Rate  = 0.67A and block size ',t3];
t1=['Degree profiles of WiMax IEEE 802.16 with Rate  = 0.67A and block size ',t3];

elseif code3==3 
   H = load('wimax_.67B.mat');
H = H.S;
t3=['n=2304'];
     t4=['n-k=768'];
t= ['H of WiMax IEEE 802.16 with Rate  = 0.67B and block size ',t3];
t1=['Degree profiles of WiMax IEEE 802.16 with Rate  = 0.67B and block size ',t3];

elseif code3==4 
    H = load('wimax_.75A.mat');
H = H.T;
t3=['n=2304'];
     t4=['n-k=576'];
t= ['H of WiMax IEEE 802.16 with Rate  = 0.75A and block size',t3];
t1=['Degree profiles of WiMax IEEE 802.16 with Rate  = 0.75A and block size',t3];

elseif code3==5 
    H = load('wimax_.75B.mat');
H = H.U;
t3=['n=2304'];
     t4=['n-k=576'];
t= ['H of WiMax IEEE 802.16 with Rate  = 0.75B and block size ',t3];
t1=['Degree profiles of WiMax IEEE 802.16 with Rate  = 0.75B and block size ',t3];

elseif code3==6 
    H = load('wimax_.83.mat');
H = H.V;
t3=['n=2304'];
 t4=['n-k=384'];
t= ['H of WiMax IEEE 802.16 with Rate  = 0.83 and block size ',t3];
t1=['Degree profiles of WiMax IEEE 802.16 with Rate  = 0.83 and block size ',t3];

end
   
if enum4==0
 spy(H ,'+',0.5);               % Plots matrix H
 xlabel(t3);                 % Remove x-label
 ylabel(t4);
 %set(gca,'XTick',[]);        % Remove numbers on x-axis
 %set(gca,'YTick',[]);        % Remove numbers on y-axis
 title(t);   % Add title
else
 dvi = sum(H,1);           % <-- Following 6 lines to compute the average dv and dc as it might be an irregular code
 dci = sum(H,2)';
[adv,bdv] = hist(dvi,unique(dvi));
 [adc,bdc] = hist(dci,unique(dci));
 adv(adv == 0) = NaN;
 stem(bdv,adv,'linewidth',2);
 hold on;
 adc(adc == 0) = NaN;
 stem (bdc,adc, 'linewidth',2,"r");
 xlim([min(min(bdv),min(bdc))-1 max(max(bdv),max(bdc))+1]);
 title(t1);
 xlabel('Degree of nodes');
 ylabel('Number of nodes');
 grid on;
 axis on;
legend('dv','dc','location','NorthEast');

end
 %Create an image file. This image is displayed on the webpage. Its size
% must be 640x480.
%print(filename, "-dgif","-S640,480", "-r0");
 print(filename, "-dpng", output_format);
%   print(filename, "-dpng",output_format);
%print(filename, "-djpg","-S1280,960", "-r0");
 
%     print(["fig_",filename], "-dsvg",output_format);
  


 matrixfile = strrep(filename,'_plot.png',sprintf('_matrix_N%d_M%d',size(H,2),size(H,1)));
     save('-mat7-binary',[matrixfile,'.mat'], 'H');  
     LinkMat = ['<a href=./',matrixfile,'.mat>Parity-check matrix (MATLAB .mat file)</a>'];
% print(filename, "-dgif","-S640,480", "-r0");  % Prints the figure
end
