with Ada.Integer_Text_IO, Ada.Text_IO ;
use Ada.Integer_Text_IO, Ada.Text_IO ;
with Ada.Unchecked_Deallocation ; 

package body P_Arbre is 


    -- Instantiation des fonctions et procédures :

    procedure Free is new Ada.Unchecked_Deallocation(T_Fichier, T_Arbre) ; -- Pour libérer de la mémoire

    procedure Afficher_Ustring (Element : in Unbounded_String) is -- Pour afficher un liste de unbounded string
    begin
        Put_Line (To_String (Element));
    end Afficher_Ustring;

    procedure Afficher is new P_Liste_Ustring.Pour_Chaque(Traiter => Afficher_Ustring);



    -- Définition des fonctions et procédures :

----------------------------------------------------------------------
    function Decoupage (F_Chaine : in String ; F_Cible : in Character) return P_Liste_Ustring.T_Liste_Chainee is
        Element : Unbounded_String; -- Chaque élément de la chaine à découpé
        Debut, Fin : Integer := 0; -- Debut et fin des éléments à découpé
        Resultat : P_Liste_Ustring.T_Liste_Chainee ; -- Pointeur sur T_Cellule d'une liste chainée d'unbounded string

    begin
        Debut := F_Chaine'First - 1;
        Resultat := Creer_Liste_Vide;
        for I in F_Chaine'Range loop
            if F_Chaine(I) = F_Cible then
                Fin := I;
                Element := To_Unbounded_String ((F_Chaine (Debut + 1 .. Fin - 1)));
                Inserer_En_Queue (Resultat, Element);
                Debut := Fin;
            end if;
        end loop;
        
        return Resultat;

    end Decoupage;
----------------------------------------------------------------------


----------------------------------------------------------------------
    procedure Test_Decoupage (F_Chaine : in String ; F_Cible : in Character) is
        Ma_Liste : P_Liste_Ustring.T_Liste_Chainee ;

    begin
        Ma_Liste := Decoupage(F_Chaine, F_Cible); 
        Afficher (Ma_Liste);
    end Test_Decoupage;
----------------------------------------------------------------------


----------------------------------------------------------------------
    function Existe (F_Chemin : in P_Liste_Ustring.T_Liste_Chainee ; F_Entree : in T_Arbre) return Boolean is
        Liste : P_Liste_Ustring.T_Liste_Chainee := F_Chemin;
        Arbre : T_Arbre := F_Entree;
        Verdict : Boolean := false; -- Est ce que le chemin existe ?
    begin
        -- TODO
        return Verdict;
    end Existe;
----------------------------------------------------------------------


----------------------------------------------------------------------
    procedure Ajouter (F_Endroit : in out T_Arbre ; F_Nom : in String ; F_Est_Dossier : in Boolean ; F_Parent : in T_Arbre) is
        Taille : Integer := 0;
        Permission : T_Tab_Perm;
    begin
        if F_Est_Dossier then
            Taille := 10240; -- 10 ko
            Permission := "drwxr-xr-x";
        else
            Taille := 0;
            Permission := "-rw-rw-r--";
        end if;
        F_Endroit := new T_Fichier'(To_Unbounded_String(F_Nom), Taille, Permission, F_Parent, null, null, Null_Unbounded_String); 


    end Ajouter;
----------------------------------------------------------------------
    

----------------------------------------------------------------------
    procedure Afficher_dos (F_Endroit : in T_Arbre) is
    begin
        Put_Line(To_String(F_Endroit.all.Nom));
        if F_Endroit.all.Frere /= null then
            Afficher_dos (F_Endroit.all.Frere);
        else
            new_line;
        end if;

    end Afficher_dos;
----------------------------------------------------------------------


----------------------------------------------------------------------
    procedure Ajouter_Dans_Dos (F_Endroit : in out T_Arbre ; F_Nom : in String ; F_Est_Dossier : in Boolean ; F_Parent : in T_Arbre) is
    begin
        if F_Endroit.all.Frere /= null then
            Ajouter_Dans_Dos (F_Endroit.all.Frere, F_Nom, F_Est_Dossier, F_Parent);
        else
            ajouter(F_Endroit, F_Nom, F_Est_Dossier, F_Parent);
        end if;

    end Ajouter_Dans_Dos;
----------------------------------------------------------------------
        

end P_Arbre ;
