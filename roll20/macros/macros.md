# Image
[Image](?{URL}#.png)

# Initiative
%{selected|npc_init}

# Actions
%{selected|repeating_npcaction_$0_npc_action}
%{selected|repeating_npcaction_$1_npc_action}
%{selected|repeating_npcaction_$2_npc_action}
%{selected|repeating_npcaction_$3_npc_action}

# Attributes
/w gm &{template:npcaction} {{name=@{selected|npc_name}}} {{rname=@{selected|repeating_npctrait_$0_name}}} {{description=@{selected|repeating_npctrait_$0_description}}}
/w gm &{template:npcaction} {{name=@{selected|npc_name}}} {{rname=@{selected|repeating_npctrait_$1_name}}} {{description=@{selected|repeating_npctrait_$1_description}}}
/w gm &{template:npcaction} {{name=@{selected|npc_name}}} {{rname=@{selected|repeating_npctrait_$2_name}}} {{description=@{selected|repeating_npctrait_$2_description}}}
/w gm &{template:npcaction} {{name=@{selected|npc_name}}} {{rname=@{selected|repeating_npctrait_$3_name}}} {{description=@{selected|repeating_npctrait_$3_description}}}

# Reactions
/w gm &{template:npcaction} {{name=@{selected|npc_name}}} {{rname=@{selected|repeating_npcreaction_$0_name}}} {{description=@{selected|repeating_npcreaction_$0_description} }}
/w gm &{template:npcaction} {{name=@{selected|npc_name}}} {{rname=@{selected|repeating_npcreaction_$1_name}}} {{description=@{selected|repeating_npcreaction_$1_description} }}
/w gm &{template:npcaction} {{name=@{selected|npc_name}}} {{rname=@{selected|repeating_npcreaction_$2_name}}} {{description=@{selected|repeating_npcreaction_$2_description} }}

# Saving Throws
/w gm &{template:default} {{name=Saving Throws
}} {{STR= [[ 1d20 + [[@{selected|strength_mod} * {1@{selected|npc_str_save}0, 0}=10 + 0@{selected|npc_str_save}]] ]] | [[ 1d20 + [[@{selected|strength_mod} * {1@{selected|npc_str_save}0, 0}=10 + 0@{selected|npc_str_save}]] ]]
}} {{DEX= [[ 1d20 + [[@{selected|dexterity_mod} * {1@{selected|npc_dex_save}0, 0}=10 + 0@{selected|npc_dex_save}]] ]] | [[ 1d20 + [[@{selected|dexterity_mod} * {1@{selected|npc_dex_save}0, 0}=10 + 0@{selected|npc_dex_save}]] ]]
}} {{CON= [[ 1d20 + [[@{selected|constitution_mod} * {1@{selected|npc_con_save}0, 0}=10 + 0@{selected|npc_con_save}]] ]] | [[ 1d20 + [[@{selected|constitution_mod} * {1@{selected|npc_con_save}0, 0}=10 + 0@{selected|npc_con_save}]] ]]
}} {{INT= [[ 1d20 + [[@{selected|intelligence_mod} * {1@{selected|npc_int_save}0, 0}=10 + 0@{selected|npc_int_save}]] ]] | [[ 1d20 + [[@{selected|intelligence_mod} * {1@{selected|npc_int_save}0, 0}=10 + 0@{selected|npc_int_save}]] ]]
}} {{WIS= [[ 1d20 + [[@{selected|wisdom_mod} * {1@{selected|npc_wis_save}0, 0}=10 + 0@{selected|npc_wis_save}]] ]] | [[ 1d20 + [[@{selected|wisdom_mod} * {1@{selected|npc_wis_save}0, 0}=10 + 0@{selected|npc_wis_save}]] ]]
}} {{CHA= [[ 1d20 + [[@{selected|charisma_mod} * {1@{selected|npc_cha_save}0, 0}=10 + 0@{selected|npc_cha_save}]] ]] | [[ 1d20 + [[@{selected|charisma_mod} * {1@{selected|npc_cha_save}0, 0}=10 + 0@{selected|npc_cha_save}]] ]]
}}

# Stats
/w gm &{template:default} {{name=Rolling Stats}} {{AC= @{selected|npc_AC} (@{selected|npc_actype})}} {{HP= [[@{selected|npc_hpformula}]] ... @{selected|npc_hpformula}}} {{SP= @{selected|npc_speed}}} {{+=@{selected|npc_senses}}}

# Group Saving Throws + Damage
!group-check {{
--?{Save|Dexterity|Constitution|Wisdom} Save
--process
--subheader vs DC ?{DC}
--button ApplyDamage !apply-damage
~dmg [[?{Damage}]]
~type ?{Damage on Save|Half,half|None,none}
~DC ?{DC}
~saves RESULTS(,)
~ids IDS(,)
}}