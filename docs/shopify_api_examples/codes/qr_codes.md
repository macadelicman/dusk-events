# qr codes mutation

> **query**

```graphql
query GetProductVariants($productId: ID!) {
  product(id: $productId) {
    id
    title
    variants(first: 50) {
      edges {
        node {
          id
          title
          sku
          barcode
        }
      }
    }
  }
}
```

**variables to pass to the above**
```json
{
  "productId": "gid://shopify/Product/9546282926327"
}
```

---

#### see response to the above [here](product_varaint_barcode_query.json)

---


> **mutation**

```graphql
mutation ProductVariantsUpdate($productId: ID!, $variants: [ProductVariantsBulkInput!]!) {
  productVariantsBulkUpdate(productId: $productId, variants: $variants) {
    product {
      id
    }
    productVariants {
      id
      barcode
      metafields(first: 2) {
        edges {
          node {
            namespace
            key
            value
          }
        }
      }
    }
    userErrors {
      field
      message
    }
  }
}
```

#### variables that must be passed

```json
{
  "productId": "gid://shopify/Product/9546282926327",
  "variants": [
    {"id": "gid://shopify/ProductVariant/49191732478199", "barcode": "https://thnk.com/products/100-baby-alpaca-throw?variant=49191732478199"},
    {"id": "gid://shopify/ProductVariant/49191732510967", "barcode": "https://thnk.com/products/100-baby-alpaca-throw?variant=49191732510967"}
  ]
}
```

#### see response [here](product_variant_barcode_update.json)
