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
    function Recup_Arg (F_Chaine : in String ; F_Arg_nb : in Integer) return String is
        Decoup : P_Liste_Ustring.T_Liste_Chainee ; -- Pointeur sur T_Cellule d'une liste chainée d'unbounded string
        Arg : Unbounded_String;
    begin
        Decoup := Decoupage (F_Chaine, ' ');
        Arg := Recuperer_Nb(decoup, F_Arg_Nb);

        return To_String(Arg);

    end Recup_Arg;

----------------------------------------------------------------------

----------------------------------------------------------------------
    function Existe (F_Chemin : in P_Liste_Ustring.T_Liste_Chainee ; F_Entree : in T_Arbre) return Boolean is

        Liste : P_Liste_Ustring.T_Liste_Chainee := F_Chemin;
        Arbre : T_Arbre := F_Entree; -- Le pointeur qui va aller jusqu'à la destination
        Verdict : Boolean := false; -- Est ce que le chemin existe ?

        --A_Trouver : S
    begin
        if Existe_Fils (Arbre, To_String (Recuperer (Liste))) then
           null; 
            -- Existe (Liste.all.Suivant, 
        end if;


        return Verdict;
    end Existe;
----------------------------------------------------------------------

----------------------------------------------------------------------
    function Existe_fils (F_Fils : in T_Arbre ; F_Nom_Fils : in String) return Boolean is
    begin
        if F_Fils /= null then
            if To_String(F_Fils.all.Nom) = F_Nom_Fils then
                return true;
            else
                return Existe_Fils(F_Fils.all.Frere , F_Nom_Fils);
            end if;

        else
            return false;
        end if;


    end Existe_fils;
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
        

----------------------------------------------------------------------
    function Est_Dossier (F_Elem : in T_Arbre) return boolean is
    begin
        return F_Elem.all.Permission(1) = 'd';

    end Est_Dossier;
----------------------------------------------------------------------


----------------------------------------------------------------------
    function Descendre (F_Courant : in T_Arbre ; F_fils : in String) return T_Arbre is
        -- Il faut vérifier que c'est bien un dossier
        Dest : T_Arbre := F_Courant;
    begin
        if Existe_Fils (Dest.all.fils, F_Fils) then
            Dest := Dest.all.fils;

            while Dest.all.Nom /= F_fils loop
                Dest := Dest.all.Frere;
            end loop;
        else
            Dest := null;
            
        end if;
        return Dest;

    end Descendre;
----------------------------------------------------------------------


----------------------------------------------------------------------
    function Monter (F_Courant : in T_Arbre) return T_Arbre is
    begin

        return F_Courant.all.Parent;

    end Monter;
----------------------------------------------------------------------
    
----------------------------------------------------------------------
    procedure Supprimer (F_Cible : in out T_Arbre) is
        Temp : T_Arbre := null;
        
    begin
        -- Cas où l'on veut supprimer le dernier frère de la liste :
        if F_Cible.all.Frere = null then
            Free(F_Cible);
            F_Cible := null;

        -- Cas où ce n'est pas le dernier frère
        else
            Temp := F_Cible;
            F_Cible := F_Cible.all.Frere;
            Free(Temp);
            Temp := null;

        end if;
            

    end Supprimer;
----------------------------------------------------------------------
    

----------------------------------------------------------------------
    procedure Supprimer_Frere (F_Cible : in T_Arbre) is
        Temp : T_Arbre := null;
    begin
        if F_Cible.all.Frere = null then
            Put_Line("Pas de frère");
        else
            Temp := F_Cible.all.Frere;
            F_Cible.all.Frere := Temp.all.Frere;
            Free(Temp);
        end if;

    end Supprimer_Frere;
----------------------------------------------------------------------
    

----------------------------------------------------------------------
    procedure Copier (P_Cible : in T_Arbre ; P_Nom : in String) is
        Nouv : T_Arbre := null;
        Localisation : T_Arbre := P_Cible;
    begin
        -- Création du nouveau fichier
        Nouv := new T_Fichier'( To_Unbounded_String (P_Nom), P_Cible.all.Taille,
                                P_Cible.all.Permission, P_Cible.all.Parent, null, null, P_Cible.all.Contenu); 
        
        -- Déplacement au dernier frère
        while Localisation.all.frere /= null loop
            Localisation := Localisation.all.frere;
        end loop;

        -- Ajout du nouveau fichier.
        Localisation.all.frere := Nouv;

        

    end Copier;
    
----------------------------------------------------------------------
    function Est_Dossier_Plein (F_Dos : in T_Arbre) return Boolean is
    begin
        return Est_Dossier (F_Dos) and F_Dos.all.fils /= null;

    end Est_Dossier_Plein;
----------------------------------------------------------------------
----------------------------------------------------------------------

end P_Arbre ;
