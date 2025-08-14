# abdiez_geimport

ESX resource for giving vehicles to players’ garages with `/givecar`. Generates a plate and saves the vehicle to `owned_vehicles`.

## Features
- `/givecar [id] [model]`
- Auto plate generation (ABC123)
- Saves to `owned_vehicles`
- Permission whitelist by license
- English notifications

## Requirements
- ESX (`es_extended`)
- oxmysql or mysql-async
- Resource name must be `abdiez_geimport`

## Installation
1. Place in `resources` as `abdiez_geimport`
2. Add to `server.cfg`:
