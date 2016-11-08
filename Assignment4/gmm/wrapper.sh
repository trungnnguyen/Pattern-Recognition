#!/bin/bash
WD=..
trainWaveListFile=$WD/lists/trainWaveList
testWaveListFile=$WD/lists/testWaveList
trainFeatListFile=$WD/lists/trainFeatList
testFeatListFile=$WD/lists/testFeatList
featureDirectory=$WD/featureDirectory
modelDirectory=$WD/modelDirectory
resultDirectory=$WD/resultDirectory
trainFeatDirectory=$featureDirectory/train
testFeatDirectory=$featureDirectory/test
modelList=$WD/lists/modelList
resultFile=$WD/resultFile
ubm=$WD/ubm

mkdir $featureDirectory
mkdir $trainFeatDirectory
mkdir $testFeatDirectory
mkdir $modelDirectory
mkdir $resultDirectory
rm $modelDirectory/*
rm $resultDirectory/*
rm $ubm

featureExec=$WD/bin/ComputeFeatures
configFile=$WD/config_files/fe-ctrl.base
adaptExec=$WD/bin/AdaptOnlyMeans_2004_d
groundTruthFile=$WD/lists/groundTruthFile
parallelAdapt=$WD/scripts/parallelAdapt
formatResultFile=$WD/scripts/formatResult.sh
#ls $WD/data/train/new/*.sph > $trainWaveListFile
#ls $WD/data/test/new/*.sph > $testWaveListFile

VADThreshold=0.06
feature=frameFilterbankEnergy


less $trainWaveListFile |parallel -v $featureExec $configFile {1} $feature $trainFeatDirectory/{1/.} $VADThreshold A
ls $trainFeatDirectory/* > $trainFeatListFile
less $testWaveListFile |parallel -v $featureExec $configFile {1} $feature $testFeatDirectory/{1/.} $VADThreshold A
ls $testFeatDirectory/* > $testFeatListFile
bash $WD/scripts/ubm_building.sh $ubm $trainFeatListFile

less $trainFeatListFile | parallel -v $adaptExec $ubm 256 {1} $modelDirectory/{/.} 16

testCount=`less $testFeatListFile |wc -l`
ls $modelDirectory/* > $modelList
sed -i 's/$/ 256/' $modelList
less $parallelAdapt |parallel -v
seq 1 $testCount |parallel tail -1 $resultDirectory/{1}.out >$resultFile

vim -s $formatResultFile $resultFile
hits=`cat $resultFile $groundTruthFile | sort |uniq -d |wc -l` 
accuracy=`echo "scale=4;($hits*100.0)/$testCount" | bc`
#echo "hits = $hits Accuracy = $accuracy" >> finalResultFile
echo "hits = $hits Accuracy = $accuracy"
