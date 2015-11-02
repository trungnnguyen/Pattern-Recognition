#!/usr/local/bin/perl
use POSIX;

$kvalue=8;
$classcnt=3;
$maxcount =260;
$splitpos=floor(0.8*$maxcount);

`rm -rf *.txt.test* *.txt.train* results`;
@randomlist={};
open($results,">results");
open($results1,">resultscomplete");

$maxaccuracy=0;
for($loop=0;$loop<10;$loop++)
{
	for($i=1;$i<$classcnt+1;$i++)
	{	
		if($i == 2){
			$maxcount =374;
			$splitpos=floor(0.8*$maxcount);
		}elsif($i == 3){
			$maxcount =410;
			$splitpos=floor(0.8*$maxcount);
		}
		for($i1=0;$i1<$maxcount;$i1++)
		{
			$randomlist[$i1]=0;
		}
		for($i2=0;$i2<($maxcount-$splitpos);$i2++)
		{
			$r = int(rand($maxcount));
			#print "$r $randomlist[$r]\n";
			if($randomlist[$r] == 0){
					$randomlist[$r]=1;
					#print "$randomlist[i]\n";
			}else{
				$i2--;
			}
		}
		
		$j=0;
		$filename="class".$i.".txt";
			open($class, "<$filename");
			open($train,">$filename.train");
			open($test,">$filename.test");
				while( my $line = <$class>)
				{
					#print "$randomlist[$i-1]";
					if($randomlist[$j-1] == 0){
							print $train "$line";
						}else{
							print $test "$line";
						}
						$j++;
				}
	}
	
	for($state=1;$state<10;$state++)
	{
		for($i=1;$i<$classcnt+1;$i++)
		{
			$filename="class".$i.".txt.train";
			`./train_hmm "$filename"  100 "$state" "$kvalue" .01`#
		}
		
		#print $results "batch : $loop\n";
		$count=0;
		$accuracy=0;
		for($i=1;$i<$classcnt+1;$i++)#all tests
		{
			$filename="class".$i.".txt.test";
			open($handle,"<$filename");
			while( my $line = <$handle>)  
			{
				open($testhmm,">hmmtestfile");
				print $testhmm $line;
				close($testhmm);
				my $max = -9999;my $out=1;
				$count++;
				for($j=1;$j<$classcnt+1;$j++)#each class
				{
					$hmm = "class".$j.".txt.train".".hmm";
					$res =`./test_hmm hmmtestfile "$hmm"  |grep "batch" | cut -d' ' -f4`;
					#$o = abs($res);
					$o = $res;
					if($max < $o){
						$out = $j;
						$max = $o;
					}
					#print "$count $i $j $o\n";
				}
				#print "$count $i $out $max\n";
				if($i== $out){$accuracy++;}
				#print "$i $out $res";
				print $results1 "$loop $state $count $i $out\n";
			}
			close($handle);
		}
		$accuracy/=$count;
		$accuracy*=100;
		if($maxaccuracy < $accuracy){
			$maxaccuracy = $accuracy ;
			`cp -rf *.txt.test* max `;
			`cp -rf *.txt.train* max `;
		}
		print $results "Accuracy :$loop $state $accuracy $maxaccuracy\n";
		print "Accuracy :$loop $state $accuracy $maxaccuracy\n";
		
		
	}
}
print $results "Ultimate : $maxaccuracy\n";
close($results);
print "Ultimate : $maxaccuracy\n";
