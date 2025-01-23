# Air-Crago-Analysis: Air Cargo Management

## Project Description

**Air Cargo** is an aviation company providing **air transportation services** for both passengers and freight. Through a network of aircraft and strategic partnerships with other airlines, the company offers diverse services to improve the ease of travel and booking for customers.

In order to **optimize operations**, Air Cargo aims to generate reports on:
- Regular passengers
- Busiest routes
- Ticket sales details
- Other performance indicators

This analysis will assist the company in improving **operability** and becoming a more **customer-centric** and preferred choice for air travel.

---

## Project Objective

As a **Database Administrator (DBA)**, your primary tasks include:
- Identifying **regular customers** for targeted offers.
- Analyzing **busiest routes** to determine optimal aircraft usage.
- Preparing **ticket sales reports** to assess business performance.
  
Additionally, your analysis will help improve the company’s overall **operability** and provide better **customer satisfaction**.

---

## Dataset Description

The project utilizes several tables containing critical data about customers, flight details, ticket information, and routes. Below is an overview of the datasets:

### **1. `customer`**: Customer Information

This table contains personal information about each customer.

| Column Name   | Description                                  |
|---------------|----------------------------------------------|
| `customer_id` | Unique ID of the customer                    |
| `first_name`  | First name of the customer                   |
| `last_name`   | Last name of the customer                    |
| `date_of_birth`| Customer's date of birth                    |
| `gender`      | Gender of the customer                       |

---

### **2. `passengers_on_flights`**: Travel Information

This table holds details about each passenger's travel journey.

| Column Name   | Description                                  |
|---------------|----------------------------------------------|
| `aircraft_id` | ID of the aircraft used                      |
| `route_id`    | Route ID for departure and destination       |
| `customer_id` | ID of the customer traveling                 |
| `depart`      | Departure location                           |
| `arrival`     | Arrival location                             |
| `seat_num`    | Unique seat number                           |
| `class_id`    | Travel class ID                              |
| `travel_date` | Date of travel                              |
| `flight_num`  | Flight number for the route                  |

---

### **3. `ticket_details`**: Ticket Purchase Information

This table tracks the ticket purchase details for customers.

| Column Name   | Description                                  |
|---------------|----------------------------------------------|
| `p_date`      | Date when the ticket was purchased           |
| `customer_id` | ID of the customer                           |
| `aircraft_id` | Aircraft ID of the corresponding flight      |
| `class_id`    | Class ID of the travel (economy, business, etc.) |
| `no_of_tickets`| Number of tickets purchased                 |
| `a_code`      | Code of the airport                          |
| `price_per_ticket`| Price per ticket                         |
| `brand`       | Aviation service provider                    |

---

### **4. `routes`**: Flight Route Information

This table contains details about the flight routes.

| Column Name   | Description                                  |
|---------------|----------------------------------------------|
| `route_id`    | Unique Route ID                              |
| `flight_num`  | Flight number for the route                  |
| `origin_airport`| Departure airport                          |
| `destination_airport`| Arrival airport                       |
| `aircraft_id` | ID of the aircraft used                      |
| `distance_miles`| Distance between the origin and destination |

---

## Key Analysis Tasks

1. **Identify Regular Customers**: Analyze customer data to identify frequent travelers and generate reports for targeted offers.
2. **Busiest Routes Analysis**: Identify the busiest flight routes and assess if additional aircraft are required.
3. **Ticket Sales Report**: Calculate total ticket sales and analyze trends in the data.

---

> [!Note]  
> You can download the dataset from [this link](https://github.com/saumya-713/Air_Crago_Analysis/raw/refs/heads/main/air_cargo_datasets.zip).

---
