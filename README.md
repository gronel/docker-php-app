Good luck!!!!!


## Debug config
    {
        "name": "Listen for XDebug on Docker App",
        "type": "php",
        "request": "launch",
        "port": 9999,
        "pathMappings": {
            "/var/www/html": "${workspaceFolder}"
            },
        "hostname": "timeless-dev-mbms", // change DNS name as needed
        "xdebugSettings": {
        "max_data": 65535,
        "show_hidden": 1,
        "max_children": 100,
        "max_depth": 5
        }
        }