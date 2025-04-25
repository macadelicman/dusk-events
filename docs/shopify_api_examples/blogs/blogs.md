# blogs

```graphql
query BlogList {
  blogs(first: 150) {
    nodes {
      id
      handle
      title
      updatedAt
      commentPolicy
      feed {
        path
        location
      }
      createdAt
      templateSuffix
      tags
    }
  }
}
```

#### view the response from the shopify api [here](blogs_query.json)
