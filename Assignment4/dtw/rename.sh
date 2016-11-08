ls *.mfcc| awk 'BEGIN{ a=0 }{ printf "mv %s %d.mfcc\n", $0, a++ }' | bash
