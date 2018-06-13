/**
	@autor : [utopia] Amaury
	@creation : 15/08/17
**/

private _span = param [0,5,[0]];
private _context = param [1,"default",[""]];
private _contextVar = format ["ug_lastAction_%1",_context];

if (diag_tickTime - (missionNameSpace getVariable [_contextVar,diag_tickTime - _span]) >= _span) then { // just because it's compact
	missionNameSpace setVariable [_contextVar,diag_tickTime];
	true;
}else{
	false;
}; 