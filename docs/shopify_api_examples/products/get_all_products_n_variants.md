# get all products and variants

```graphql
query GetAllProductsAndVariants($cursor: String, $first: Int = 25) {
  products(first: $first, after: $cursor) {
    edges {
      cursor
      node {
        # Essential Product Information
        id
        title
        handle
        createdAt
        descriptionHtml
        productType
        publishedAt
        tags
        totalInventory
        updatedAt
        vendor

        # Price Range
        # priceRange {
         # maxVariantPrice {
          #  amount
           # currencyCode
          #}
          # minVariantPrice {
            # amount
            # currencyCode
          # }
        # }

        # First Image Only
        featuredMedia {
          id

        }

        # Reduced Collections
        collections(first: 13) {
          edges {
            node {
              id
              title
            }
          }
        }

        # Core Options
        options {
          name
          values
        }

        # Reduced Variant Information
        variants(first: 50) {
          edges {
            cursor
            node {
              id
              title
              sku
              price
              inventoryQuantity

              # Selected Options
              selectedOptions {
                name
                value
              }

              # Basic Inventory
              inventoryItem {
                id
                tracked
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
    pageInfo {
      hasNextPage
      endCursor
    }
  }
}
```

# `||`

```graphql
query GetAllProducts($cursor: String) {
  products(first: 50, after: $cursor) {
    edges {
      cursor
      node {
        id
        title
        handle

        # Media with IDs
        media(first: 15, sortKey: POSITION) {
          edges {
            node {
              id  # Media ID
              ... on MediaImage {
                id
                alt
                image {
                  id  # Image ID
                  url
                }
              }
            }
          }
        }

        # Options with IDs
        options {
          id  # Option ID
          name
          values
        }

        # Variants with IDs and inventory items
        variants(first: 50) {
          edges {
            node {
              id  # Variant ID
              title
              sku
              inventoryQuantity

              # Inventory Item ID
              inventoryItem {
                id  # Inventory Item ID
                inventoryLevels(first: 5) {
                  edges {
                    node {
                      id  # Inventory Level ID
                      location {
                        id  # Location ID
                      }
                    }
                  }
                }
              }

              selectedOptions {
                name
                value
              }

              # Metafields for variants
              metafields(first: 5) {
                edges {
                  node {
                    id  # Metafield ID
                  }
                }
              }
            }
          }
        }

        # Product metafields
        metafields(first: 10) {
          edges {
            node {
              id  # Metafield ID
              namespace
              key
            }
          }
        }

        # Collections containing this product
        collections(first: 5) {
          edges {
            node {
              id  # Collection ID
              title
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
