#!/bin/bash

generate_number(){
	shuf -i 1-$1 -n 1
}

round() {
	echo $1 | awk '{echo int($1+0.5)}'
}

gerarCNPJ() {
    n=9
	n1=$(generate_number 9)
	n2=$(generate_number 9)
	n3=$(generate_number 9)
	n4=$(generate_number 9)
	n5=$(generate_number 9)
	n6=$(generate_number 9)
	n7=$(generate_number 9)
	n8=$(generate_number 9)
	n9=0
	n10=0
	n11=0
	n12=1

	d1=$(($n12*2+$n11*3+$n10*4+$n9*5+$n8*6+$n7*7+$n6*8+$n5*9+$n4*2+$n3*3+$n2*4+$n1*5))

	mod1=$(($d1%11))
	d1=$((11-$mod1))
	if (( $d1 >= 10 ))
	then
	    d1=0
	fi

	d2=$(($d1*2+$n12*3+$n11*4+$n10*5+$n9*6+$n8*7+$n7*8+$n6*9+$n5*2+$n4*3+$n3*4+$n2*5+$n1*6))

	mod2=$(($d2%11))
	d2=$((11-$mod2))
	if (( $d2 >= 10 ))
	then
	    d2=0
	fi

	echo $n1$n2$n3$n4$n5$n6$n7$n8$n9$n10$n11$n12$d1$d2

}

gerarCNPJ
