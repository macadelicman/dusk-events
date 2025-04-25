# get products by inventory location(s) -{ using their }-  id(s)

**to find your location id(s) - [read this doc](get_all_locations.md)**

```graphql
query GetProductsByInventoryLocation($locationId: ID!, $first: Int) {
  location(id: $locationId) {
    id
    name
    inventoryLevels(first: $first) {
      edges {
        node {

          item {
            ... on InventoryItem {
              id
              tracked
              variant {
                id
                title
                product {
                  id
                  title
                  description
                  productType
                  vendor
                  handle
                  images(first: 10) {
                    edges {
                      node {
                        id
                        url
                        altText
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
      pageInfo {
        hasNextPage
        endCursor
      }
    }
  }
}
```

### **variables:**

```json
{
  "locationId": "gid://shopify/Location/96950124791",
  "first": 20
}
```
