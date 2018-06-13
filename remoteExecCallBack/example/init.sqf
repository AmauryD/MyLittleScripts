// compile these function with any method you want but you need to compile callback functions with ug_fnc_remoteExecCallback OR include the callback_macro
ug_fnc_compileRemoteCallback = compileFinal preprocessFileLineNumbers "fn_compileRemoteCallback.sqf";
ug_fnc_remoteExecCallback = compileFinal preprocessFileLineNumbers "fn_remoteExecCallback.sqf";

if (isServer) then {
	ug_fnc_add = [
		{
			params ["_nb1","_nb2"];

			_nb1 + _nb2;
		}
	] call ug_fnc_compileRemoteCallback;
};

if (clientOwner != 2) then {
	_result = [[1,2],"ug_fnc_add",2] call ug_fnc_remoteExecCallback;
	hint str _result;
};