resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'
 
files {
    'vehicles.meta',
    'carvariations.meta',
    'carcols.meta',
    'handling.meta',
	'dlctext.meta',
--	'donkercontentunlocks.meta'
}
 
data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'
data_file 'TEXTFILE_METAFILE' 'dlctext.META'
--data_file 'DONKER_CONTENT_UNLOCKS_FILE''donkercontentunlocks.meta'

 
client_script 'vehicle_names.lua'