# get all { product(s) / variant(s) } v2

```graphql
query GetAllProducts($cursor: String) {
  products(first: 250, after: $cursor) {
    edges {
      cursor
      node {
        id
        title
        priceRangeV2 {
          maxVariantPrice {
            amount
          }
          minVariantPrice {
            amount
          }
        }
        media(first: 5, sortKey: POSITION) {
          edges {
            node {
              ... on MediaImage {
                id
                alt
                image {
                  url
                }
              }
            }
          }
        }
        options {
          id
          name
          values
        }
        variants(first: 50) {
          edges {
            node {
              id
              title
              sku
              price
              inventoryQuantity
              selectedOptions {
                name
                value
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
```
