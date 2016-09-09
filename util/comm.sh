#!/bin/bash
#xmlstarlet ed -d "//b" instance1.xml > tmp.xml
#xml edit -d "//b" a.xml > b.xml

#cp a.xml b.xml
#sed -i '/<b>/,/<\/b>/d' b.xml

#cp a.xml teste3.xml
#sed -i '/<li:Edital>/,/<\/li:Edital>/d' teste2.xml



declare -a tipos=(
					"LICITACAO-REGISTRO-PRECOS-SIM-TODAS-MODALIDADES"						#0
					"LICITACAO-REGISTRO-PRECOS-NAO-TODAS-MODALIDADES-MENOS-INTERNACIONAL"	#1
					"LICITACAO-REGISTRO-PRECOS-NAO-INTERNACIONAL"							#2
					"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"							#3
				)

declare -a cnpjs=(
					"tag:CNPJ"
				)

declare -a cpfs=(
					"tag:CPF"
					"tag:CPFIntegrante"
				)

declare -a tags=(
					"li:ComissaoLicitacao"						#0
					"li:Edital"									#1
					"li:Amostra"								#2
					"li:Amostra"								#3
					"tag:LoteCompostoItensSim"					#4
				)

generate_lic_number(){
	echo $(date +'%Y%m%d%H%M')0
}

generate_min_max_number (){
	# $1 max number
	# USAGE: new_var=$(generate_min_max_number 100000 999999)
	shuf -i $1-$2 -n 1
}

generate_number (){
	# $1 max number
	# USAGE: new_var=$(generate_number 100000)
	shuf -i 1-$1 -n 1
}

replace_tag_content(){
	# $1 tag
	# $2 new value
	# $3 file
	# USAGE: replace_tag_content tag newContent file.xml
	sed -i "s/\(<$1.*>\).*\(<\/$1.*\)/\1$2\2/" $3
}

add_content (){
	#C=$(echo $CONTENT | sed 's/\//\\\//g')
	sed "/<\/Students>/ s/.*/${C}\n&/" file
}

remove_tag () {
	# $1 tag
	# $2 file
	# USAGE: remove_tag li:Amostra teste2.xml
	sed -i '/<'$1'>/,/<\/'$1'>/g' $2
} 

remove_tag_with_content (){
	sed -i '/'$1'/d' $2
}

change_encode (){
	sed -i -e 's/UTF-8/ISO-8859-1/g' $1
}

simple_replace (){
	sed -i -e 's/'$1'/'$2'/g' $3
}


comment_block (){
	# $1 tag
	# $2 file
	# USAGE: comment_block li:Descritor instance2.xml	
	sed -i 's/<'$1'>/<!-- <'$1'>/; s/<\/'$1'>/<\/'$1'> -->/' $2	
}

generate () {
	name_new_file=$1
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
#remove_tag li:Amostra teste2.xml

#echo $teste


#echo $new_cpf

#array=( "0", "1", "3" )

#generate teste5.xml "${array[@]}"








#change_encode instance2.xml


#replace_tag_content 'tag:CPF' $(bash ./util/cpf.sh) instance2.xml


#replace_tag_content li:CodigoLicitacao $(generate_lic_number) instance2.xml
#echo 'LicNumber:' $(generate_lic_number)


#echo '---------------'


#sed -n 's/.*<gen:TipoDocumento>\([^<]*\)<\/gen:TipoDocumento>.*/\1/p' instance2.xml


