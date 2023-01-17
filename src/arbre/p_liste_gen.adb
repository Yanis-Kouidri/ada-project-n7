with Ada.Text_IO; use Ada.Text_IO;
--with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Unchecked_Deallocation ;

package body P_Liste_Gen is 


    LISTE_VIDE_ERROR: exception;
    FIN_ERROR: exception;
    -- Définiton des procédures et fonctions :
    
    procedure Free is new Ada.Unchecked_Deallocation(T_cellule, T_Liste_Chainee) ;  

    function Creer_Liste_Vide return T_Liste_Chainee is
    begin
        return null;
    end Creer_Liste_Vide;

    function Est_Vide (List: in T_Liste_Chainee) return Boolean is
    begin
        return List = null;
    end Est_Vide;


    procedure Inserer_En_Tete (List : in out T_Liste_Chainee ; Elem : in Type_Element) is

        Temp : T_Liste_Chainee;
    begin
        Temp := List;
        List := new T_Cellule;
        List.all.Element := Elem;
        List.all.Suivant := Temp;
    end Inserer_En_Tete;


    procedure Inserer_En_Queue (List : in out T_Liste_Chainee ; Elem : in Type_Element) is
    begin
        if List = null then
            List := new T_Cellule;
            List.all.Element := Elem;
            List.all.Suivant := null;

        elsif List.all.Suivant = null then
            List.all.Suivant := new T_Cellule;
            List.all.Suivant.all.Element := Elem;
            List.all.Suivant.all.Suivant := null;

        else
            Inserer_En_Queue (List.all.Suivant, Elem);
        end if;

    end Inserer_En_Queue;


    function Rechercher (List : in T_Liste_Chainee ; Elem : in Type_Element) return T_Liste_Chainee is
    begin
        if List /= null then
            if Elem = List.all.Element then
                return List;
            else
                return Rechercher (List.all.Suivant, Elem);
            end if;
        else
            return null;
        end if;
    end Rechercher;


    procedure Inserer_Apres(List : in T_Liste_Chainee; Data, New_Data : in Type_Element) is
    begin
        if Est_Vide(List) then
            raise LISTE_VIDE_ERROR ;
        else
            if List.all.Element = Data then
                inserer_en_tete(List.all.Suivant, New_Data);
            elsif Est_Vide(List.all.Suivant) then
                raise FIN_ERROR;
            else
                Inserer_Apres(List.all.Suivant, Data, New_Data);
            end if;
        end if;
    exception
        when LISTE_VIDE_ERROR => Put_Line("Erreur : Liste vide.");
        when FIN_ERROR => Put_Line("Erreur : Element non trouvé, insertion impossible.");
    end Inserer_Apres; 


    procedure Inserer_Avant(List : in out T_Liste_Chainee; Data, New_Data : in Type_Element) is

    begin
        if Est_Vide(List) then
            raise LISTE_VIDE_ERROR ;
        else
            if List.all.Element = Data then
                inserer_en_tete(List, New_Data);
            elsif Est_Vide(List.all.Suivant) then
                raise FIN_ERROR;
            else
                Inserer_Avant(List.all.Suivant, Data, New_Data);
            end if;
        end if;
    exception
        when LISTE_VIDE_ERROR => Put_Line("Erreur : Liste vide.");
        when FIN_ERROR => Put_Line("Erreur : Element non trouvé, insertion impossible.");
    end Inserer_Avant; 


    procedure Enlever(List : in out T_Liste_Chainee; A_Enlever : in Type_Element) is
        Tmp: T_Liste_Chainee; 

    begin
        if Est_Vide(List) then
            raise LISTE_VIDE_ERROR ;
        else
            if List.all.Element = A_Enlever then
                Tmp := List;
                List := List.all.Suivant;
                Free(tmp);
            elsif Est_Vide(List.all.Suivant) then
                raise FIN_ERROR;
            else
                enlever(List.all.Suivant, A_Enlever);
            end if;
        end if;
    exception
        when LISTE_VIDE_ERROR => Put_Line("Erreur : Liste vide.");
        when FIN_ERROR => Put_Line("Erreur : Element non trouvé, suppression impossible.");
    end enlever; 


    procedure Pour_Chaque(List : in T_Liste_Chainee) is
    begin
        if List /= null then
            Traiter(List.all.Element);
            Pour_Chaque(List.all.Suivant);
        else
            New_Line;
            New_Line;
        end if;
    end Pour_Chaque;


    procedure Pour_Un(List : in T_Liste_Chainee) is
    begin
        if List /= null then
            Traiter(List.all.Element);
        else
            New_Line;
            New_Line;
        end if;
    end Pour_Un;


end P_Liste_Gen; 
