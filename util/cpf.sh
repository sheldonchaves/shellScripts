#!/bin/bash

generate_number(){
	shuf -i 1-$1 -n 1
}

round() {
	echo $1 | awk '{echo int($1+0.5)}'
}

gerarCPF() {
    n=9
	n1=$(generate_number 9)
	n2=$(generate_number 9)
	n3=$(generate_number 9)
	n4=$(generate_number 9)
	n5=$(generate_number 9)
	n6=$(generate_number 9)
	n7=$(generate_number 9)
	n8=$(generate_number 9)
	n9=$(generate_number 9)

	d1=$(($n9*2+$n8*3+$n7*4+$n6*5+$n5*6+$n4*7+$n3*8+$n2*9+$n1*10))

	mod1=$(($d1%11))
	d1=$((11-$mod1))
	if (( $d1 >= 10 ))
	then
	    d1=0
	fi

	d2=$(($d1*2+$n9*3+$n8*4+$n7*5+$n6*6+$n5*7+$n4*8+$n3*9+$n2*10+$n1*11))

	mod2=$(($d2%11))
	d2=$((11-$mod2))
	if (( $d2 >= 10 ))
	then
	    d2=0
	fi

	echo $n1$n2$n3$n4$n5$n6$n7$n8$n9$d1$d2
}