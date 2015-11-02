#!/usr/local/bin/perl


#cvlc 1.avi --rate=1 --video-filter=scene --vout=dummy  --scene-format=png --scene-ratio=1 --scene-prefix=img  --scene-path=./1/ vlc://quit
for($class=1;$class<4;$class++)
{
	$classname ="class".$class;
	for($item=1;$item<101;$item++)
	{
		`mkdir $classname/$item`;
		`cvlc "$classname/$item".avi --rate=1 --video-filter=scene --vout=dummy  --scene-format=jpg --scene-ratio=12 --scene-prefix=img  --scene-path=."/$classname/$item" vlc://quit`;
		`sh 2.sh $classname/$item`;
	}
}


