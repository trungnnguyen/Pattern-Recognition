open( $in,"<testlist");
while(my $line =<$in>)
{
	chomp $line;

	print "\n$line";
	print "\nsil";
	$word= `grep $line testlist | cut -d'/' -f5|cut -d'.' -f1`;
	chomp $word;
	my @abc = split(//, $word);

	foreach $i (@abc) {
		if($i eq "o")
		{
			print "\nhmm_word_o";
		}elsif($i == "1")
		{
			print "\nhmm_word_1";
		}elsif($i == "2")
		{
			print "\nhmm_word_2";
		}elsif($i == "3")
		{
			print "\nhmm_word_3";
		}elsif($i == "4")
		{
			print "\nhmm_word_4";
		}elsif($i == "5")
		{
			print "\nhmm_word_5";
		}elsif($i == "6")
		{
			print "\nhmm_word_6";
		}elsif($i == "7")
		{
			print "\nhmm_word_7";
		}elsif($i == "8")
		{
			print "\nhmm_word_8";
		}elsif($i == "9")
		{
			print "\nhmm_word_9";
		}elsif($i eq "z")
		{
			print "\nhmm_word_z";
		}
	}
	#print "\n$word";
	print "\nsil\n.";
}
