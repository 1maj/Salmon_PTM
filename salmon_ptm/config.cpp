class CfgPatches
{
	class salmon_ptm_main
	{
		author="Green";
		authorUrl="TacSalmon.me";
		name="Salmon Pass The Mag";
		requiredAddons[]=
		{
			"extended_eventhandlers",
			"cba_keybinding",
			"cba_main",
			"cba_main_a3", 
			"cba_settings"
		};
		requiredVersion=1.76;
		units[]={};
		weapons[]={};
	};
};
class Extended_PreInit_EventHandlers
{
	class salmon_ptm
	{
		init="call compile preProcessFileLineNumbers 'Salmon_PTM\XEH_PreInit.sqf'";
	};
};