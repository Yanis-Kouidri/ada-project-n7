WITH Ada.Integer_Text_IO, Ada.Text_IO ;
USE Ada.Integer_Text_IO, Ada.Text_IO ;
with Ada.Unchecked_Deallocation ; 

PACKAGE BODY arbre IS

    Procedure free is new Ada.Unchecked_Deallocation(T_fichier, T_arbre) ;

    Function creation(F_chemin, F_nom : in String ; est_dossier : in boolean) return T_arbre is 

        nouv_arbre : T_arbre := null;
    begin



        nouv_arbre := new T_fichier(nom, taille, perm;

        nouv_arbre.all.parent := null;
        nouv_arbre.all.fils := null;
        nouv_arbre.all.frere := null;
        nouv_arbre.all.nom(1) := '/';
        nouv_arbre.all.taille := 10240;
        nouv_arbre.all.permission := "drwxr-xr-x";



        return nouv_arbre;

    end creation;


    Function existe(F_dossier : in String ; arbre : in out T_arbre) return boolean is
    begin

        if arbre.all.nom = F_dossier then
            return true;
        elsif arbre.all.frere /= null then
            return existe(F_dossier, arbre.all.frere);
        else 
            return false;
    end existe; 

    Procedure ajout(arbre : in out T_arbre) is
    begin
        null;
    end ajout;


END arbre ;
