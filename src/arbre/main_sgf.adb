with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with P_Arbre; use P_Arbre;
with P_Commande; use P_Commande;
with P_Liste_gen;

procedure main_sgf is


    -- Déclaration de types
    type T_Commandes is (ls, cd, cp, rm, vi, cat, pwd, quit, mkdir, touch);
    

    -- Déclaration de procédures et fonctions
    
    
    -- Déclaration de variables
    -- Liste_Vide_Erreur : exception;

    Racine, Rep_Courant : T_Arbre;
    Commande_Brute : Unbounded_String;
    Commande_Traitee : P_Arbre.P_Liste_Ustring.T_Liste_Chainee ; 
    Commande_Simple : Unbounded_String;
    Quitter : Boolean := False;


begin
    -- Initialisation de l'arbre
    Ajouter(Racine, "", True, null);
    Rep_Courant := Racine;

    -- Ajout d'un dossier
    --Ajouter_Dans_Dos (Racine, "test_1", True);
    --Descendre (Rep_Courant, "test_1");


--    Commande_Traitee := Decoupage(To_String(Commande_Brute), ' ');
--    Test_Decoupage (To_String (Commande_Brute), ' ');
    

--    Put_Line(To_String(Commande_Simple));
    
    while not Quitter loop
        
        Put ("ykouidri@ada-project:");
        P_Pwd (Rep_Courant);
        Put (" > "); -- Le prompt


        -- Récupération de la commande tapée par l'utilisateur :
        Commande_Brute := To_Unbounded_String (Get_Line);

        -- Récupération du premier mot de la commande tapée par l'utilisateur :
        Commande_Simple := To_Unbounded_String (Recup_Commande (To_String (Commande_Brute)));

        begin    
            case T_Commandes'Value (To_String (Commande_Simple)) is 

                when ls => P_ls(Rep_Courant);

                when mkdir => 
                    -- put_line("Nom :");
                    -- put_line (Recup_Arg (To_String (Commande_Brute), 1));
                    
                    P_Mkdir (Rep_Courant, Recup_Arg (To_String (Commande_Brute), 1));

                when touch => P_Touch (Rep_Courant, Recup_Arg (To_String (Commande_Brute), 1));

                when cd => P_Cd (Rep_Courant, Recup_Arg (To_String (Commande_Brute), 1));

                when pwd => 
                    P_Pwd (Rep_Courant);
                    New_Line;
                when rm =>
                    P_Rm(Rep_Courant, Recup_Arg (To_String (Commande_Brute), 1));
                    
                when cp => P_Cp (Rep_Courant, Recup_Arg (To_String (Commande_Brute), 1),
                                              Recup_Arg (To_String (Commande_Brute), 2));

                when vi => P_Vi (Rep_Courant, Recup_Arg (To_String (Commande_Brute), 1));

                when cat => P_Cat (Rep_Courant, Recup_Arg (To_String (Commande_Brute), 1));

                when quit => Quitter := true;

            end case;

        exception 
            when P_Liste_Ustring.Liste_Vide_Erreur => Put_Line ("Argument manquant");
            when Fichier_Inexistant_Erreur => Put_Line ("Le fichier spécifié n'existe pas");
            when Pas_Un_Fichier_Erreur => Put_Line ("Impossible : l'élément spécifié est un dossier");
            when Constraint_Error => Put_Line ("Commande inconnue");
        end;

    end loop;
    

end main_sgf; 
