function strands=divide2conquer(I,wordLength,coverage)

stagger=floor(wordLength/coverage);
N=ceil((I-wordLength)/stagger);

begins=1+(0:N)*stagger;
strands=[begins' begins'+(wordLength-1)];

while sum(strands(end,:)>I)
    strands=strands(1:end-1,:);
end

if 0
    figure(1)
    clf
    hold on
    plot([1 I],[0 0],'b')
    for k=1:N
        plot(strands(k,:),[k k],'r')
    end
    
    figure(2)
    counts=zeros(I,1);
    for k=1:I
        counts(k)=sum((strands(:,1)<=k)&(strands(:,2)>=k));
    end
    hist(counts)
end




    
    





