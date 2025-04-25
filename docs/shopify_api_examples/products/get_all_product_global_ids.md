# get all of shopify's product/variant global id's `GID`

```graphql
query GetProductsWithAllGIDs($first: Int = 10) {
  products(first: $first) {
    edges {
      node {
        id  # Product ID
        title
        handle

        # Variant IDs
        variants(first: 100) {
          edges {
            node {
              id  # Variant ID

              # Inventory Item ID
              inventoryItem {
                id  # Inventory Item ID
              }
            }
          }
        }

        # Image IDs
        images(first: 20) {
          edges {
            node {
              id  # Image ID
            }
          }
        }

        # Metafield IDs
        metafields(first: 20) {
          edges {
            node {
              id  # Metafield ID
            }
          }
        }

        # Media IDs
        media(first: 20) {
          edges {
            node {
              id  # Media ID
            }
          }
        }

        # Collections containing this product
        collections(first: 20) {
          edges {
            node {
              id  # Collection ID
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
```
