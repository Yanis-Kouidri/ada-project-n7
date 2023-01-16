with Ada.Integer_Text_IO, Ada.Text_IO ;
use Ada.Integer_Text_IO, Ada.Text_IO ;
with Ada.Unchecked_Deallocation ; 

package BODY P_Arbre is 


    -- Instantiation des fonctions et procédures :

    procedure Free is new Ada.Unchecked_Deallocation(T_Fichier, T_Arbre) ;

    procedure Afficher_Ustring (Element : in Unbounded_String) is
    begin
        Put_Line(To_String(Element));
    end Afficher_Ustring;

    procedure Afficher is new P_Liste_Ustring.Pour_Chaque(Traiter => Afficher_Ustring);


    -- Définition des fonctions et procédures :

    Function Decoupage (F_Chaine : in String ; F_Cible : in Character) return P_liste_ustring.T_liste_chainee is
        Premier : Unbounded_String;
        Precedent, Suivant : Integer := 0;
        Resultat : P_Liste_Ustring.T_Liste_Chainee ;

    begin
        Precedent := F_Chaine'First - 1;
        Resultat := Creer_Liste_Vide;
        for I in F_Chaine'Range loop
            if F_Chaine(I) = F_Cible then
                Suivant := I;
                Premier := To_Unbounded_String ((F_Chaine (Precedent + 1 .. Suivant - 1)));
                Inserer_En_Tete (Resultat, Premier);
                Put_Line (To_String (Premier));
                Precedent := Suivant;
            end if;
        end loop;
        return Resultat;

    end Decoupage;


end P_Arbre ;
