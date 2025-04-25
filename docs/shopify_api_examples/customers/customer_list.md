# customer list

```graphql
query CustomerList {
  customers(first: 250) {
    nodes {
      id
      firstName
      lastName
      defaultEmailAddress {
        emailAddress
        marketingState
      }
      defaultPhoneNumber {
        phoneNumber
        marketingState
        marketingCollectedFrom
      }
      createdAt
      updatedAt
      numberOfOrders
      state
      amountSpent {
        amount
        currencyCode
      }
      verifiedEmail
      taxExempt
      tags
      addresses {
        id
        firstName
        lastName
        address1
        city
        province
        country
        zip
        phone
        name
        provinceCode
        countryCodeV2
      }
      defaultAddress {
        id
        address1
        city
        province
        country
        zip
        phone
        provinceCode
        countryCodeV2
      }
    }
  }
}
```

#### view the response from shopify api [here](customer_list_query_respnse.json)
