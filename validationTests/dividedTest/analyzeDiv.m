
function analyzeDiv

subjects=[11,13,15:22,24:28,31,32,35,37,38,40:44,46,47,50,51];
numTrials=18;

for sub=1:size(subjects,2)
    
    thisSub=subjects(1,sub);
    load(['sj' sprintf('%02d',thisSub) '_allDivData.mat'])
    
    for task=1:size(allData,2)
        
        thisTask=allData(task).thisTask;
        condData=allData(task).condData;
        
        if thisTask==1
            numCond=4;
        else
            numCond=2;
        end
        
        for cond=1:numCond
            
            for trial=1:numTrials
                
                resps=[condData(cond).blockTrials(trial).resp1,condData(cond).blockTrials(trial).resp2,...
                    condData(cond).blockTrials(trial).resp3,condData(cond).blockTrials(trial).resp4];
                targets=[condData(cond).blockTrials(trial).target1,condData(cond).blockTrials(trial).target2,...
                    condData(cond).blockTrials(trial).target3,condData(cond).blockTrials(trial).target4];
                
                for stim=1:4
                    respDataMat(task,cond,trial,thisSub,stim)=resps(1,stim);
                    tarDataMat(task,cond,trial,thisSub,stim)=targets(1,stim);
                    if respDataMat(task,cond,trial,thisSub,stim)~=0&&tarDataMat(task,cond,trial,thisSub,stim)==1
                        rtMat(task,cond,trial,thisSub,stim)=respDataMat(task,cond,trial,thisSub,stim);
                    else
                        rtMat(task,cond,trial,thisSub,stim)=NaN;
                    end
                    if respDataMat(task,cond,trial,thisSub,stim)~=0&&tarDataMat(task,cond,trial,thisSub,stim)==1||...
                         respDataMat(task,cond,trial,thisSub,stim)==0&&tarDataMat(task,cond,trial,thisSub,stim)==0
                        accMat(task,cond,trial,thisSub,stim)=1;
                    else
                        accMat(task,cond,trial,thisSub,stim)=NaN;
                    end
                    
                end
                
%                 task
%                 cond
%                 trial
%                 thisSub
%                 
                
                
            end
            
        end
        
    end
    
end

save('allRTMat.mat','rtMat')
save('allAccMat.mat','accMat')

end

