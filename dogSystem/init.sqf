waitUntil {
   !isNull player
};

dog_fnc_sprint = {
	params ["_dog","_speed"];

	_vel = velocity _dog;
	_dir = direction _dog;
	_dog setVelocity [
		(_vel select 0) + (sin _dir * _speed), 
		(_vel select 1) + (cos _dir * _speed), 
		(_vel select 2)
	];
};

MISSION_ROOT = call {
    private "_arr";
    _arr = toArray __FILE__;
    _arr resize (count _arr - 8);
    toString _arr
};

dog_fnc_vehicleContainsDrug = {
	params ["_vehicle"];
	private _return = false;

	{
		_itemClassName = "";//M_CONFIG(getText,"VirtualItems",_x select 0,"varName");
		if(_itemClassName in ["crystalmeth","cocaine","heroinu","heroinp","marijuana","cannabis"]) then {
			_return = true;
		};
	}foreach (_vehicle getVariable ["trunk",[]]);

	_return
};

dog_fnc_playSound = {
	params ["_dog","_sound"];
	playSound3D [MISSION_ROOT + _sound, _dog, false, getPosATL _dog, 10, 1, 50]; 
};

dog_fnc_aggressiveBehavior = {
	params ["_dog"];

	private _target = _dog getVariable "dog_target";
	private _distance = _dog distance _target;
	private _pos = getPosATL _target;
	private _currState = _dog getVariable "dog_State";

	switch (true) do { 
		case (_distance >= 2) : { 
			if(_currState != "Dog_Sprint") then {
				_dog playMoveNow "Dog_Sprint";
				_dog setVariable ["dog_State","Dog_Sprint"];
			};
		}; 
		case (_distance < 2) : { 
			if(_currState != "Dog_Run") then {
				_dog playMoveNow "Dog_Run";
				_dog setVariable ["dog_State","Dog_Run"];
			_dog setDir ([_dog, _target] call BIS_fnc_dirTo);
			};
			_target sethit ["legs",1];
			[_dog,"dog_attack.ogg"] call dog_fnc_playSound;
		}; 
	};
	_dog setDestination [_pos, "LEADER DIRECT", true];
};


dog_fnc_passiveBehavior = {
	params ["_dog"];

	private _distance = _dog distance player;
	private _pos = getPosATL player;
	private _currState = _dog getVariable "dog_State";

	switch (true) do { 
		case (_distance >= 10) : { 
			if(_currState != "Dog_Sprint") then {
				_dog playMoveNow "Dog_Sprint";
				_dog setVariable ["dog_State","Dog_Sprint"];
			};
			_dog setDestination [_pos, "LEADER PLANNED", true];
		}; 
		case (_distance >= 5 && _distance < 10) : { 
			if(_currState != "Dog_Run") then {
				_dog playMoveNow "Dog_Run";
				_dog setVariable ["dog_State","Dog_Run"];
			};
			_dog setDestination [_pos, "LEADER PLANNED", true];
	    }; 
		case (_distance >= 2 && _distance < 5) : { 
			if(_currState != "Dog_Walk") then {
				_dog playMoveNow "Dog_Walk";
				_dog setVariable ["dog_State","Dog_Walk"];
			}; 
			_dog setDestination [_pos, "LEADER PLANNED", true];
		};
		case (_distance < 2) : { 
			if(_currState != "Dog_Sit") then {
				_dog playMoveNow "Dog_Sit";
				_dog setVariable ["dog_State","Dog_Sit"];
			}; 
		};
		default {_dog setDestination [_pos, "LEADER PLANNED", true]};
	};
};

dog_fnc_searchBehavior = {
	params ["_dog"];

	private _target = _dog getVariable "dog_target";
	private _distance = _dog distance _target;
	private _pos = getPosATL _target;
	private _currState = _dog getVariable "dog_State";

	switch (true) do { 
		case (_distance >= 5) : { 
			if(_currState != "Dog_Sprint") then {
				_dog playMoveNow "Dog_Walk";
				_dog setVariable ["dog_State","Dog_Walk"];
			};
			_dog setDestination [_pos, "LEADER DIRECT", true];
		}; 
		case (_distance < 5) : { 
			if(_currState != "Dog_Sit") then {
				_dog playMoveNow "Dog_Sit";
				_dog setVariable ["dog_State","Dog_Sit"];
				[_dog,"dog_sniff.ogg"] call dog_fnc_playSound;
				systemChat "Le chien sniffe le véhicule ...";
			}; 
			uiSleep 3;
			if(_target call dog_fnc_vehicleContainsDrug) then {
				[_dog,"dog_detect.ogg"] call dog_fnc_playSound;
				systemChat "Le chien semble avoir détecté quelque chose ...";
			};
			_dog setVariable ["dog_behaviour","passive"];
		};
	};
};


dog_fnc_init = {
	// Spawn dog
	_dog = createAgent ["Fin_random_F", getPos player, [], 5, "CAN_COLLIDE"];

	player addAction ["Attack !",dog_fnc_attackAction];
	player addAction ["Normal",dog_fnc_passiveAction];
	player addAction ["Search !",dog_fnc_searchAction];
	 
	// Disable animal behaviour
	player setVariable ["dog",_dog];

	_dog setVariable ["BIS_fnc_animalBehaviour_disable", true];
	_dog disableAI "FSM";
	_dog setVariable ["dog_State","Dog_Sprint"];
	_dog setVariable ["dog_behaviour","passive"];
	_dog setVariable ["dog_target",player];
	 
	// Following loop
	[_dog] spawn {
		params ["_dog"];
		_dog playMoveNow "Dog_Sprint";

		while {alive _dog} do 
		{
			private _behavior = _dog getVariable "dog_behaviour";
			private _start = diag_tickTime;
			private _target = _dog getVariable "dog_target";

			if(_behavior == "aggressive") then {
				_dog call dog_fnc_aggressiveBehavior;
			};
			if(_behavior == "passive") then {
				_dog call dog_fnc_passiveBehavior;
			};
			if(_behavior == "search") then {
				_dog call dog_fnc_searchBehavior;
			};
			uiSleep 1;
		};
	};

};

dog_fnc_attackAction = {
	_dog = player getVariable "dog";
	if(cursorObject isEqualTo objNull) exitWith {hintSilent "Cible invalide"};
	_dog setVariable ["dog_behaviour","aggressive"];
	_dog setVariable ["dog_target",cursorObject];
};

dog_fnc_passiveAction = {	
	_dog = player getVariable "dog";
	_dog setVariable ["dog_behaviour","passive"];
	_dog setVariable ["dog_target",objNull];
};

dog_fnc_searchAction = {
	_dog = player getVariable "dog";
	if(cursorObject isEqualTo objNull || (cursorObject isKindOf "Man")) exitWith {hintSilent "Cible invalide"};
	_dog setVariable ["dog_behaviour","search"];
	_dog setVariable ["dog_target",cursorObject];
};



