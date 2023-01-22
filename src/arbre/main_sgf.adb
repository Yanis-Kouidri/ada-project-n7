with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with P_Arbre; use P_Arbre;
with P_Commande; use P_Commande;
with P_Liste_gen;

procedure main_sgf is


    -- Déclaration de types
    

    -- Déclaration de procédures et fonctions
    
    
    -- Déclaration de variables
    Racine : T_Arbre;
    Commande_brute : Unbounded_String;
    Commande_traitee : P_Arbre.P_Liste_Ustring.T_Liste_Chainee ; 
    Commande_simple : Unbounded_String;


begin
    Ajouter(Racine, "/", True, null);

    Ajouter_Dans_Dos (Racine, "test_1", True);

    Commande_brute := To_Unbounded_String(get_line);
    Commande_traitee := Decoupage(To_String(Commande_brute), ' ');
--    Test_Decoupage (To_String (Commande_brute), ' ');
    
    --    Je récupère la commande tapée par l'utilisateur :
    Commande_simple := To_Unbounded_String(Recup_Commande (To_String (Commande_brute)));
    Put_Line(To_String(Commande_simple));
    



    P_ls(Racine);

end main_sgf; 
