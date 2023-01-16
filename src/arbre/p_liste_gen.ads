generic
    type Type_element is private;
    
PACKAGE P_liste_gen IS

    -- Déclaration des types :
    Type T_cellule is limited private;
    Type T_liste_chainee is private;

    -- Définiton des procédures et fonctions :

    function creer_liste_vide return T_liste_chainee; 

    function est_vide(list: in T_liste_chainee) return boolean;

    procedure inserer_en_tete(list : in out T_liste_chainee ; elem : in Type_element);

    --procedure afficher(list : in T_liste_chainee);
    
    function rechercher(list : in T_liste_chainee ; elem : in Type_element) return T_liste_chainee;

    procedure inserer_apres(list : in T_liste_chainee; data, new_data : in Type_element);

    procedure inserer_avant(list : in out T_liste_chainee; data, new_data : in Type_element);

    procedure enlever(list : in out T_liste_chainee; a_enlever : in Type_element);

    generic
        with procedure traiter (element : in Type_element);
    procedure pour_chaque (list : in T_liste_chainee);

    generic
        with procedure traiter (element : in Type_element);
    procedure pour_un (list : in T_liste_chainee);
    


private
    -- Définition des types :
    Type T_liste_chainee is access T_cellule; -- Une liste chainée (pointeur sur cellule)

    Type T_cellule is
        Record
            Element : Type_element;
            Suivant : T_liste_chainee;
        End Record;


END P_liste_gen; 
