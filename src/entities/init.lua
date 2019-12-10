-- Game Entities
-- Shane Krolikowski
--

-- Shapes
Shapes = {
	rectangle = require 'src.entities.shapes.rectangle',
	polygon   = require 'src.entities.shapes.polygon',
	edge      = require 'src.entities.shapes.edge',
	circle    = require 'src.entities.shapes.circle',
}

-- Behaviors
Behaviors = require 'src.entities.behaviors'

-- Entities
Entities = {
	player   = require 'src.entities.player',
 	platform = require 'src.entities.platform',
}
