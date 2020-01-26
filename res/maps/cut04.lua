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
  nextlayerid = 17,
  nextobjectid = 134,
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
      id = 2,
      name = "Background",
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
      data = "eAHt07VvVWEAxuGb8Kcw4FrcOiHFpRQrdMIpLhdnwYq7FJmgOC0uLUxIcXcZSItTpEjxp0OTL3e/N4R0eHLOu3y/ky850SqROdEY1apGItWpQU1qUZs61KUe9WlAQ5JoRGOa0JRmNKcFLWlFa9qQTNhsa7ejPR1IoSOd6EwXutKN7vSgJ71IpTdp9KEv/ejPANIZyCAyCLuD7SEMZRjDGcFIRpHJaMYwlnGMZwITmcRkphBlKtOYzgxmMovZhN259jzms4CFZLGIxSxhKctYzgpWsorVrGEt61jPBjaSzSY2s4WthN1t9nZy2MFOdrGbPexlH/vJJY8DHOQQhznCUY5xnBOcJJ8CTnGasHvGPss5zlPIBS5yictc4SrXuM4NbnKL29zhLve4zwMe8ojHPOEpYbfILuY5L3jJK17zhre8o4T3fOAjnyjlM1/4yjfK+M4PfvKL3/wh7D6zE+Vf6SbqO8JO7Hs87zy2VbHj2Sw/u6JT/ox3Kzy/spuYf7jynv/ve/4L3mooxQ=="
    },
    {
      type = "tilelayer",
      id = 8,
      name = "Sharp Cliffs",
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
      data = "eAHt1EdOW2EUgNE3Cb2ZYicT6loSwKa3TAIYWEtCNx1Goa4lFBsInVGoG8mxMFLEIHJMlFGudOTy9O6n91tyEPx+1mqC+DWRcBD/yBrXRCI+s8ZURRBMM8MsCV47q5pXhLUGWOWKsN4AqyR1UhxyxDGvnRXNS2q0+lnhkhq9flYoCgVBMSWUUkauc1rzdOey5gXVWn0sc0G1Xh/LRHVitNFOByWVuZVD4af7ljTPqdLqZYlzqvR6WWJKZ5oZZknQlmO3O9Nd1DyjUquHRc6o1OthkaROikOOOCbX7oJuQm8BZx5PP/1eJAj2OdUN6XWzQJFnKyZ9tqWUkWv36ZSDYF7zJNPNfxsEBZzoVuh1MU9U51exTLfTte6q5025vzZrzml+p9zO9N45yl7oyFxLX+/SzbW962yfz/jA+yQpxu2cYJJPGYNeh1hng0222GaHP5k8z/l8xoXeR4mxZ88+B6S7z81094Zb7rjngUeynW/276Yb7JMkxTT51X5vCnn5vLW+q6OeBhppItt58y4I8singCJKKKeCEK32RYnRxiBDDBNnhFHGyHbe2/uBZlqI0kEnXXQzad8U08zwlXU22GSLbXbIdj7b+4VxJpgiwRzzLHBgX5IUh/zghlvuuOeBR3KddPflFPovL6KYEkqppY56Gmikib81LXa1EiVGG+0MMUycEUYZ4//82xP4CdMXrUU="
    },
    {
      type = "tilelayer",
      id = 6,
      name = "Decoratives (BG)",
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
      data = "eAHtkMcNxDAQA/24s8tRaEyhMYfGFCowCyCB/dzrJICfIZcL7batty6wLvBPF5gf/tsG3qEhfD5lp/HLsw7cQ0H4fMpOq+hN4Bkqwrdv4MlH9J7gF3QLn7fZ6RS9DbxDQ/j2DTwZd84duIeC8PmUnVbRm8AzVIRv38CTj+g9wS/oFj5vs9Mpeht4h4bw7Rt4Mh6cO3APBeHzKTutojeBZ6gI377hd8kXeMIZTw=="
    },
    {
      type = "tilelayer",
      id = 4,
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
      data = "eAG9lclOAlEQRSuNfojTVhOEVlQSfsVpC8QIzomfIg5bYSE4J/yK+gdGcE48t+UlxrjsspLDe9106nbVLR7ZjFkWRqAX2UEbatDKWLcJp7DAd0VIM9bINzlkNgV99DpQhyp6FSjDLs/sOeiW0axAg9zTcAlvkdk7hLhNWVc9/s1VxkrXcAPSRTNZtU8z1GtpaxXb6OwA/S3R34Q09UKuHD3OQwzSnUNrHpinUnFAeDbNdR29GtQHuq/4Gvz9YP8Zpd/nR/KeodeGzkC38F2zUbNRs0vI1yf0etCHQ663AI8Nj91CfuaG8RdiUOh3VI1svwLJjX/6KND7FppNR12dFZyPOqvsGXR9x8p55VqrzuU8xDADuhbLsAJesUjuwNKP/RH7YzgBj2iQN6BZ1juc0+cxVtW7Ch7Bf49twCbco6F3kM/qs2e9mifVdwGjaIUZk+44TIBHaJ5U3wvI3zBj8tezz/JTczwLwV/dewBPXXn6F6rX098v/81pIQ=="
    },
    {
      type = "tilelayer",
      id = 1,
      name = "Cliffs",
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
      data = "eAG91slSwkAQxvExkpDFku2NzCGJHlCfiBubTyVqErVk8YX8d+lYYSoHDh2m+NVkgf7ogUCM0RlZz5gcBWrv1yWlXV+c30J71NS0WSnFXde+MQNoj4iaNsvmN+cn3tdUObdkfavGGtt8d5ZszdGnsRARJIuplXZuRlCOAjF9J0jJdnFadRwuzGyPHbaweZLj0gwee2Y2whADrOlX8mx+c9bI9YLjKm19d9HvjZPr9i19Sq52v8fdGvPIGj/gHlPkXK8Fmj27r9Hc9/l8A2Rk2uxbtu/Q5ShpMOQ3IkKMBLbnLnOl9pygBZZI2be6zpWeK9Tg8a/rXKlv1zpl2zpHbnOtV399nyN3wfdpiRXWOPV/4ZnnbrDDHgd84wWveEOJCm3H5LjcD7zjA584ZXhyzWOIEcaYoAcfAfoI0XZMjsv9QIwEV/gBfu5GOw=="
    },
    {
      type = "tilelayer",
      id = 3,
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
      data = "eAHtkLERgCAQBEnUSujDZky0LhOtiz785Oc2NbgheRJ2HrgdrrX/61j1hqyph254yR6bUge8ZN3wUN+US9bUQ+yW7LEptaNnsm54KFx7JpNz5trpIrt8mTsW/Zec57VXA9VANTCjgTOk1wTxE87X4P0A5vAMMQ=="
    },
    {
      type = "tilelayer",
      id = 5,
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
      data = "eAHt1MkNwjAQheERoQ3CzhXaYKcB9sAVSuDKTgXQGWmF3xJXYqGRDQeP9F1sOS+e2BEJleb89yCORIrwXRMypz/IvZP5+JDbpgkddNFDHwMMMYKmsvq858EHHHHCGRdccYOm/rHPmv3Y1mZ9X9tazbzP3AL/CaOEJ2c5RSuSXROaPdjWjsmbvcV5/hvYkrlxnGt7rzAfOvBtByqc4ypqMPeoDDNWRwOuasGzl0hg7tIcZmyFNVzVC5YWGeU="
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
      data = "eAHtlDsOg0AMBd2HXIcQQsGp+B0gR+IXao6UBEiRcUFLtetteNIIJNCOvE+yiH2ekb1TjXMgb5hpT+t5A25vIL1K/oAM3J58fNoaSb7BD47/dPt1xPeCydi7T9Fd9jfb5yeQ9+Z5PxfMVUIFNTSgKT17WzzaZQ8DjKDpPHvfeLTLLyywgkVi5tIuE7hDChYp8GiXFdTQgEVaPNplDwOwN4S9IewN+QNKYSHs"
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
          id = 60,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 304,
          width = 416,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 64,
          name = "",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 0,
          width = 16,
          height = 112,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 66,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 0,
          width = 32,
          height = 192,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 67,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 192,
          width = 112,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 69,
          name = "",
          type = "",
          shape = "rectangle",
          x = 416,
          y = 128,
          width = 16,
          height = 176,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 70,
          name = "",
          type = "",
          shape = "rectangle",
          x = 336,
          y = 112,
          width = 80,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
