return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.3.1",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 40,
  height = 40,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 9,
  nextobjectid = 17,
  properties = {},
  tilesets = {
    {
      name = "strangemountains01",
      firstgid = 1,
      filename = "tiles/strangemountains01.tsx",
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 64,
      image = "tiles/strangemountains01.png",
      imagewidth = 1024,
      imageheight = 1024,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      terrains = {},
      tilecount = 4096,
      tiles = {
        {
          id = 1678,
          objectGroup = {
            type = "objectgroup",
            id = 3,
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            draworder = "index",
            properties = {},
            objects = {
              {
                id = 2,
                name = "",
                type = "",
                shape = "rectangle",
                x = 0,
                y = 0,
                width = 16,
                height = 16,
                rotation = 0,
                visible = true,
                properties = {}
              }
            }
          }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      id = 1,
      name = "Platforms",
      x = 0,
      y = 0,
      width = 40,
      height = 40,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJzt10duAjEUxvEBBSZRpNQzcBN6LxfwZm6SSkm9gDe5RxbpCaln4B75R8piZBnJkRceRe+TfpL9wPDAeMREkUQikfw9i4JbLVRKRbdaqCSWXmy1ULmy9GKrhcrC0outFiql2K32E86N4rep2H/Fd6z4HIrnqiReXjfn0Iw1Nc1jmjWatZrX1rb3TCy92Gqh8p/2N0Syvr9y/fOLnA+/ZP18yP8Xv8j59YucX7/I/vol6/sr12e/yPXZL67nt5yLogqqqKGOBppooY2OMe6m5ma9hz4GGGKUs/fHfee1S22P9fs4wCGOcIwxJphiZoxPUnOzfooznOMCl0v6c80N629xh3s84BFPeMYL5sb4NTU36294xwc+8eXZ30o+igooIsYq1tBEC210sG6pmfMNbGIL29jBbt6vvzLrK6iihjoaGGOCKWa/fZg1c95FD30MMMTIo79v9fZvUQ=="
    },
    {
      type = "objectgroup",
      id = 3,
      name = "Environment",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 32,
          y = 576,
          width = 368,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      id = 7,
      name = "MovingPlatform",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 528,
          width = 128,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["Image"] = ""
          }
        },
        {
          id = 14,
          name = "",
          type = "",
          shape = "rectangle",
          x = 272,
          y = 176,
          width = 128,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      id = 4,
      name = "Events",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 3,
          name = "Move",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 512,
          width = 128,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["Goal.x"] = 544,
            ["Goal.y"] = 136,
            ["Target"] = 11
          }
        },
        {
          id = 15,
          name = "Move",
          type = "",
          shape = "rectangle",
          x = 272,
          y = 160,
          width = 128,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["Goal.x"] = 112,
            ["Goal.y"] = 184,
            ["Target"] = 14
          }
        },
        {
          id = 5,
          name = "PlayerEnter",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 512,
          width = 64,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
