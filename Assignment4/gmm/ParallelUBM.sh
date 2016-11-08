# MODEFILE : file that will contain the model built. CHANGE this every
#            time a new model needs to be built
# CODEBOOKSIZE : number of mixtures
if [ $# != 4 ]; then
	echo "USAGE: bash ParallelUBM.sh FeatureList UBMFileName CodebookSize UbmDumpDirectory"
	exit
fi
FEATLISTAPP=$1
MODELFILE=$2
CODEBOOKSIZE=$3
ubmDumpDir=$4
INITLIST=temp.initlist
INITLISTSIZE=20

# make sure the binaries exist
INITBIN=/sre/karthik/ivec/bin/Init
VQMapper=/sre/karthik/ivec/bin/VQIter
VQReducer=/sre/karthik/ivec/bin/VQComb
GMMMapper=/sre/karthik/ivec/bin/GMMIter
GMMReducer=/sre/karthik/ivec/bin/GMMComb
INITOUTFILE=vfinal

# number of VQ and GMM iterations
numVQ=10
numGMM=0

# doInit : unset only restarting from a particular GMM iteration
doInit=1

# unset when skipping VQ steps 
runVQ=1
vqStartIter=1

# runGMM : unset when gmm step is not necessary
runGMM=0
gmmStartIter=1

# initialize vq model

if [ $doInit -eq 1 ]; then
    head -$INITLISTSIZE $FEATLISTAPP > $INITLIST
    $INITBIN -i $INITLIST -s 2161 -l -d -k $CODEBOOKSIZE -o $INITOUTFILE
fi

if [ $runVQ -eq 1 ]; then
    for i in `seq $vqStartIter $numVQ`; do
        # parallelize vqiteration 
        rm $ubmDumpDir/vq$i.*
        less $FEATLISTAPP | parallel -j30 --colsep ' ' "$VQMapper -i {1} -d -k $CODEBOOKSIZE -b vfinal -o $ubmDumpDir/vq$i.{1/} > /dev/null"
        # create list
        ls $ubmDumpDir/vq$i.* > vqlist
        $VQReducer -i vqlist -o vfinal
        cp vfinal $ubmDumpDir/vfinal.$i
        rm $ubmDumpDir/vq$i.*
    done
fi

rm vqlist

if [ $runGMM -eq 1 ]; then
    for i in `seq $gmmStartIter $numGMM`; do
        parallel -j30 -a $FEATLISTAPP --colsep ' ' $GMMMapper -i {1} -d -k $CODEBOOKSIZE -b vfinal -o $ubmDumpDir/gmm$i.{1/}
        ls $ubmDumpDir/gmm$i.* > gmmlist
        $GMMReducer -i gmmlist -o gfinal
        cp gfinal $ubmDumpDir/gfinal.$i
        rm $ubmDumpDir/gmm$i.*
    done
fi

rm gmmlist
rm $MODELFILE
python /sre/karthik/ivec/scripts/ConvGMM.py vfinal  $MODELFILE
