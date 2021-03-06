
# Configuration File

The configuration file is the easiest way to begin configuring MSA to your liking. The configuration file os a JSON
file. JSON stands for JavaScript Object Notation, and is a common way of storing structured data. As tutorials on 
how to write JSON are easily found, we will avoid going into specifics with how json works here. The most you need to 
know is that JSON is a series of key -> value associations.

This guide will refer to various nested configuration values in the config file, in order to easily reference a given 
JSON value we will use the following naming scheme: `agent.name` to refer to the `"Masa-chan"` value of 
`{"agent": { "name": "Masa-Chan" }}` easily.
 
## Configuration Values
 
### Agent
The agent section configures the behavior and appearance of the agent.

#### agent.name
The name MSA will refer to itself as.

Example:
```json
{
  "agent": {
    "name": "Your humble servant" 
  }
}
```

#### agent.user_title
The name MSA will refer to the user as.

Example:
```json
{
  "agent": {
    "user_title": "Supreme Leader" 
  }
}
```

### Plugin Modules
The plugin modules section, allows a user to configure which third-party plugins to load when MSA starts. It should 
be a list of plugin modules to load at startup. 

Example:
```json
{
  "plugin_modules": [
    "my_demo_plugin"
  ]
}
```
 

### Module Config
The module config section is a mapping of module name to JSON object. The JSON object is configuration
values that will be passed to the module to modify its behavior.

Example:
```json
{
  "module_config": {
    "my_demo_plugin": { 
      "my_demo_message": "hello world"
    }
  }
}
```

### Logging
The logging section, allows you to configure how MSA will record information about how well it is running,
It will also record any errors that are encountered.

#### logging.global_log_level
Sets the global log level. Must be one of "error", "warn", "info", or "debug". The global
log level defines how verbose all modules will be with their logging.

Example:
```json
{
  "logging": { 
    "global_log_level": "info"
  }
}
```

#### logging.log_file_location
The file that the logging output is written to.
Example:
```json
{
  "logging": { 
    "log_file_location": "my_custom_file.log"
  }
}
```


#### logging.truncate_log_file
Toggles overwriting or truncating the log file when MSA starts up. If `false` log files will be preserved between runs.
Example:
```json
{
  "logging": { 
    "truncate_log_file": false
  }
}
```


#### logging.granular_log_levels
A module to log level mapping that overrides the `logging.global_log_level` setting for that module. This can be used to 
increase logging or suppress a module that is logging too much unneeded information. Log level values must be one of 
"error", "warn", "info", or "debug". 

Example:
```json
{
  "logging": { 
    "granular_log_levels": [
      { "namespace": "echo", "log_level": "debug"},
      { "namespace": "command_registry", "log_level": "error"} 
    ]
  }
}
```

## Example configuration
```json
{
   "agent": {
       "name": "Masa-chan",
       "user_title": "Onee-chan"
   },
  "plugin_modules": [

  ],

  "module_config": {

  },

  "logging": {
    "global_log_level": "info",
    "log_file_location": "msa.log",
    "truncate_log_file": false,
    "granular_log_levels": [
      { "namespace": "echo", "log_level": "debug"},
      { "namespace": "command_registry", "log_level": "error"}
    ]
  }
}
```


