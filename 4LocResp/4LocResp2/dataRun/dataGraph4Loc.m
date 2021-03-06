
%graph! the! data!

function dataGraph4Loc

load('dataAnFile.mat');

numCond=3;
numTask=2;
numCue=2;
numSub=size(sjRange,2);
numVar=6;

dataMat=nan(numVar,numCond,numTask,numCue,numSub);

for var=1:numVar
    for cond=1:numCond
        if cond==1
            thisCond='low';
        elseif cond==2
            thisCond='med';
        elseif cond==3
            thisCond='high';
        end
        for task=1:numTask
            if task==1
                thisTask='si';
            elseif task==2
                thisTask='du';
            end
            for cue=1:numCue
                if cue==1
                    thisCue='33';
                elseif cue==2
                    thisCue='66';
                end
                for sub=1:numSub
                    sjNum=sjRange(1,sub);
                    if sjNum<=9
                        thisSj=['sj0' sprintf('%d',sjNum)];
                    elseif 9<sjNum
                        thisSj=['sj' sprintf('%d',sjNum)];
                    end
                    fileLoad=[thisSj '_' thisCond thisTask thisCue '.mat'];
                    
                    
                    %added to get rid of highIntf wrong task inst
                    
                    
                    if cond==1||cond==2
                        
                        load(fileLoad);

                        if var==1
                            dataMat(var,cond,task,cue,sub)=errorOm;
                        elseif var==2
                            dataMat(var,cond,task,cue,sub)=errorCom;
                        elseif var==3
                            dataMat(var,cond,task,cue,sub)=accuracyWM;
                        elseif var==4
                            dataMat(var,cond,task,cue,sub)=meanRT;
                        elseif var==5
                            dataMat(var,cond,task,cue,sub)=accuracy;
                        elseif var==6
                            dataMat(var,cond,task,cue,sub)=oriEf;
                        end
                        
                    elseif cond==3
                        
                        useHighSj=[7:9,13:15,19:21,25:27,31:33];
                        
                        if find(useHighSj==sjNum)~=0
                            
                            load(fileLoad);

                            if var==1
                                dataMat(var,cond,task,cue,sub)=errorOm;
                            elseif var==2
                                dataMat(var,cond,task,cue,sub)=errorCom;
                            elseif var==3
                                dataMat(var,cond,task,cue,sub)=accuracyWM;
                            elseif var==4
                                dataMat(var,cond,task,cue,sub)=meanRT;
                            elseif var==5
                                dataMat(var,cond,task,cue,sub)=accuracy;
                            elseif var==6
                                dataMat(var,cond,task,cue,sub)=oriEf;
                            end
                        end
                    end
                end
            end
        end
    end   

    numBins=numCond*numTask*numCue;
    varBins=zeros(1,numBins);
    varSEM=zeros(1,numBins);
    count=1;
    
    for cond=1:numCond
        for task=1:numTask
            for cue=1:numCue
                useScores=(~isnan(dataMat(var,cond,task,cue,:)));
                thisScores=find(useScores~=0);
                graphScores=zeros(1,size(thisScores,1));
                for score=1:size(thisScores,1)
                    graphScores(1,score)=dataMat(var,cond,task,cue,thisScores(score,1));
                end
                meanVar=mean(graphScores);
                sqDev=(graphScores-meanVar).^2;
                SS=sum(sqDev);
                numScores=size(graphScores,2);
                standDev=sqrt(SS/(numScores-1));
                normScores=nan(1,numScores);
                for x=1:numScores
                    if abs(graphScores(1,x)-meanVar)<=(2*standDev)
                        normScores(1,x)=graphScores(1,x);
                    end
                end
                normGraph=normScores(~isnan(normScores));
                varBins(1,count)=mean(normGraph);
                varSEM(1,count)=std(normGraph)/size(normGraph,2);
                count=count+1;
            end
        end
    end
    
    if var==1
        thisVar='Errors of Omission (4loc)';
    elseif var==2
        thisVar='Errors of Comission (4loc)';
    elseif var==3
        thisVar='Working Memory Accuracy (4loc)';
    elseif var==4
        thisVar='Mean Response Time (4loc)';
    elseif var==5
        thisVar='Accuracy (4loc)';
    elseif var==6
        thisVar='Orienting Effect (4loc)';
    end
    
    newplot
    hold
    bar(varBins);
    ylabel(thisVar,'FontSize',12);
    errorbar(varBins,varSEM,'.');
    file=['/Users/dannytoomey/Documents/Research/ADTask/ADTaskPilot/4LocResp/4LocResp/graphs/' sprintf('%s',thisVar)];
    saveas(gcf,file,'png'); 
    hold off
end

numCond=2;
numTask=2;
numCue=2;
numSub=size(sjRange,2);
numVar=3;

locRespMat=nan(numVar,numCond,numTask,numCue,numSub);

for var=1:numVar
    for cond=1:numCond
        if cond==1
            thisCond='med';
        elseif cond==2
            thisCond='high';
        end
        for task=1:numTask
            if task==1
                thisTask='si';
            elseif task==2
                thisTask='du';
            end
            for cue=1:numCue
                if cue==1
                    thisCue='33';
                elseif cue==2
                    thisCue='66';
                end
                for sub=1:numSub
                    sjNum=sjRange(1,sub);
                    if sjNum<=9
                        thisSj=['sj0' sprintf('%d',sjNum)];
                    elseif 9<sjNum
                        thisSj=['sj' sprintf('%d',sjNum)];
                    end
                    fileLoad=[thisSj '_' thisCond thisTask thisCue '.mat'];
                    
                    if cond==1

                        load(fileLoad);
                        if var==1
                            locRespMat(var,cond,task,cue,sub)=colRT;
                        elseif var==2
                            locRespMat(var,cond,task,cue,sub)=rowRT;
                        elseif var==3
                            locRespMat(var,cond,task,cue,sub)=diagRT;
                        end
                        
                    elseif cond==2
                        
                        useHighSj=[7:9,13:15,19:21,25:27,31:33];
                        
                        if find(useHighSj==sjNum)~=0
                            
                            load(fileLoad);
                            if var==1
                                locRespMat(var,cond,task,cue,sub)=colRT;
                            elseif var==2
                                locRespMat(var,cond,task,cue,sub)=rowRT;
                            elseif var==3
                                locRespMat(var,cond,task,cue,sub)=diagRT;
                            end
                        end
                    end 
                end
            end
        end
    end 
end

allMeans=nan(numVar,numCond,numTask,numCue);
taskMeans=nan(numVar,numCond,numTask);
condMeans=nan(numVar,numCond);
condSEM=zeros(numVar,numCond);

for var=1:numVar
    for cond=1:numCond
        for task=1:numTask
            for cue=1:numCue
                useScores=(~isnan(locRespMat(var,cond,task,cue,:)));
                thisScores=find(useScores~=0);
                graphScores=zeros(1,size(thisScores,1));
                for score=1:size(thisScores,1)
                    graphScores(1,score)=locRespMat(var,cond,task,cue,thisScores(score,1));
                end
                meanVar=mean(graphScores);
                sqDev=(graphScores-meanVar).^2;
                SS=sum(sqDev);
                numScores=size(graphScores,2);
                standDev=sqrt(SS/(numScores-1));
                normScores=nan(1,numScores);
                for x=1:numScores
                    if abs(graphScores(1,x)-meanVar)<=(2*standDev)
                        normScores(1,x)=graphScores(1,x);
                    end
                end
                normGraph=normScores(~isnan(normScores));
                allMeans(var,cond,task,cue)=mean(normGraph);
            end
            taskMeans(var,cond,task)=mean(allMeans(var,cond,task,:));
        end
        condMeans(var,cond)=mean(taskMeans(var,cond,:));
        condSEM(var,cond)=std(condMeans(var,cond))/size(condMeans(var,cond),2);
    end
end

binOrder=zeros(1,numCond*numVar);
semOrder=zeros(1,numCond*numVar);
count=1;
for cond=1:numCond
    for var=1:numVar
        binOrder(1,count)=condMeans(var,cond);
        semOrder(1,count)=condSEM(var,cond);
        count=count+1;
    end
end

newplot
hold 
bar(binOrder);
thisVar='Unique Distractor Locations (4loc)';
ylabel(thisVar,'FontSize',12);
errorbar(binOrder,semOrder,'.');
file=['/Users/dannytoomey/Documents/Research/ADTask/ADTaskPilot/4LocResp/4LocResp/graphs/' sprintf('%s',thisVar)];
saveas(gcf,file,'png');    

return

