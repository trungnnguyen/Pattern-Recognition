#!/usr/local/bin/perl

$classcnt=5;
$splitpos=128;
$maxcount =160;
`rm -rf *.txt.test* *.txt.train* results`;
@randomlist={};
open($results,">results");
open($results1,">resultscomplete");

$maxaccuracy=0;
for($loop=0;$loop<100;$loop++)
{
	for($i=0;$i<$maxcount;$i++)
	{
		$randomlist[$i]=0;
	}
	for($i=0;$i<($maxcount-$splitpos);$i++)
	{
		$r = int(rand($maxcount));
		#print "$r $randomlist[$r]\n";
		if($randomlist[$r] == 0){
				$randomlist[$r]=1;
				#print "$randomlist[i]\n";
		}else{
			$i--;
		}
	}

	for($i=1;$i<$classcnt+1;$i++)
	{
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

	for($state=1;$state < 10;$state++)
	{
		for($i=1;$i<$classcnt+1;$i++)
		{
			$filename="class".$i.".txt.train";
			`./train_hmm "$filename"  1234 "$state" 64 .01`#
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
					#print "$i $j $o\n";
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
		}
		print $results "Accuracy :$loop $state $accuracy $maxaccuracy\n";
		print "Accuracy :$loop $state $accuracy $maxaccuracy\n";
		
		
	}
}
print $results "Ultimate : $maxaccuracy\n";
close($results);
close($results1);
print "Ultimate : $maxaccuracy\n";
