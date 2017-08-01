/**
	@file        : fn_updateMarkers.sqf
	@creator     : [utopia]Amaury
	@created     : 03/07/17
	@description : show/hide a marker on map with a specified condition , see config file for documentation
**/

private _configEntry = missionConfigFile >> "cfgMapMarkers";
private _sideEntry = _configEntry >> str playerSide;

if !(isClass _configEntry) exitWith {
	diag_log "ERROR : cfgMarkers.hpp is not loaded.";
};
if !(isClass _sideEntry) exitWith {
	diag_log format ["WARNING : side class for %1 does not exists.",str playerSide];
};

{
	_markerGroup = getArray (_x >> "MarkerName");
	_condition = getText (_x >> "ShowCondition");
	_canShow = _markerGroup call (compile _condition);

	// some checks 
	if (isNil "_canShow") exitWith { diag_log "ERROR : invalid expression in config file , must return true or false."; };
	if !(_canShow isEqualType true) exitWith { diag_log "ERROR : invalid expression in config file , must return true or false.";  };

	_val = if (_canShow isEqualTo true) then {1}else{0};

	{
		_x setMarkerAlphaLocal _val; // erase local if you want the effect to be global
	}forEach _markerGroup;

}foreach ("true" configClasses _sideEntry);