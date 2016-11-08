`ls test/class*/* > testFile`;
`ls train/class*/* > trainFile`;

open($test, "<testFile");
open($results,">results");
$count=1;
while (my $testline = <$test>) {
	chomp $testline;
	open($train, "<trainFile");
	print "$count\n";
	while (my $trainline = <$train>){
		chomp $trainline;
		#print "./ComputeDTW $testline $trainline 1 temp 38 out \n";
		`./ComputeDTW "$testline" "$trainline" 1 temp 38 out`;
		$result = `cat resultsDTW/norm_out.dds |cut -d' ' -f2`;
		chomp $result;
		print $results "$result\t";

	}
	print $results "\n";
	close($train);
	$count++;

}
