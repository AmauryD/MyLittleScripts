class CfgMapMarkers {
	/**	
		// Condition évaluées à chaque fois que la méthode fn_updateMarkers est appelée
		exemple
		class markers_minerais { // une class représente un groupe de markers
			// Noms des markers sur la map
			markerName[] = {"mine_1","mine_2"};
			// Ne créer pas des expressions/conditions trop lourdes
			showCondition = "license_civ_patate isEqualTo true && player has pickaxe";  
		};				
		class markers_poisson {
			markerName[] = {"fish_1","fish_2"};
			showCondition = "true";   // toujours visible 
		};
		class markers_drogue {
			markerName[] = {"drug_1","cocaine_2"};
			showCondition = "false";   // jamais visible
		};

		Note : L'éxécution se passe dans l'ordre de la configuration , classe par classe.
		exemple : 
		class markers_poisson {
			markerName[] = {"fish_1","fish_2"};
			showCondition = "true";   // toujours visible 
		};
		class markers_gangRebel {
			markerName[] = {"fish_1","cocaine_2"};
			showCondition = "false";   // jamais visible , la condition des 'markers_poisson' ne s'appliquera pas et 'fish_1' sera caché malgré qu'il soit dans 'markers_poisson'
		};

	**/
	class civ {	// exécuté uniquement sur les civils
		class illegalMarkers {
			markerName[] = {
			"cocaine_1",
	        "heroine_1",
	        "meth_1",
	        "cannabis_1",
	        "heroin_process",
	        "gold_trader",
	        "turle_dealer_1",
	        "marker_28",
	        "weed_process",
	        "turle_dealer",
	        "chop_shop_2",
	        "cocaine_process",
	        "turle_dealer_2",
	        "marker_30",
	        "marker_61",
	        "marker_29",
	        "marker_27",
	        "marker_17",
	        "Dealer_1_4"
	    	};
	    	showCondition = "missionNameSpace getVariable ['licence_civ_gang',false]";
		};

		class bratva {
			// 
			markerName[] = {"cocaine_1", "cocaine_process", "Dealer_1_4"};
			// config encoded , no possible code injection , evaluates expression 
			showCondition = "missionNameSpace getVariable ['licence_civ_bratva',false]"; 
		};
	};
	class west {	//exécuté uniquement sur les blufor/policiers

	};
	class guer {	//exécuté uniquement sur les indépendants/médecins

	};
	class east {	//exécuté uniquement sur les OPFOR/?

	};
};