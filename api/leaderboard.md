# Leaderboard

## cURL

```bash
curl -X 'GET' \
  'https://api.kemon.com.bd/leaderboard' \
  -H 'accept: */*' \
  -H 'page: int' \
  -H 'query: string' \
  -H 'from: DateTime' \
  -H 'to: DateTime' \
```

## Response

```json
{
    "success": true,
    "error": null,
    "result": {
        "total": 2,
        "deadline": "2024-12-31T23:59:59",
        "leaders": [
            {
                "userId": "7f9fa806-1321-49a2-98fd-055660626a1f",
                "point": 26
            },
            {
                "userId": "dd5247a5-7ac0-4f1d-8307-2ac355f97580",
                "point": 4
            }
        ]
    }
}
```