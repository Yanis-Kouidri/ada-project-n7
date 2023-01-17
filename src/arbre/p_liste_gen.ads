generic
    type Type_Element is private;
    
package P_Liste_Gen is 

    -- Déclaration des types :
    type T_Cellule is limited private;
    type T_Liste_Chainee is private;

    -- Définiton des procédures et fonctions :

    function Creer_Liste_Vide return T_Liste_Chainee; 

    function Est_vide (List: in T_Liste_Chainee) return Boolean;

    procedure Inserer_En_Tete (List : in out T_Liste_Chainee ; Elem : in Type_Element);
    
    procedure Inserer_En_Queue (List : in out T_Liste_Chainee ; Elem : in Type_Element);

    --procedure afficher (List : in T_Liste_Chainee);
    
    function Rechercher (List : in T_Liste_Chainee ; Elem : in Type_Element) return T_Liste_Chainee;

    procedure Inserer_Apres (List : in T_Liste_Chainee; Data, New_Data : in Type_Element);

    procedure Inserer_Avant (List : in out T_Liste_Chainee; Data, New_Data : in Type_Element);

    procedure Enlever (List : in out T_Liste_Chainee; a_enlever : in Type_Element);

    generic
        with procedure Traiter (Element : in Type_Element);
    procedure Pour_Chaque (List : in T_Liste_Chainee);

    generic
        with procedure Traiter (Element : in Type_Element);
    procedure Pour_Un (List : in T_Liste_Chainee);
    


private
    -- Définition des types :
    type T_Liste_Chainee is access T_Cellule; -- Une Liste chainée  (pointeur sur cellule)

    type T_Cellule is
        record
            Element : Type_Element;
            Suivant : T_Liste_Chainee;
        end record;


end P_Liste_Gen; 
