/**
	@creator : [utopia] Amaury
	@creation: 12/08/17
	@description : for a safer world
**/

private _file = param [0,"",[""]];
private _type = param [1,0,[0]]; // -2 = client only , 2 send server only
private _final = param [2,true,[false]];

if (isMultiplayerSolo || !isMultiplayer || {isServer && hasInterface}) exitWith { //switch to normal
	if(_final) then {
		compileFinal preprocessFileLineNumbers _file;
	}else{
		compile preprocessFileLineNumbers _file;
	};
};

private _header = format ["private _thisFileName = '%1';",_file] + 'if !(isRemoteExecuted) exitWith {diag_log format ["%1 needs to be remotly executed",_thisFileName]};';

switch (_type) do { 
	case 2 : {
		_header = _header + 'if (remoteExecutedOwner != 2) exitWith {diag_log format ["%1 cannot be sent by client",_thisFileName]};';
	}; 
	case -2 : {
		_header = _header + 'if (remoteExecutedOwner == 2) exitWith {diag_log format ["%1 cannot be sent by server",_thisFileName]};';
	}; 
};

_header = _header + '_thisFileName = nil;';


if(_final) then {
	compileFinal (_header + preprocessFileLineNumbers _file);
}else{
	compile (_header + preprocessFileLineNumbers _file);
};
