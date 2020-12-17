#!/bin/bash

################################
# Installation des dépendances #
################################

clear

read -p "Voulez vous installer les dépendences ? [O/N]  " depInstall

case $depInstall in 
	y|Y|o|O) 
		sudo apt-get install pwgen
		echo -e "\n Installation des paquets necessaire terminé \n"
		sleep 2
		clear
	;;
esac

##############################
# Generation du mot de passe #
##############################

#################################
# Nombre de caractères souhaité #
#################################


read -p "Combien de caractères souhaitez vous ? [defaut: 16] " pwLenght

case $pwLenght in
        *)
                if [[ $pwLenght > 0 ]]; then
                        totalPwLenght=$pwLenght
                else
                        totalPwLenght=16
                	echo ""
		fi
        ;;
esac	

####################################
# Nombre de mot de passe à générer #
####################################

read -p "Combien de mot de passe voulez vous générer ? [defaut: 1] " pwGenerate

case $pwGenerate in
	*)
		if [[ $pwGenerate > 0 ]]; then
			totalPwGenerate=$pwGenerate
		else
			totalPwGenerate=1
			sleep 2
			clear
		fi
	;;
esac

echo -e "\nGeneration du mot de passe en cours.. \n"

sleep 1.5

##################################################################################
# Si le nombre total de mot de passe à générer est égal à 1,                     #
# alors mettre la phrase au singulier,                                           #
# sinon afficher la phrase au pluriel avec le nombre de mot de passe à générer.  #
##################################################################################

read -p "Souhaitez vous enregistrer le mot de passe généré dans un fichier ? [O/N] " createPwFile

case $createPwFile in
	y|Y|o|O)
		pwFileName="pwFile"
		read -p "Renseignez le nom du fichier. " pwFileName
		generatedPasswordFile="${pwFileName}.pw"
		if [[ $totalPwGenerate == 1 ]]; then
			echo -e "\nUne copie du mot de passe a été effectuée dans le fichier ${generatedPasswordFile} \n"
		else
			echo -e "\nUne copie des ${totalPwGenerate} mots de passe a été effectuée dans le fichier ${generatedPasswordFile} \n"
		fi
		
		# Creation du fichier de sauvegarde de mot de passe
		touch $generatedPasswordFile

		# Generation du mot de passe avec les paramètres de l'utilisateur
		pwgen $totalPwLenght $totalPwGenerate > $generatedPasswordFile
		sleep 1.5

		if [[ $totalPwGenerate == 1 ]]; then
        		echo -e "Voici le mot de passe qui a été généré : \n"
		else
        		echo -e "Voici les mots de passe qui ont été généré : \n"
		fi

		# Affichage du mot de passe
		cat $generatedPasswordFile
	;;
	*)
		if [[ $totalPwGenerate == 1 ]]; then
                        echo -e "Voici le mot de passe qui a été généré : \n"
                else
                        echo -e "Voici les mots de passe qui ont été généré : \n"
                fi
		
		# Generation et affichage direct du mot de passe généré avec les paramètres de l'utilisateur
		pwgen $totalPwLenght $totalPwGenerate
		sleep 1.5
	;;
esac



sleep 1.5

# Création du fichier de stockage de mot de passe généré.

#pwgen $totalPwLenght $totalPwGenerate > $generatedPasswordFile


##################################################################################
# Si le nombre total de mot de passe à générer est égal à 1,                     #
# alors mettre la phrase au singulier et afficher le mot de passe généré,        #
# sinon afficher la phrase au pluriel et afficher les mots de passe généré.      #
##################################################################################

sleep 1

echo -e "\nGénération du mot de passe terminé \n"
