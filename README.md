<a name="readme-top"></a>

<br />
<div align="center">

<h3 align="center">🍵 Tea Subscription API</h3>

  <p align="center">
    An application that allows a customer to register for tea subscriptions.
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#installation">Installation</a></li>
        <li><a href="#testing-with-rspec">Testing With RSpec</a></li>
      </ul>
    </li>
    <li><a href="#available-endpoints">Available Endpoints</a></li>
    <li><a href="#goals">Goals</a></li>
  </ol>
</details>


<br>

<!-- ABOUT THE PROJECT -->
## About The Project
<br>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Built With:
  <p>
  <img src="https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white">
  </p>

**3.1.1**

  <p>
  <img src="https://img.shields.io/badge/Rails-CC342D?style=for-the-badge&logo=ruby&logoColor=white">
  </p>

**7.0.4**

  <p>
  <img src="https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=ruby&logoColor=white">
  </p>

**Postgres 14**


<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

To run the application locally, this repository will need to be cloned and set up fully with required gems.

<br>

### Installation

1. Clone the repo:
   ```bash
   git@github.com:4D-Coder/tea_subscription_api.git
   ```

2. Install gems:
   ```bash
   bundle install
   ```

3. To establish the database, run:
   ```bash
   rails db:create
   ```

4. To migrate the database configurations into your local development and test environment, run:
   ```bash
   rails db:migrate
   ```
<br>

  Inspect the `/db/schema.rb` and compare to the 'Schema' section below to ensure this migration has been done successfully.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<br>


### Testing with RSpec

Once `tea_subscription_api` is correctly installed, run tests locally to ensure the repository works as intended.

<br>

  To test the entire RSpec suite, run:
   ```bash
   bundle exec rspec
   ```

<br>

All tests should be passing if the installation was successful.

If any tests are not passing, please report which tests are not passing <a href="https://github.com/4D-Coder/tea_subscription_api/issues">Here</a>.


<p align="right">(<a href="#readme-top">back to top</a>)</p>

<br>


## Available Endpoints
- This API can be called locally using a program like [Postman](https://www.postman.com).

- *Note:* Necessary parameters marked with {}

<br>

## Start a Subscription (Happy Path)

```http
POST /api/v1/customers/:id/subscriptions
```

<br>

Request: <br>
```json
{
	"title": "Power of Insight",
	"total_price": 60,
	"status": "Active",
	"frequency": "Weekly",
	"teas": [
		{
			"tea_id": 2
		},
		{etc...
		}
	]
}

```

| Code | Description |
| :--- | :--- |
| 201 | `Created` |

Response:

```json

{
	"data": {
		"id": "1",
		"type": "subscription",
		"attributes": {
			"title": "Power of Insight",
			"total_price": 60,
			"status": "Active",
			"frequency": "Weekly",
			"teas": [
				{
					"id": 2,
					"title": "Neurogenesis",
					"description": "smooth brain",
					"temperature": 100,
					"brew_time": 120,
					"unit_price": 5
				},
				{etc...
				}
			],
		},
	},
}
```
Notes:
- If subscription data is included in the content of the request, I  assume that the subscription is something that is customized by the customer, and is only created alongside an tea that comes from the database (or service) that they’ve selected.
- I also assume that additional teas can be added to this same subscription later
- If there isnt a tea in the request body, throw an error
- In the subscription controller, we will create the subscription and return it as an object with an id
- For the response body, I’m assuming that once a customer has been successfully subscribed, the content will hold information for the front end to render a cusomer’s subscription details.


<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Cancel a Subscription (Happy Path)

```http
PATCH /api/v1/customer/:id/subscriptions/:ids
```

<br>

Request: <br>
```json
{
	"title": "Power of Insight",
	"total_price": 60,
	"status": "Active",
	"frequency": "Weekly",
	"teas": [
		{
			"tea_id": 2
		},
		{etc...
		}
	]
}

```

| Code | Description |
| :--- | :--- |
| 200 | `OK` |
Parameters:

```json

CONTENT_TYPE=application/json

```

Request:
```json

{
	"status": "Cancelled"
}

```
Response:

```json

{
	"data": {
		"id": "1",
		"type": "subscription",
		"attributes": {
			"title": "Art of Tea",
			"price": 40,
			"status": "Cancelled",
			"frequency": "Monthly",
			"teas": [{
				"id": 1,
				"title": "Oolong",
				"description": "tis very nice",
				"temperature": 150,
				"brew_time": 90,
				"unit_price": 8
				},
				{tea2...
			}]
		}
	}
}

```
Notes:
- Response body assumes that the frontend would want to show the user that cancelled subscription info with an updated status of cancelled.
- GET method will need to show both active and cancelled subscriptions, so a status change on the subscription record also needs to happen with the change
- Originally this method was a DELETE , but I found it pertinent to preserve data, so that a hypothetical business can see all subscriptions that are active and inactive, along with a record of what teas were being purchased .


<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Get All Subscriptions (Happy Path)

```http
GET /api/v1/customer/:id/subscriptions
```

<br>

Request: <br>
```json
{
	"title": "Power of Insight",
	"total_price": 60,
	"status": "Active",
	"frequency": "Weekly",
	"teas": [
		{
			"tea_id": 2
		},
		{etc...
		}
	]
}

```

| Code | Description |
| :--- | :--- |
| 200 | `OK` |
Parameters:

```json

CONTENT_TYPE=application/json

```

Request:
```json

No Parameters

```
Response:

```json
{
	"data": [
		{
			"id": "1",
			"type": "subscription",
			"attributes": {
				"title": "Art of Tea",
				"price": 40,
				"status": "Active",
				"frequency": "Monthly",
				"teas": [
					{
						"id": 1,
						"title": "Oolong",
						"description": "tis very nice",
						"temperature": 150,
						"brew_time": 90,
						"unit_price": 9
					},
					{etc...}
				],
			},
		},
		{
			"id": "2",
			"type": "subscription",
			"attributes": {
				"title": "Power of Insight",
				"price": 60,
				"status": "Cancelled",
				"frequency": "Weekly",
				"teas": [
					{
						"id": 2,
						"title": "Neurogenesis",
						"description": "smooth brain",
						"temperature": 100,
						"brew_time": 120,
						"unit_price": 20
					},
					{etc...}
				],
			},
		},
	]
}

```
Notes:
- Much like when someone starts a subscription, I assume we will want to see all subscriptions (active or cancelled)


<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Goals

See the take-home requirements [here](https://mod4.turing.edu/projects/take_home/take_home_be).

<br>

### Goals Checklist
- Exhibit a strong understanding of rails.
- A strong understanding of Rails
- Ability to create restful routes
- Demonstration of well-organized code, following OOP
- Test Driven Development
- Clear documentation

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<br>

## Database Schema

<img src="assets/Screenshot 2023-06-02 at 1.29.00 PM.png">

<br>

## Contributors
<table>
  <tr>
    <td><img src="https://avatars.githubusercontent.com/4D-Coder"></td>
  </tr>
  <tr>
    <td>Antonio King Hunt</td>
  </tr>
  <tr>
      <a href="https://github.com/4D-Coder">GitHub</a><br>
      <a href="https://www.linkedin.com/in/antoniokinghunt/">LinkedIn</a>
    </td>
  </tr>
</table>
