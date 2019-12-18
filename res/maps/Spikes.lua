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
  nextlayerid = 6,
  nextobjectid = 16,
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
      id = 3,
      name = "Spikes",
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
      data = "eJztzrcRwFAIREEyGpJpTKYxmfZEBxqCn+3OvOAiiAAAAAAAAP5MGTFXS7Vmf4+21Y29Oqoz+3u0q27c1VO92d9v88cPTIgYFw=="
    },
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
      data = "eJzt1Elug0AUhGFk+xYJZoZcyvOQU3kecqjEs7F9jPy7IGRFQHtZJX0Sr1Gr3gJhWYqiKIqiKIqiKIqiKIqimOS9Zlk2mnDgwoOPACEixEhqZl1Ve1rMbXTQRQ99DDDECGN8Gu5XtWfCPMUMcyywxAprbLDFl+F+VXt2zHsccMQJZ1xwRYob7ngY7FimJxu7zncBBy48+AgQIqpX36lsT4wk19dibqODLnroY4AhRi/ar0jP+EnXhLMpZphjgSVWWGPzov2K9GwzXd88/2CHPQ444oQzLrgixQ13PDJz9jx/lj65V7bnrcH/DzaacODCg48AISLESBp/d/J38/N/74r0fOAXWYpudw=="
    },
    {
      type = "objectgroup",
      id = 4,
      name = "Spikes",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 640,
          width = 64,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 640,
          width = 64,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 640,
          width = 64,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 384,
          y = 640,
          width = 64,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      id = 5,
      name = "Environment",
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
          x = 32,
          y = 512,
          width = 160,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 448,
          y = 512,
          width = 160,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 624,
          width = 640,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 528,
          width = 96,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 528,
          width = 96,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      id = 2,
      name = "Events",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 1,
          name = "Move",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 608,
          width = 64,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["Goal.x"] = 224,
            ["Goal.y"] = 616,
            ["Target"] = 3,
            ["delay"] = 2,
            ["delayIn"] = 3,
            ["delayOut"] = 0.25,
            ["pause"] = 2,
            ["tweenOut"] = "in-quad"
          }
        },
        {
          id = 7,
          name = "Move",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 608,
          width = 64,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["Goal.x"] = 288,
            ["Goal.y"] = 616,
            ["Target"] = 4,
            ["delay"] = 2,
            ["delayIn"] = 3,
            ["delayOut"] = 0.25,
            ["pause"] = 2,
            ["tweenOut"] = "in-quad"
          }
        },
        {
          id = 8,
          name = "Move",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 608,
          width = 64,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["Goal.x"] = 352,
            ["Goal.y"] = 616,
            ["Target"] = 5,
            ["delay"] = 2,
            ["delayIn"] = 3,
            ["delayOut"] = 0.25,
            ["pause"] = 2,
            ["tweenOut"] = "in-quad"
          }
        },
        {
          id = 9,
          name = "Move",
          type = "",
          shape = "rectangle",
          x = 384,
          y = 608,
          width = 64,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["Goal.x"] = 416,
            ["Goal.y"] = 616,
            ["Target"] = 6,
            ["delay"] = 2,
            ["delayIn"] = 3,
            ["delayOut"] = 0.25,
            ["pause"] = 2,
            ["tweenOut"] = "in-quad"
          }
        },
        {
          id = 10,
          name = "PlayerEnter",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 448,
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
