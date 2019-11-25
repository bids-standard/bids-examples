function[tl1,tl2]=rotatetl(h,rot,tb)

%%%%%%%%%%%%%%%%%%%% Get current graph properties %%%%%%%%%%%%%%%%%%%%%%%
a=get(h,'XTickLabel');
b=transpose(get(h,'XTick'));
c=get(h,'YLim');
if strcmpi(tb,'t') || strcmpi(tb,'top'),
    tb=2;
elseif strcmpi(tb,'b') || strcmpi(tb,'bottom'),
    tb=1;
else
    disp('The third argument is not recognized, try top or bottom');
end

%%%%%%%%%%%%%%%% Erase current tick labels from figure %%%%%%%%%%%%%%%%%%
set(h,'XTickLabel',[]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Routine %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if rot>=0 || rot<=360,
flag=1;
    while flag
        rot=mod(rot,360);
        if rot>=0 && rot<=360,
            flag=0;
        end
    end
end

k=1;
while k<=size(a,1);
    a1(k/2+0.5,:)=a(k,:);
    b1(k/2+.5)=b(k);
    if k+1<=size(a,2);
        a2(k/2+.5,:)=a(:,k+1);
    end
    if k+1<=size(b,1);
        b2(k/2+.5)=b(k+1);
    end
    k=k+2;
end

c1=(c(1,tb)-(c(1,2)-c(1,1))*0.017).*ones(1,length(b1)); % upper ticks
c2=(c(1,tb)-(c(1,2)-c(1,1))*0.017).*ones(1,length(b2)); % lower ticks

tl1=text(b1,c1,a1,'HorizontalAlignment','center','rotation',rot,'VerticalAlignment','cap');
tl2=text(b2,c2,a2,'HorizontalAlignment','center','rotation',rot,'VerticalAlignment','cap');
    
end
