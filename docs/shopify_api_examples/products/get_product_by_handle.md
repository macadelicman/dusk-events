# get product(s) by `handle`

```graphql
query GetProductByHandle($handle: String!) {
  productByHandle(handle: $handle) {
    id
    title
  }
}
```

### **variables:**

```json
{
  "handle": "100-baby-alpaca-throw"
}
```

### **response:**

```json
{
  "data": {
    "productByHandle": {
      "id": "gid://shopify/Product/9546282926327",
      "title": "100% Baby Alpaca Throw"
    }
  },
  "extensions": {
    "cost": {
      "requestedQueryCost": 1,
      "actualQueryCost": 1,
      "throttleStatus": {
        "maximumAvailable": 4000,
        "currentlyAvailable": 3999,
        "restoreRate": 200
      }
    }
  }
}
```
