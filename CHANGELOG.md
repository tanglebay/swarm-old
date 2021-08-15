## Version 0.6.5 (upcoming version)
### Added
- Added "autopeering" as default plugin
- Added JWT-Auth configuration
- Enabled Watchdog per default via Installer
### Changed
- Fixed multiple text strings
- Fixed SWARM updateParser for autopeering
- Changed maxUnknownPeers from 4 to 2
- Updated SWARM removal
- Updated Watchdog
- Updated Readme file
- Updated About file
### Removed
- Removed SWARM dbPruner
- Removed Tangle Bay Delta Snapshot URL


## Version 0.6.4
- Added config status to swarm configuration
- Removed advanced config from proxy menu
- Removed tmp section for hornet binary/config
- Changed console version output to own file
- Changed parser for unknownPeers
- Fixed missing comnet option


## Version 0.6.3
- Added hornet installation checks
- Fixed potential nginx error
- Fixed output error (hornet configuration)
- Fixed wrong Hornet config


## Version 0.6.2
- Incrased unknown peers to 4 to allow autopeering


## Version 0.6.1
- Added tmp autopeering binary
- Added tmp autopeering configuration
- Added Tangle Bay entry node check
- Added force of SWARM of allowDbReset


## Version 0.6.0
- Added gossipUnknownPeersLimit configuration
- Fixed Hornet installation
- Fixed hornetInstallation
- Fixed pruningDatabaseSize
- Fixed Firewall menu
- Fixed Firewall status
- Fixed p2pIdentity
- Fixed autopeeringPort
- Fixed removal of the proxy
- Fixed all config parser
- Updated SWARM configuration menu
- Updated SWARM Info
- Updated comnet config to offical
- Bug fixes from 0.5.9


## Version 0.5.8
- Fixed autoRevalidation
- Fixed progress bar
- Changed keepDB to allowDbReset


## Version 0.5.7
- Added comnet
- Fixed snapshot urls
- Removed old snapshot interval


## Version 0.5.6
- Added Tangle Bay as snapshot source
- Fixed progress bar


## Version 0.5.5
- Fixed p2pIdentity
- Fixed Hornet installation
- Fixed proxy installation


## Version 0.5.4
- Added gossip menu to hornet configuration
- Added autopeering menu to hornet configuration (disabled)
- Added db revalidation menu to hornet configuration
- Added about menu
- Updated menu structure
- Updated box size for some menus
- Updated p2pIdentity handling
- Updated validation and enabled it per default
- Fixed database size detection
- Fixed dashboard password generation
- Fixed gossip Port
- Fixed validation menu
- Fixed some small bugs