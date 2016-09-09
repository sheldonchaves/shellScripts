#!/bin/bash

source ./util/comm.sh
source ./util/cpf.sh
source ./util/cnpj.sh

sourceXML="sourceXML"
lic="lic"
opcao="opcao"
sub="sub"
newFileName=""

sublic2="sublic2"



#################################################################
function gerarArquivo(){
  clear;
  echo "================================================"
  echo '  lic: '$lic
  echo '  sourceXML: '$sourceXML
  echo '  opcao: '$opcao
  echo '  sub: '$sub
  echo '  sublic2: '$sublic2
  echo "================================================"

  #-------------------------------------------------------------
  # Make a copy of xml file
  echo 'copy file...'
  newFileName=$lic'_'$(date +'%Y%m%d')'_'$(date +'%H%M')
  tempFile=temp_file.xml
  cp $sourceXML $tempFile 

  sed -i -- 's/<!--//g' $tempFile 
  sed -i -- 's/-->//g' $tempFile 

  #-------------------------------------------------------------
  # Change Encode ISO-8859-1
  echo 'change encode...'
  change_encode $tempFile 

  #-------------------------------------------------------------
  # Replace TipoDocumento
  echo 'replace TipoDocumento...'
  replace_tag_content 'gen:TipoDocumento' ${tipos[$opcao]} $tempFile 

  #-------------------------------------------------------------
  # Replace Entidade
  echo 'replace Entidade...'
  replace_tag_content 'gen:Entidade' '1' $tempFile 

  #-------------------------------------------------------------
  # Replace Municipio
  echo 'replace Municipio...'
  replace_tag_content 'gen:Municipio' '6101' $tempFile 

  #-------------------------------------------------------------
  # Replace DataCriacaoXML
  echo 'generate DataCriacaoXML...'
  replace_tag_content 'gen:DataCriacaoXML' $(date +'%Y-%m-%d') $tempFile 

  #-------------------------------------------------------------
  # Replace DataCriacaoXML
  echo 'generate CodigoLicitacao...'
  replace_tag_content 'li:CodigoLicitacao' $(generate_lic_number) $tempFile 

  #-------------------------------------------------------------
  # Generate CPF
  echo 'replacing CPFs...'
  for i in "${cpfs[@]}"
  do
    newCPF=$(gerarCPF) 
    replace_tag_content $i $newCPF $tempFile
  done

  #-------------------------------------------------------------
  # Generate CNPJ
  echo 'replacing CNPJs...'
  for i in "${cnpjs[@]}"
  do
    newCNPJ=$(gerarCNPJ) 
    replace_tag_content $i $newCNPJ $tempFile
  done

  #-------------------------------------------------------------
  # Generate sub Options
  generate_lic_2
















  echo "================================================"
  newFileName=$newFileName'.xml'
  mv $tempFile $newFileName
  echo 'File Generated: '$newFileName 
}

function generate_lic_2(){
  if [ $sub = "c" ]
  then
      newFileName=$newFileName'_completa'
      echo ""
      echo "-- Completa --"
      comment_block 'li:PreQualificacaoNao' $tempFile
      comment_block 'tag:ConvenioFederal' $tempFile
  else
      newFileName=$newFileName'_minima'
      echo ""
      echo "-- Minima --"

      comment_block 'li:PreQualificacaoSim' $tempFile
      comment_block 'tag:CNPJ' $tempFile
      comment_block 'tag:OutroDoc' $tempFile
      comment_block 'tag:OrcamentoLoteNao' $tempFile
      comment_block 'tag:OrcamentoItemNao' $tempFile
      comment_block 'tag:LoteCompostoItensNao' $tempFile
      comment_block 'li:ExistenciaRecursosNao' $tempFile
      comment_block 'li:Artigo17' $tempFile
      comment_block 'li:NaoSeEnquadra' $tempFile
      comment_block 'li:AudienciaPublica-Dt' $tempFile
      comment_block 'li:TributosEstaduais' $tempFile
      comment_block 'li:TributosMunicipais' $tempFile

      comment_block 'tag:ConvenioEstadualAno' $tempFile
      comment_block 'tag:ConvenioFederalAno' $tempFile
      comment_block 'li:AudienciaPublicaNao' $tempFile
      
      replace_tag_content 'tag:AtestadoQuantidade' '50' $tempFile 

      remove_tag 'li:LicitanteCNPJ' $tempFile
      remove_tag 'li:LicitanteEstrangeiro' $tempFile

      remove_tag_with_content 'Tipo0' $tempFile

  fi

    echo '  sublic2: '$sublic2
  if [ $sublic2 = "c" ]
  then
    remove_tag 'li:ComprasServicosTI' $tempFile
    remove_tag 'li:ObrasServicosEngenharia' $tempFile
  elif [ $sublic2 = "t" ]
  then
    remove_tag 'li:ComprasServicos' $tempFile
    remove_tag 'li:ObrasServicosEngenharia' $tempFile
  elif [ $sublic2 = "o" ]
  then
    remove_tag 'li:ComprasServicosTI' $tempFile
    remove_tag 'li:ComprasServicos' $tempFile

    lati=$(generate_min_max_number 10 99)'.'$(generate_min_max_number 1000000 9999999)
    long=$(generate_min_max_number 10 99)'.'$(generate_min_max_number 1000000 9999999)

    replace_tag_content 'tag:Latitude' $lati $tempFile 
    replace_tag_content 'tag:Longitude' $long $tempFile 

  fi

  newFileName=$newFileName'_'$sublic2

}




#################################################################
function sub_lic2 (){
  while true $sublic2 != "sublic2"
  do
  clear
  echo "================================================"
  echo "Opção informada ( $lic )"
  echo "Source XML ( $sourceXML )"
  echo "================================================"
  echo "=============== Opctionais LICITAÇÃO 2 ================"
  echo "      c) ComprasServicos"
  echo "      t) ComprasServicosTI" 
  echo "      o) ObrasServicosEngenharia"
  echo "================================================"

  echo "Digite a opção desejada:"
  read sublic2
  echo "Opção informada ($sublic2)"
  echo "================================================"

  case "$sublic2" in
          c)
            echo "SUB C"
            break
      echo "================================================"
      ;;
          t)
            echo "SUB T"
            break
      echo "================================================"
      ;;
         o)
            echo "SUB O"
            break
      echo "================================================"
      ;;
  *)
      echo "Opção inválida!"
      sleep 1
  esac
  done
}


#################################################################
function sub_menu (){
  while true $sub != "sub"
  do
  clear
  echo "================================================"
  echo "Opção informada ( $lic )"
  echo "Source XML ( $sourceXML )"
  echo "================================================"
  echo "=============== DADOS LICITAÇÃO ================"
  echo "      c) Completa" 
  echo "      m) Minima"
  #echo "      s) Simples"
  echo "================================================"

  echo "Digite a opção desejada:"
  read sub
  echo "Opção informada ($sub)"
  echo "================================================"

  case "$sub" in
          c)
            echo "SUB C"
            break
      echo "================================================"
      ;;
          m)
            echo "SUB M"
            break
      echo "================================================"
      ;;
         s)
            echo "SUB S"
            break
      echo "================================================"
      ;;
  *)
      echo "Opção inválida!"
      sleep 1
  esac
  done
}
#################################################################
function menu (){
  while true $opcao != "opcao"
  do
  clear
  echo "================================================"
  echo "============ GERAR XML DE LICITAÇÃO ============"
  echo "================================================"
  echo "    0) Licitação 0"
  echo "    1) Licitação 1"
  echo "    2) Licitação 2"
  echo "    3) Licitação 3"
  echo "    4) Todas as licitações"
  echo "    9) Sair do programa"
  echo "================================================"
  echo "Digite a opção desejada:"
  read opcao
  echo "Opção informada ($opcao)"
  echo "================================================"

  case "$opcao" in
          0)
            lic='licitacao_0'
            sourceXML='licitacao_base_0.xml'
            #echo "Informe o nome do pacote para ser instalado?"
            #sub_menu
            #read nome
            #gerarArquivo
            break
      echo "================================================"
      ;;
          1)
            lic='licitacao_1'
            sourceXML='licitacao_base_1.xml'
            break
      echo "================================================"
      ;;
         2)
            lic='licitacao_2'
            sourceXML='licitacao_base_2.xml'
            sub_lic2
            break
      echo "================================================"
      ;;
         3)
            lic='licitacao_3'
            sourceXML='licitacao_base_3.xml'
            break
      echo "================================================"
      ;;
         4)
            lic='Todas Licitações'
            echo "Todas"
            break
      echo "================================================"
      ;;
         9)
           echo "SAIR..."
           sleep 1
           clear;
           exit;
      echo "================================================"
      ;;
  *)
      echo "Opção inválida!"
      sleep 1
  esac
  done
  sub_menu
  gerarArquivo
}

menu
