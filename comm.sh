#!/bin/bash
#xmlstarlet ed -d "//b" instance1.xml > tmp.xml
#xml edit -d "//b" a.xml > b.xml

#cp a.xml b.xml
#sed -i '/<b>/,/<\/b>/d' b.xml

#cp a.xml teste3.xml
#sed -i '/<li:Edital>/,/<\/li:Edital>/d' teste2.xml





declare -a tags=(
						"li:ComissaoLicitacao"						#0
						"li:Edital"									#1
						"li:Amostra"								#2
						"li:Amostra"								#3
						"tag:LoteCompostoItensSim"					#4
					)

generate_number(){
	# $1 max number
	# USAGE: new_var=$(generate_number 100000)
	shuf -i 1-$1 -n 1
}

replace_tag_content(){
	# $1 tag
	# $2 new value
	# $3 file
	# USAGE: replace_tag_content a das b.xml
	sed -i "s/\(<$1.*>\).*\(<\/$1.*\)/\1$2\2/" $3
}

remove_tag () {
	# $1 tag
	# $2 file
	# USAGE: remove_tag li:Amostra teste2.xml
	sed -i '/<'$1'>/,/<\/'$1'>/d' $2
} 

generate () {
	name_new_file=$1".xml"
	cp complete.xml $name_new_file

	shift

	for j in "${@}"
	do
	   echo '>>>>' "$j"
	  # tag_to_remove="${tags[j]}"

	done


	#declare tagsToRemove=()

	#$ echo "${allTags[2]}"


	#for i in "${tags[@]}"
	#do
	  # echo "$i"
	#done
}

#replace_tag_content a das b.xml
remove_tag li:Amostra teste2.xml

#echo $teste

#new_cpf=bash ./util/cpf.sh
#echo $new_cpf

#array=( "0", "1", "3" )

#generate teste5 "${array[@]}"

