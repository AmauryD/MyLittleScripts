class textureConfig {
	class west {
		class backpacks {
			class B_Carryall_oucamo {
				class sac_swat {
					texture = "textures\sac-swat2.jpg";
					condition = "player getVariable['rank', 0] == 9";
				};
				class sac_police {
					texture = "textures\police_backpack.jpg";
					condition = "player getVariable['rank', 0] < 9";
				};

			};
			class B_Bergen_sgg {
				class sac_swat {
					texture = "textures\sac-swat.jpg";
					condition = "player getVariable['rank', 0] == 9";
				};
			};
		};
		class uniforms {
			class U_Rangemaster {
				class tenue_swat {
					texture = "textures\swat.jpg";
					condition = "player getVariable['rank', 0] == 9";
				};
				class tenue_police {
					texture = "textures\cop.jpg";
					condition = "player getVariable['rank', 0] < 9";
				};
			};
			class U_B_CombatUniform_mcam_worn {
				class tenue_swat {
					texture = "textures\swat_shirt.jpg";
					condition = "player getVariable['rank', 0] == 9";
				};
				class tenue_police {
					texture = "textures\police_mcam.jpg";
					condition = "player getVariable['rank', 0] < 9";
				}; 
			};
			class U_C_Poloshirt_blue {
				class tenue_bac {
					texture = "textures\police_bac.jpg";
					condition = "player getVariable['rank', 0] == 8";
				}; 
			};
		};
	};
	class civilian {
		class backpacks {
			
		};
		class uniforms {

		};
	};
	class guer {
		class backpacks {

		};
		class uniforms {

		};
	};	
};