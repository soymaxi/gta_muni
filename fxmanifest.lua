fx_version 'adamant'
game 'gta5'

description 'gta_municipalidad (city hall)'
author 'Maxii - (maxi.06) on Discord'

version '1.0'

lua54 'yes'

-------------------------
-- This script is FREE --
-------------------------

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	
	--'locales/*.lua',
	
	'server/*.lua',
	
	'config.lua',
}

client_scripts {
	'@es_extended/locale.lua',

	--'locales/*.lua',

	'client/*.lua',
	
	'config.lua',
}

shared_scripts {
	'@ox_lib/init.lua',
	'@es_extended/imports.lua',
	'config.lua',
}

dependencies {
	'es_extended',
	--'gta_notify', -- (Optional)
	'ox_lib'
}