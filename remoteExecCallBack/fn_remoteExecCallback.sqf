/*
	@Author 	: AmauryD
	@Description: remoteExec for callback remote function
	@Creation   : 13/06/18
*/

params [
	["_params",[],[[]]], // must be array to append token
	["_function","",[""]],
	"_target",
	["_isPersistent",false,[false]],
	["_isCall",false,[false]],
	["_timeOut",2,[0]]
];

if (!canSuspend) exitWith {
	diag_log "Can't suspend script on this context";
};

private _token = toString [(random 96) + 32,(random 96) + 32,(random 96) + 32,(random 96) + 32,(random 96) + 32,(random 96) + 32];
private _tokenName = format ["rtoken_%1",_token];

_params pushBack _tokenName;

if _isCall then {
	_params remoteExecCall [_function,_target,_isPersistent];
}else{
	_params remoteExec [_function,_target,_isPersistent];
};

private _startTime = diag_tickTime;
private _diff = 0;

waitUntil {
	_diff = diag_tickTime - _startTime;
	!isNil {missionNamespace getVariable _tokenName} OR
	_diff > _timeOut
};

_result = missionNamespace getVariable _tokenName;

missionNamespace setVariable [_tokenName,nil];

if (_diff > _timeOut) then { "NO_RESULT" }else{ _result };
