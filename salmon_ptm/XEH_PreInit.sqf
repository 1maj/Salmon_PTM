#include "\a3\editor_f\Data\Scripts\dikCodes.h"
[
"TacSalmon Pass Mag", 
"salmon_ptm", 
["Pass Magazine", "Press to pass magazine..."], 
{[player, cursorTarget] call fnc_salmon_ptm}, 
{}, 
[DIK, [false,false,false]]
] call cba_fnc_addKeybind;

[
"salmon_ptm_hs",
"LIST",
["Hints", "Chose which ammount of detail you want in feedback messages"],
"TacSalmon Pass Mag",
[[2,1,0, -1], ["High", "Normal", "Minimal", "Disabled"], 1]
] call cba_settings_fnc_init;

fnc_salmon_ptm = {
//Base defines.
private "_message";
_player = _this select 0;
_target = _this select 1;


//Check if target is wtihin 4 metres of player.
if (_player distance _target < 4 && _target isKindOf "man" && !isNull _target) then {
	
	//Get list of magazines available in targets player.
	_magList = getArray (configFile >> "cfgWeapons" >> currentWeapon _target >> "magazines");
	
	//Get list of magazines on player.
	_mags = magazines _player;
	
	//Filter out mags you can't share.
	_remove = _mags - _magList; 
	_mags = _mags - _remove;
	
	//Check if you have any mags in common. 
	if (count _mags > 0) then {
		//Init passing of mag. 
		//Make a list of mags + their ammo count. 
		_finalMagList = [];
		{
			if (_x select 0 in _mags) then {
				_i = _finalMagList pushBack _x;
			};
		} count magazinesAmmo _player;
		
		//Pick the mag you're going to graciously gift to your comrade. 
		_mag = _finalMagList select 0;
		_name = getText (configFile >> "CfgMagazines" >> (_mag select 0) >> "displayName"),

		//Check if target has space for magazine. 
		if (_target canAdd (_mag select 0)) then {
			_target addMagazine _mag;
			_player removeMagazine (_mag select 0);
			if (salmon_ptm_hs >= 0) then {
				_message = ["You gave %1 a %2<br/><br/><img image='%3' size='10'/>", name _target, _name, getText (configFile >> 'cfgMagazines' >> (_mag select 0) >> 'picture')];
			};
		} else {
			if (salmon_ptm_hs >= 1) then {
				_message = ["%1 has no space in his inventory", name _target];
			};
		};
	} else {
		//Fail
		if (salmon_ptm_hs >= 1) then {
			_message = ["You don't have any ammo to spare for %1", name _target];
		};
	};
} else {
	if (salmon_ptm_hs == 2) then {
		_message = ["ERROR: No target found!"];
	};
};
if (count _message > 0) then {
	hint parseText format _message;
};
};