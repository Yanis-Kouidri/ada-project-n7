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
    function Recup_Arg (F_Chaine : in String ; F_Arg_nb : in Natural) return String is
        Decoup : P_Liste_Ustring.T_Liste_Chainee ; -- Pointeur sur T_Cellule d'une liste chainée d'unbounded string
        Arg : Unbounded_String;
    begin
        Decoup := Decoupage (F_Chaine, ' ');
        Arg := Recuperer_Nb(decoup, F_Arg_Nb);

        return To_String(Arg);

    end Recup_Arg;

----------------------------------------------------------------------


----------------------------------------------------------------------
    function Existe_Fils (F_Fils : in T_Arbre ; F_Nom_Fils : in String) return Boolean is
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


    end Existe_Fils;
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
    

----------------------------------------------------------------------
    procedure Afficher_un_detail (F_Endroit : in T_Arbre) is
    begin
        Put_Perm (F_Endroit.all.Permission);
        Put (F_Endroit.all.Taille, 8);
        Put ("    ");
        Put (To_String (F_Endroit.all.Nom)  );
        new_line;
    end Afficher_un_detail;    
----------------------------------------------------------------------


----------------------------------------------------------------------
    procedure Afficher_detail (F_Endroit : in T_Arbre) is
    begin
        if F_Endroit /= null then
            Afficher_un_detail (F_Endroit);
            Afficher_detail (F_Endroit.all.Frere);
        end if;
    end Afficher_detail;
----------------------------------------------------------------------


----------------------------------------------------------------------
    procedure Afficher_Dos (F_Parent : in T_Arbre) is
        Temp : T_Arbre := null;
    begin
        Afficher_Frere (F_Parent.all.Fils);

    end Afficher_Dos;
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
        if F_Parent.all.Fils = null then
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
    function Descendre (F_Courant : in T_Arbre ; F_Fils : in String) return T_Arbre is
        -- Il faut vérifier que c'est bien un dossier
        Dest : T_Arbre := F_Courant;
    begin
        if Existe_Fils (Dest.all.Fils, F_Fils) then
            Dest := Dest.all.Fils;

            while Dest.all.Nom /= F_Fils loop
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
    procedure Supprimer_Frere (F_Cible : in T_Arbre) is
        Temp : T_Arbre := null;
    begin
        if F_Cible.all.Frere = null then
            Put_Line ("Pas de frère");
        else
            Temp := F_Cible.all.Frere;
            F_Cible.all.Frere := Temp.all.Frere;
            Free (Temp);
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
        while Localisation.all.Frere /= null loop
            Localisation := Localisation.all.Frere;
        end loop;

        -- Ajout du nouveau fichier.
        Localisation.all.Frere := Nouv;

        

    end Copier;
----------------------------------------------------------------------


----------------------------------------------------------------------
    function Est_Dossier_Plein (F_Dos : in T_Arbre) return Boolean is
    begin
        return Est_Dossier (F_Dos) and F_Dos.all.Fils /= null;

    end Est_Dossier_Plein;
----------------------------------------------------------------------


----------------------------------------------------------------------
    procedure Put_Perm (P_Perm : in T_Tab_Perm) is
    begin
        for i in P_Perm'Range loop
            Put (P_Perm(i));
        end loop;

    end Put_Perm;
----------------------------------------------------------------------


----------------------------------------------------------------------
    function Somme_Taille_Dos (F_Dossier : in T_Arbre) return Integer is
    begin

        if F_Dossier = null then
            return 0;
        elsif Est_Dossier (F_Dossier) then
            return Somme_Taille_Dos (F_Dossier.all.Fils) + Somme_Taille_Dos (F_Dossier.all.Frere);
        else
            return F_Dossier.all.Taille + Somme_Taille_Dos (F_Dossier.all.Frere);
        end if;


    end Somme_Taille_Dos;

----------------------------------------------------------------------



end P_Arbre;
