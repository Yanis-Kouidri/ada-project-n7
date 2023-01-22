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
        -- Copie de la chaine de caractère passée en paramètre + ajout du caractère de découpage pour être sur de tout récupérer
        Commande : String := F_Chaine & F_Cible; 
        Element : Unbounded_String; -- Chaque élément de la chaine à découpé
        Debut, Fin : Integer := 0; -- Debut et fin des éléments à découpé
        Resultat : P_Liste_Ustring.T_Liste_Chainee ; -- Pointeur sur T_Cellule d'une liste chainée d'unbounded string

    begin
        
        Debut := Commande'First - 1;
        Resultat := Creer_Liste_Vide;
        for I in Commande'Range loop
            if Commande(I) = F_Cible then
                Fin := I;
                Element := To_Unbounded_String ((Commande (Debut + 1 .. Fin - 1)));
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
    function Recup_Commande (F_Chaine : in String) return String is
        decoup : P_Liste_Ustring.T_Liste_Chainee ; -- Pointeur sur T_Cellule d'une liste chainée d'unbounded string
        commande : Unbounded_String;

    begin
        decoup := Decoupage (F_Chaine, ' ');
        commande := Recuperer(decoup);


        return To_String(commande);
    end Recup_Commande;
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
    procedure Afficher_un (F_Endroit : in T_Arbre) is
    begin
        Put_line (To_String (F_Endroit.all.Nom));
    end Afficher_un;
    
    

----------------------------------------------------------------------
    procedure Afficher_dos (F_Parent : in T_Arbre) is
        Temp : T_Arbre := null;
    begin
        if F_Parent.all.Fils = null then
            Put_Line ("Dossier vide");
        else
            Afficher_Frere(F_Parent.all.Fils);
        end if;


    end Afficher_dos;
----------------------------------------------------------------------


----------------------------------------------------------------------
    procedure Afficher_Frere (F_Frere: in T_Arbre) is
    begin
        if F_Frere /= null then
            Put_Line (To_String (F_Frere.all.Nom));
            Afficher_Frere (F_Frere.all.Frere);
        end if;
    end Afficher_Frere;
----------------------------------------------------------------------


----------------------------------------------------------------------
    procedure Ajouter_Dans_Dos (F_Parent : in T_Arbre ; F_Nom : in String ; F_Est_Dossier : in Boolean) is
        Temp : T_Arbre := null;
    begin
        -- Cas ou on veut ajouter dans un dossier vide :
        if F_Parent.all.fils = null then
            Ajouter (F_Parent.all.Fils, F_Nom, F_Est_Dossier, F_Parent);

        -- Si le dossier n'est pas vide, on parcourt jusqu'à trouver le dernier frère :
        else 
            Temp := F_Parent.all.Fils;
            while Temp.all.Frere /= null loop
                Temp := Temp.all.Frere;
            end loop;

            Ajouter (Temp.all.Frere, F_Nom, F_Est_Dossier, F_Parent);

        end if;

    end Ajouter_Dans_Dos;
----------------------------------------------------------------------
        

end P_Arbre ;
