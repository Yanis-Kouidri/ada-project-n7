WITH Ada.Integer_Text_IO, Ada.Text_IO ;
USE Ada.Integer_Text_IO, Ada.Text_IO ;
with Ada.Unchecked_Deallocation ; 

PACKAGE BODY liste_doublement_chainee IS

    procedure free is new Ada.Unchecked_Deallocation(T_noeud, T_liste) ;

    Function creation return T_liste is
    begin
        return null;
    end creation;


    -- L'ajout se fera à la queue de la liste
    Procedure ajout(liste : in out T_liste ; elem : in Integer) is
        temp : T_liste;
    begin
        
        -- Cas ou la liste est vide :
        if liste = null then
            liste := new T_noeud;
            liste.all.element := elem;
            liste.all.precedent := null;
            liste.all.suivant := null;

        -- Cas ou l'élément à insérer est suppérieur à l'élément courant :
        elsif elem >= liste.all.element then
            -- On parcourt la liste jusqu'à atteindre l'endroit ou l'insérer ou le bout
            while elem > liste.all.element AND liste.all.suivant /= null loop
                liste := liste.all.suivant;
            end loop;
            temp := liste;
            -- L'élément à ajouter est quand meme plus grand que l'élément courant alors on l'ajoute en bout de liste 
            if elem > liste.all.element then
                liste.all.suivant := new T_noeud;
                liste := liste.all.suivant;
                liste.all.element := elem;
                liste.all.precedent := temp;
                liste.all.suivant := null;

            else
                liste := new T_noeud;
                liste.all.element := elem;
                liste.all.precedent := temp.all.precedent;
                liste.all.suivant := temp;
            end if;
        else
            while elem < liste.all.element AND liste.all.precedent /= null loop
                liste := liste.all.precedent;
            end loop;
            temp := liste;

            if elem < liste.all.element then
                liste.all.precedent := new T_noeud;
                liste := liste.all.precedent;
                liste.all.element := elem;
                liste.all.suivant := temp;
                liste.all.precedent := null;

            else
                liste := new T_noeud;
                liste.all.element := elem;
                liste.all.suivant := temp.all.precedent;
                liste.all.precedent := temp;
            end if;

        end if;
    end ajout; 


    Procedure suppression(liste : in out T_liste) is 
        temp : T_liste := liste;
    begin
        if liste /= null then -- Vérification que la liste n'est pas déjà vide

            if liste.all.precedent /= null then -- S'il existe un précédent :
                liste := liste.all.precedent; -- On place la tete de lecture sur l'élément précédent
                liste.all.suivant := liste.all.suivant.all.suivant; -- on branche le précédent sur le suivant
                if liste.all.suivant /= null then
                    liste.all.suivant.all.precedent := liste; -- et on branche le suivant sur la précédent (si possible)
                end if;

            elsif liste.all.suivant /= null then -- S'il existe un suivant :
                liste := liste.all.suivant; -- On place la tete de lecture sur l'élément suivant
                liste.all.precedent := null; -- On se détache de l'élément précédent

            elsif liste.all.precedent = null and liste.all.suivant = null then -- Sinon
                liste := null;
            end if;
            free(temp); -- On n'oublie pas de libérer la mémoire du noeud supprimé
        else
            put_line("Suppression impossible : liste vide");

        end if;
    end suppression;


    Procedure recherche(liste : in out T_liste ; elem : in Integer) is
        entree : T_liste := liste; --noeud courant de la liste au moment de son appel
        trouve : boolean := false;
    begin
        while liste.all.precedent /= null loop -- On remonte à la tête de la liste
            liste := liste.all.precedent;
        end loop;
        while liste /= null and not trouve loop
            if liste.all.element = elem then
                trouve := true;
            else 
                liste := liste.all.suivant;
            end if;
        end loop;

        if not trouve then
            liste := entree;
        end if;

    end recherche;


    Procedure affichage(liste : in T_liste) is
        lecteur : T_liste := liste;
    begin
        while lecteur.all.precedent /= null loop -- On remonte à la tête de la liste
            lecteur := lecteur.all.precedent;
        end loop;

        while lecteur /= null loop -- On parcourt toute la liste jusqu'à la fin
            put(lecteur.all.element);
            lecteur := lecteur.all.suivant;
        end loop;
        new_line;

    end affichage;


END liste_doublement_chainee ;
