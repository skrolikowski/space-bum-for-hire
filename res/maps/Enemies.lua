return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.3.1",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 30,
  height = 30,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 5,
  nextobjectid = 10,
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
      width = 30,
      height = 30,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eAG9lQtOwkAQhjfiOYotBfFSYnkYvUVPIpbXsVSeegy/QYZMTCV1WbrJl39Swv6d2ZnuoOHcEEZw6bW9cvkG1jDFbwbzGnzbDZen0AL8He9Ry6KmObXNB4C/4z1qWdQ0p7ZSY/Gv5Ww1sTlnOxPw5T1qW9pbdefLme57q+58Rz9nm2+o8RZiejoB1TZxCqJduIMQizPd91Z6zd6QsW8fVEfEQxB9gmcIsSJybELBfhNQnRLTb24OCwi97vHswZK9V6DKN8xtYAs7CL1e8BxDDIlRvmEuBfrOdSD00nwz9u6DKt+w4z3xeAFfzbdg7wmo8g073hOLC/hG7Cl9tYSV0TWxzlaT872BGGTGWnDubGmdY2YoAdUWsc5WD58HyEBmbADnzpbWWWps0Tka4/EhdUALkFnT386ZMc3Xemp8Q86vB8/4oDJrazh3xv7KV71FxTM7aILaGfOdr4h9pK+sz+9YPAsQ7YOdMV/fU3VWf/Fcgqg8szPm61ulzuKprIjtjPn6VslXPWXGbC/L/eW7quSr9Ra1vezrKf+rkq/1DdHL4vvffEP0sk++IXrZJ1/byzvO+xO+QOOyO6Ts2Rv/eQd7hqdie1906Odb6ILGZXdI2bOI/zThGw0g1cw="
    },
    {
      type = "objectgroup",
      id = 2,
      name = "Units",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 1,
          name = "Executioner",
          type = "",
          shape = "rectangle",
          x = 32,
          y = 80,
          width = 87,
          height = 59,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
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
          x = 0,
          y = 0,
          width = 16,
          height = 144,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 144,
          width = 160,
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
          x = 80,
          y = 160,
          width = 16,
          height = 112,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 256,
          width = 144,
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
          x = 176,
          y = 272,
          width = 16,
          height = 208,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 464,
          width = 272,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 464,
          y = 0,
          width = 16,
          height = 480,
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
          id = 9,
          name = "PlayerEnter",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 192,
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
