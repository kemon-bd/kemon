# Review reaction

## cURL

```bash
curl -X 'GET' \
  'https://api.kemon.com.bd/review-reaction' \
  -H 'accept: */*' \
  -H 'reviewGuid: Guid'
```

## Response

```json
{
    "success": true,
    "error": null,
    "result":  [
        {
            "userId": "7f9fa806-1321-49a2-98fd-055660626a1f",
            "type": 1
        },
        {
            "userId": "dd5247a5-7ac0-4f1d-8307-2ac355f97580",
            "type": 1
        }
    ]
}
```
