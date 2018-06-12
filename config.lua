Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- ha denna på du måste ha esx_identity
Config.EnableNonFreemodePeds      = false -- ha denna på om du vill använda på false om du inte vet vad du håller på med eller något åt det hållet
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = false
Config.MaxInService               = -1
Config.Locale = 'en'

Config.SwatStations = {
  SWAT = {
    Blip = {
      Pos     = { x = 110.96, y = -747.57, z = 45.75 },
      Sprite  = 304,
      Display = 4,
      Scale   = 1.2,
      Colour  = 29,
    },

    AuthorizedWeapons = {
			{ name = 'WEAPON_NIGHTSTICK',       price = 0 },
			{ name = 'WEAPON_PISTOL',     price = 500 },
			{ name = 'WEAPON_STUNGUN',          price = 0 },
			{ name = 'WEAPON_FLASHLIGHT',       price = 0 },
			{ name = 'WEAPON_SMG',        price = 3000 },
			{ name = 'WEAPON_SNIPERRIFLE',        price = 15000 },
    },

	AuthorizedVehicles = {
    { name = 'police', label = 'Polis Patrullbil' },
    { name = 'fbi', label = 'CivilBil Buffalo' },
    { name = 'fbi2', label = 'Civil Fbi special bil' },
    { name = 'pbus', label = 'Fängelse Buss' },
	  
	},

    Cloakrooms = {
      {x = 132.67, y = -769.43, z = 241.25}
    },

    Armories = {
      {x = 118.83, y = -729.18, z = 241.01}
    },

    Vehicles = {
      {
        Spawner    = {x = 178.06, y = -725.5, z = 38.01},
        SpawnPoint = {x = 172.77, y = -688.01, z = 33.12},
        Heading    = 155.76
      }
    },

    Helicopters = {
      {
        Spawner    = {x = 466.477, y = -982.819, z = 42.691},
        SpawnPoint = {x = 172.77, y = -688.01, z = 33.12},
        Heading    = 155.76
      }
    },

    VehicleDeleters = {
      {x = 169.08, y = -686.24, z = 32.03},
      {x = 169.08, y = -686.24, z = 32.03},
    },

    BossActions = {
      {x = 120.5, y = -767.99, z = 241.20}
    },
  },
}