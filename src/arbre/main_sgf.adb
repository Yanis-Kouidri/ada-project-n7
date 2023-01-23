with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with P_Arbre; use P_Arbre;
with P_Commande; use P_Commande;
with P_Liste_gen;

procedure main_sgf is


    -- Déclaration de types
    type T_Commandes is (ls, quit);
    

    -- Déclaration de procédures et fonctions
    
    
    -- Déclaration de variables
    Racine : T_Arbre;
    Commande_brute : Unbounded_String;
    Commande_traitee : P_Arbre.P_Liste_Ustring.T_Liste_Chainee ; 
    Commande_simple : Unbounded_String;
    Quitter : Boolean := False;


begin
    -- Initialisation de l'arbre
    Ajouter(Racine, "/", True, null);

    -- Ajout d'un dossier
    Ajouter_Dans_Dos (Racine, "test_1", True);


--    Commande_traitee := Decoupage(To_String(Commande_brute), ' ');
--    Test_Decoupage (To_String (Commande_brute), ' ');
    

--    Put_Line(To_String(Commande_simple));
    
    while not quitter loop

    -- Récupération de la commande tapée par l'utilisateur :
    Commande_brute := To_Unbounded_String(get_line);

    -- Récupération du premier mot de la commande tapée par l'utilisateur :
    Commande_simple := To_Unbounded_String(Recup_Commande (To_String (Commande_brute)));

        begin    
            case T_Commandes'Value(To_String(Commande_simple)) is 
                when ls => P_ls(Racine);
                when quit => Quitter := true;
            end case;
        exception 
            when Constraint_Error => Put_Line("Commande inconnue");
        end;
    end loop;
    




end main_sgf; 
