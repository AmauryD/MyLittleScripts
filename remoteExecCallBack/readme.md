# remoteExecCallBack

Function to get an instant callback on remoteExec functions.

## Examples

*Compile fn_remoteExecCallback.sqf and fn_compileRemoteExecCallback.sqf first with CfgFunctions or normal preprocessFileLineNumbers*

In the examples the functions name will be "fnc_remoteExecCallBack" and "fnc_compileRemoteExecCallBack" but it may change

Let's compile a function on the *SERVER* that adds 2 numbers and return the result

### Using remoteExecCallBack to compile
```sqf
  function_add = ["addition.sqf"] call fnc_remoteExecCallBack;
```
OR
```sqf
  function_add = [
    {
      params ["_num1","_num2"];
      _num1 + _num2 // last value returned
    }
  ] call fnc_remoteExecCallBack;
```

### Using macros_remoteExec file (the function name will be function_add)
```sqf
   #include "macros_remoteExec.h"
   CALLBACK_HEADER
    params ["_num1","_num2"];
    _num1 + _num2 // last value returned
   CALLBACK_FOOTER
```

Now that the functions are compiled and ready you can use them

On the *CLIENT* run this code in a [Scheduled Environment](https://community.bistudio.com/wiki/Scheduler#Scheduled_Environment) :

```sqf
   _result = [
    [5,5],            //add 5 plus 5
    "function_add",   //FUNCTION NAME
    2                 //SERVER ID
  ] call fnc_remoteExecCallBack;

  systemchat str _result; // will display 10
```

The parameters of the remoteExecCallBack function are the same than BIS_FNC_MP plus a '_timeOut' parameter for the callback
