const String mockResponse = '''
{
  "code": 200,
  "status": "Ok",
  "copyright": "© 2024 MARVEL",
  "attributionText": "Data provided by Marvel. © 2024 MARVEL",
  "attributionHTML": "<a href=\\"http://marvel.com\\">Data provided by Marvel. © 2024 MARVEL</a>",
  "etag": "3d4a9c30187c88d5c21dc96470aa847bb19bd53d",
  "data": {
    "offset": 0,
    "limit": 20,
    "total": 3,
    "count": 3,
    "results": [
      {
        "id": 1017475,
        "name": "Iceman (X-Men: Battle of the Atom)",
        "description": "",
        "modified": "2014-01-16T13:12:41-0500",
        "thumbnail": {
          "path": "http://i.annihil.us/u/prod/marvel/i/mg/9/70/52d72ac3c45f9",
          "extension": "jpg"
        },
        "resourceURI": "http://gateway.marvel.com/v1/public/characters/1017475",
        "comics": {
          "available": 0,
          "collectionURI": "http://gateway.marvel.com/v1/public/characters/1017475/comics",
          "items": [],
          "returned": 0
        },
        "series": {
          "available": 0,
          "collectionURI": "http://gateway.marvel.com/v1/public/characters/1017475/series",
          "items": [],
          "returned": 0
        },
        "stories": {
          "available": 0,
          "collectionURI": "http://gateway.marvel.com/v1/public/characters/1017475/stories",
          "items": [],
          "returned": 0
        },
        "events": {
          "available": 0,
          "collectionURI": "http://gateway.marvel.com/v1/public/characters/1017475/events",
          "items": [],
          "returned": 0
        },
        "urls": [
          {
            "type": "detail",
            "url": "http://marvel.com/characters/27/iceman?utm_campaign=apiRef&utm_source=422c32a7c4c3f9adfe3f4aef0db1a1e8"
          },
          {
            "type": "comiclink",
            "url": "http://marvel.com/comics/characters/1017475/iceman_x-men_battle_of_the_atom?utm_campaign=apiRef&utm_source=422c32a7c4c3f9adfe3f4aef0db1a1e8"
          }
        ]
      }
    ]
  }
}
''';