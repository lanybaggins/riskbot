const { REST, Routes } = require('discord.js');
const { IntentsBitField } = require('discord.js');
const { Client } = require('discord.js');
const { clientId, guilds, token } = require('./riskbot_config.json');
const fs = require('node:fs');
const path = require('node:path');

const rest = new REST({ version: '10' }).setToken(token);
guildId = "1342301791664078870";

rest
	.put(Routes.applicationGuildCommands(clientId, guildId), { body: [] })
	.then(() => console.log('Successfully deleted all guild commands.'))
	.catch(console.error);
// for global commands
rest
	.put(Routes.applicationCommands(clientId), { body: [] })
	.then(() => console.log('Successfully deleted all application commands.'))
	.catch(console.error);
