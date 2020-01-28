return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.3.1",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 30,
  height = 20,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 26,
  nextobjectid = 255,
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
    },
    {
      name = "strangemountains02",
      firstgid = 4097,
      filename = "tiles/strangemountains02.tsx",
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 64,
      image = "tiles/strangemountains02.png",
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
      tiles = {}
    },
    {
      name = "background",
      firstgid = 8193,
      filename = "tiles/background.tsx",
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 32,
      image = "tiles/background.png",
      imagewidth = 512,
      imageheight = 512,
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
      tilecount = 1024,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      id = 11,
      name = "Castle",
      x = 0,
      y = 0,
      width = 30,
      height = 20,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eAGVlVtuE0EQRS2yE5YwjmM+sxJArADGcZYTEPDNo42T3SDYQpQAn5wj9ZUqoxlBPq6q6tbjVs9M27dPVqvx5CHaJDa/xB3IicxYqks+9ojuHlx06K/BN7ABztSa33YcsJuu9wa7A7dwj8GeniM9p2DAF+50DZ6BO/h7cAPOiI/APRr2K3CvPXF6H2PVdv8/fZ7nVVusgZrO9szmjsCzqfm7+zmruvFjlzj5mnOeeluwA63H+mIE1lsT31hM4yVO3nO4m777Ozuxs7O3Nu/jAG995o74onWbeImTvwRDx3XRrXrxrYumvSK5x9hG3xla9jjzFKidWK5iJA6iU/P/6/tct10zPT73+Jk9Z+dq5LxbtV6uxvrv4fyex4L6PWd2tdMZNecc79eUq7H+K3CJvrMavrgr/kg8xQAnpvrWtQ61jcPFj/1ysjp/SX4AmfOr71F3aeQDe2t9+mKjmXjOvkaX93Hu70byzvQuLc1u5Maet2ZaZ2/6k5/aIzV+R++wH/s509dK/4gvpv3GyWVvzvHg27ImuVjvjWf9gebPrnsg9m45r4E8N305MUwQ3rn6aufMc/Wfeca+4w/UPQXqOdOe7Gafu8i3YuXnYJ311pqP1Q8+oal2bHjt0KF+fPfZlTi89SK7qlvj8LHfmSHuwRXI/8sFfd5jf483wPoaT3UyTzvQK9bAd5i42ufwL3re/1f/g3w3N/RHcySuPdmtaphPnB3UTW+42Ctyb4F31nk+R3OZHT37/wVrrdEGbYYz9xc1U0hW"
    },
    {
      type = "tilelayer",
      id = 6,
      name = "Decoratives (MG)",
      x = 0,
      y = 0,
      width = 30,
      height = 20,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eAHdlE0KglAQgId+L9AxVCjUrlOtVSiqk3QMc9PPSTqGuqoWrfo2gohhD58vaOBDeDzmm2GcJ/JduCMRD3yYwz/FSUM/04HIDOri9eG87q7q2Zrcm0r+Q081i577tx95J3099atmadtvytwyyCvza6qjbb/WUMQGB0xGgC+EyLA3xneExLA3xZdBbthr8Z7Z4Gh411T+jwBfCJFhb4zvCEnJ67JTHviKu6XSb4ovg7zk3eLbwb5DrzVmvuBAEWd8F7h26A3whRCVvHd8D3h26C16LH9ddsoD3/BuFTUs8C5h1eB/A7y2If8="
    },
    {
      type = "tilelayer",
      id = 1,
      name = "Platforms",
      x = 0,
      y = 0,
      width = 30,
      height = 20,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eAG9lW1uwjAMhiPgFNsoZaXiTpv4Lvs41CAScKsNkIB77PGEJf9IaMfKIj2KG+K8cRyHacO5AuYwM/YEexr5TlrOCfK7+OTY4v8G76DtDvsePpvOfcEWduDNnC7fE9iYMfW/tn9irWd4YF/t81479HujkaI5g5MZu1Yv5Ndm7QQ6IFraVuitoc54dW3pB2gNYQRjo3tA8wi3ivcDrQUswRvdDLsHuRmz+63DDsUruS1gfkPdULwr9NawuaDbJg8JpNCFR9Nn2D3IQeYIHYP4bFlb6mhvNKrkdoDvEMag9a291HEBc5A5wsggPlLzUkeCtjpyu2XtBWQt5w9N5zlDT/68aoT6unIr2mO0Utg3nPcQ0tOxstzqvLI+IXfyNlTVzphbx1nLviTmI/ESiy+AdX1sv+Sh9jqiNrzWbEyXO1BaRzHfS+Nas7E5B3Q5m1+1PudZ1jTfoXnce7n7P7ontFPW03dB34PQ2GsFXT1n7lm09dCW//A+2HdA3wZ5E9R+qaApQnrO/oJudEN//EHu9w6o539vop0S8/Ks/Q0uKF5n"
    },
    {
      type = "tilelayer",
      id = 7,
      name = "Foreground",
      x = 0,
      y = 0,
      width = 30,
      height = 20,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eAG11FdSk2EUgOH/0n5v1xWoCUSqrsOuK1Apoes66LACIIHQYR10WIGaRgcfZvLP5NIZv5yZ5/a8KWe+7PUommWOqxm8FkVDDDPCKGOMM8EkIaagV6RU6W7Yu8kW2+ywyx77HBBikjeiqI56ruau/j3u84CHPOIxT3hKiGnX66Cz0n1j71ve8Z4PfOQTn/lCiMnqzTJX6Q7aO8QwI4wyxjgTTBJiCnpFSpXuhr2bbLHNDrvssc8BISbvTgoUKQW6mX/5XAmfP0kd9aQIMembUdRFNz300kc/A7TptNNBJ2lCTM7ueRZYZIllVlglo5Mlfjtygbpluw854pgTTjnjnLxO9dtRDtRN3YqilzTQSBPNtNBKwh1Xvx2pyl3/72+dtruLbnropY9+BmjTqX470oG6ObvnWWCRJZZZYZWMTvXbkQvULdt9yBHHnHDKGefE97Xmv16nHKibuu3/pYFGmmimhVbi+7rQvKQWM6UzzQwZssT39cp3f00t5pfOb/6Qp0B8Xz80f9ao++xOFD3nBQmSxPe1prleo+5XnW98p4124vu60LysUXdKZ5oZMmT5C/z6kSY="
    },
    {
      type = "objectgroup",
      id = 9,
      name = "Environment",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 40,
          name = "",
          type = "",
          shape = "rectangle",
          x = 48,
          y = 272,
          width = 192,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 177,
          name = "",
          type = "",
          shape = "rectangle",
          x = 32,
          y = 16,
          width = 16,
          height = 256,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
