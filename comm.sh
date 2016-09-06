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
	shuf -i 1-$1 -n 1
}

remove_tag () {
   sed -i '/<'$2'>/,/<\/'$2'>/d' $1
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

teste=$(generate_number 100000)

echo $teste

new_cpf=bash ./util/cpf.sh
echo $new_cpf

array=( "0", "1", "3" )

generate teste5 "${array[@]}"

