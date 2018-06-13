/*
	@Author 	: AmauryD
	@Description: compile a file for remoteExexCallBack function
	@Creation   : 13/06/18
*/

params [
	["_path","",["",{}]]
];

private _documentFormat = "
	private _token = param [(count _this - 1),""token_null"",[""""]];
	private _result = _this call %1;

	if (_token != ""token_null"") then {
		missionNamespace setVariable [_token,_result,remoteExecutedOwner];
	};
";

if (_path isEqualType {}) then {
	compileFinal format [_documentFormat,_path];
}else{
	compileFinal format [_documentFormat,format["{%1}",preprocessFileLineNumbers _path]];
};
