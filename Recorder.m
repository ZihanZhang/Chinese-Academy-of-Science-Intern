recObj=audiorecorder;
disp('Start speaking')
recordblocking(recObj,5);
disp('End of Recording');
play(recObj);
myRecording=getaudiodata(recObj);
plot(myRecording);