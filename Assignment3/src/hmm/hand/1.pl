use POSIX;
$classcnt=8;
for($cl=1;$cl<$classcnt+1;$cl++)
{
	$filename="input/class".$cl.".ldf";
	#`mkdir input/class"$cl"`;
	open($class, "<$filename");
	$row=0;
	$size=0;
	while( my $line = <$class>)
	{	
		my @xy;
		$row++;
		if(($row%3)==0){
			my @xy;
			#print $line;
			#3rd  line
			$maxx=0;$maxy=0;
			@dat = split(/ /, $line);
			#print "$dat[1] $dat[2]\n";
			$size = $dat[0] ;
			for($i=1;$i<$size*2;$i=$i+2)
			{
				$xy[floor($i/2)][0]=$dat[$i];
				$xy[floor($i/2)][1]=$dat[$i+1];
				#print "$xy[$i][0] $xy[$i][1]\n";
				if($dat[$i]>$maxx){
					$maxx=$dat[$i];
				}
				if($dat[$i+1] > $maxy){
					$maxy=$dat[$i+1];
				}
			}
			print "$maxx $maxy\n";
			$file=floor($row/3);
			#$filename1="input/".$cl.".ldf";
			open($out, ">input/class$cl/$file.txt");
			$diffx=0;$diffy=0;
			for($i=0;$i<$size;$i++)
			{
				$newx=($xy[$i][0]/$maxx);
				$newy=($xy[$i][1]/$maxy);
				if($i != 0){
					$diffx=$newx-($xy[$i-1][0]/$maxx);
					$diffy=$newy-($xy[$i-1][1]/$maxy);
					$ss = sqrt(($diffx**2)+($diffy**2));
					$diffx=$diffx/$ss;
					$diffy=$diffy/$ss;
				}
				

				print $out "$newx $newy $diffx $diffy\n"
			}
			close($out);
			#last;
		}
		
	}
}