
# Loyalty Program API

This Rails API project implements a loyalty platform that allows clients to issue loyalty points and rewards to their end users based on spending behavior.

---

## Overview

The platform supports:

### Point Earning Rules

- **Level 1:** For every $100 spent, the user earns 10 points.
- **Level 2:** If the purchase is made in a foreign country (different from user's country), points earned are doubled.

### Reward Issuing Rules

- **Level 1:** If a user accumulates 100 points in a calendar month, they receive a **Free Coffee** reward.
- **Level 2:** All users receive a **Free Coffee** during their birthday month.
- **Level 2:** New users who spend more than $1000 within 60 days of their first transaction receive **Free Movie Tickets**.

---

## API Endpoints

### Authentication

All API calls require an API key via the `Authorization` header:

```
Authorization: Bearer <api_key>
```

---

### Create Purchase

`POST /api/purchases`

Create a purchase to award points based on the purchase amount and country.

**Request Body**

```json
{
  "purchase": {
    "user_id": 1,
    "amount_cents": 15000,
    "country": "US",
    "currency": "USD" // optional, default "USD"
  }
}
```

**Response (201 Created)**

```json
{
  "data": {
    "id": "123",
    "type": "purchase",
    "attributes": {
      "user_id": 1,
      "amount_cents": 15000,
      "country": "US",
      "currency": "USD",
      "created_at": "2025-08-10T12:00:00Z"
    }
  }
}
```

---

### List User Points

`GET /api/users/:user_id/points`

Get all point ledger entries for a user.

**Response (200 OK)**

```json
{
  "data": [
    {
      "id": "1",
      "type": "point_ledger",
      "attributes": {
        "points": 10,
        "purchase_id": "123",
        "created_at": "2025-08-01T10:00:00Z"
      }
    }
  ]
}
```

---

### Grant Rewards to User

`POST /api/users/:user_id/rewards`

Evaluates and creates rewards for the user based on accumulated points and spending patterns.

**Response (201 Created)**

```json
{
  "data": [
    {
      "id": "1",
      "type": "reward",
      "attributes": {
        "reward_type": "free_coffee",
        "reason": "Monthly threshold",
        "awarded_at": "2025-08-10T12:00:00Z"
      }
    }
  ]
}
```

---

## Sample cURL Requests

### Create Purchase

```bash
curl -X POST http://localhost:3000/api/purchases \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "purchase": {
      "user_id": 1,
      "amount_cents": 15000,
      "country": "US"
    }
  }'
```

---

### Get User Points

```bash
curl -X GET http://localhost:3000/api/users/1/points \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Accept: application/json"
```

---

### Grant Rewards

```bash
curl -X POST http://localhost:3000/api/users/1/rewards \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json"
```

---

## Setup and Run

- Ruby version: 3.x
- Rails version: 7.x
- Run migrations: `rails db:migrate`
- Run tests: `bundle exec rspec`

---

## Development Workflow

- Clean, simple design using service objects to keep code organized.
- Follow single responsibility principle so each part does one thing well.
- Use feature branches with clear commits for each change.
- Write tests for units, jobs, queries, services and API requests to make sure everything works.
- Secure APIs with API keys.
- Use serializers to format JSON responses consistently.
- Recurring cron jobs that automatically award rewards to users based on predefined business logic 
---
