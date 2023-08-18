!!!!!!!!
See !test_scripts_go_here.txt for information on how to start using the test_scripts system.
!!!!!!!!

This document has some general tips regarding common problems and syntax.

Some reminders to avoid some common mistakes (will prevent headaches):
• You cannot send params to a timed event (eg. callevent 2.0 shoot_fire FIRE_TARGET ), you must pass the vars via setvard.
• You cannot pass params directly from one event to another (eg. callevent pass_on PARAM1 PARAM2) use the $pass() function when you want to do this, eg:
- callevent pass_on $pass(PARAM1) $pass(PARAM2)
• You cannot pass reserved words directly to an event (eg. "callevent do_retaliate ent_laststruck" must be "callevent do_retaliate $get(ent_laststruck,id)"
- The two rules above are also true of the applyeffect command. (As it's really just an odd callevent, code side.)
• You cannot use string comparisons for reserved words (eg. "if PLAYER_ID equals ent_owner" must be "if PLAYER_ID equals $get(ent_owner,id)"
• Do not confuse your string comparisons and mathematical comparisons. (eg. "if PLAYER_NAME == Joe" will fail, use "if PLAYER_NAME equals Joe")
• Do not use double quotes in functions (eg. $get_quest_data(ent_owner,"some quest") will fail. If need be, use single quotes: $get_quest_data(ent_owner,'some quest')
• When pulling a script var, that the calling script also uses, be sure to put it in single quotes. (eg. $get(ent_laststruck,scriptvar,'SOME_VAR') )
• Media (sounds/models/sprites) in #include'ed scripts must precached by the top script.
• All media used in a summoned script must be precached by the summoning script (including client side fx)
- You can use precachefile <summon_script_name> in game_precache event.
• The 'precache' command works on a different parser. It therefore may be activated inside comments, and may not parse quotes proper.
• Beware if you have two or more vars with the same name of different types (setvard/const/local), weird stuff will happen. (You'll fubar the script's variable array.)
- In developer builds, this creates a conflict error report in the log_msdll.log.
• setvar (different from setvard) is ONLY to be used when you need to initiate a variable in the intiation or game_spawn areas before the script spawns, and only once per variable. Like const'ants, they load regardless of conditional location, difference being that the final instance taking priority, rather than the first.
• In a shared sub, clientside and serverside vars will NOT always match up (often this is due to lag).
• In a shared sub, if you use a server side command, all subsequent client commands are ignored. Contain each with if game.serverside/clientside.
• global vars (setvarg) are server side only, but are available to all server side scripts, and stick between non-crashing map changes.
• $get() statements do not work clientside, only $getcl, which can pull only a very limited number of properties (see scripting_alldocs.txt)
• If you are building a new stronger or weaker monster by using #include of another monster script, use const NPC_BASE_EXP, or it will have the same XP value as the #include'd monster.
• File pipes (|) are NOT string token separators, use semi-colons (;)
• Token strings must be put in quotes, ie. "arms;legs;chest" etc.

• Limit your embeded backwards includes.
For a good example as to why this is important, try to figure how swords_longsword works...
Trace it backwards, and it includes all these files:
swords_longswords
swords_base_twohanded
swords_base_onehanded
axes_base_twohanded	//these axe includes make no sense
axes_base_onehanded
base_melee
base_weapon
base_item
base_item_extras
base_weapon_mods
monstrs/debug
Suffice to say, that's a LOT Of code to sort through to find out if ONE of your damned vars is being changed somewhere in some unexpected way.
Try to consolidate, and keep all your includes, or as many as possible, in the top script - to save time backtracking.

Preferred Conventions:
• Vars should be UPPPER_CASE with at least two parts separated by an underscore. Locals should be prefixed with "L_". Globals should be prefixed with "G_".
• Vars should not match names of any key words, regardless of case (bad programming habbit, also makes hard to read with syntax highlights)
• Events should be lower_case with at least two parts separated by an underscore. (eg. "some_event")
• Only hard code events should start with "game_"
• Base events from the AI intended for use in top scripts are usually prefixed "npc_" those internal to the AI with "npcatk_"

Common Syntax Errors:
Bracket seperators must be on their own, individual lines. ie:
if ( XXX_XXX == YYY_YYY )
{
	callevent do_stuff
}
Also remember SPACES ARE PARSERS, so "if (XXX_XXX==XXX_XXX)" will NOT work, nor will "$get(ent_me, hp )"

Script Optimization:
Save memory:
• If the var is not used outside of the event, use a "local"
• Try to use media that is already precached (see your log_msdll.log for a precache list), critical with items or summons that preload with the game.
• Constants do not save memory, as they are actually fixed variables. Their standard use is to override the same constant in lower scripts and provide macros.
- Constants can sometimes be re-written with const_ovrd, if need be, but only by the topmost script.
Save processing time:
• Keep calleventloops short
• If you need to pull server data that isn't going to change multiple times in a script (such as game.players or game.pvp) - store it in a var once, rather than pulling it repeatedly
- This is especially important when pulling game.cvar.xxx's repeatedly, as it is a relatively CPU consuming process.
• Don't use repeatdelay for events that are conditional, rather, have an event call itself with a delay.

