private _playerBackBackEntry = missionConfigFile >> "textureConfig" >> str playerSide >> "backpacks" >> backpack player;
private _playerUniformEntry = missionConfigFile >> "textureConfig" >> str playerSide >> "uniforms" >> uniform player;

if (isClass _playerBackBackEntry) then {
	{
		private _condition = getText (_x >> "condition");
		private _texture = getText (_x >> "texture");
		private _backpackObject = backpackContainer player;

		if(_texture in getObjectTextures _backpackObject) exitWith {};

		if(_backpackObject call compile _condition) then {
			_backpackObject setObjectTextureGlobal [0,_texture];
		};
	}foreach ("true" configClasses _playerBackBackEntry);
};
if (isClass _playerUniformEntry) then {
	{
		private _condition = getText (_x >> "condition");
		private _texture = getText (_x >> "texture");

		if(_texture in getObjectTextures player) exitWith {};

		if(player call compile _condition) then {
			player setObjectTextureGlobal [0,_texture];
		};
	}foreach ("true" configClasses _playerUniformEntry);
};