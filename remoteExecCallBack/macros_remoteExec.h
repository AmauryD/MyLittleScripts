#define CALLBACK_HEADER private _token = param [(count _this - 1),""token_null"",[""""]]; private _result = _this call %1
#define CALLBACK_FOOTER if (_token != ""token_null"") then {missionNamespace setVariable [_token,_result,remoteExecutedOwner];}
