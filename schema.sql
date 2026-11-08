CREATE DATABASE IF NOT EXISTS tour_guide_mini
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE tour_guide_mini;

CREATE TABLE regions (
	region_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE guides (
	guide_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    language VARCHAR(100) NOT NULL,
    region_id INT NOT NULL,
    CONSTRAINT fk_guides_region
        FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE customers (
	customer_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE trips (
	trip_id INT PRIMARY KEY NOT NULL UNIQUE,
    customer_id INT NOT NULL,
    guide_id INT NOT NULL,
    departure_date DATE NOT NULL,
    status VARCHAR(100) NOT NULL DEFAULT 'Pending',
    destination VARCHAR(150) NOT NULL,
    participant_count INT NOT NULL,
    CONSTRAINT fk_trips_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_trips_guide    FOREIGN KEY (guide_id)    REFERENCES guides(guide_id),
    CONSTRAINT ck_trips_status   CHECK (status IN ('Pending','Completed','Cancelled')),
    CONSTRAINT ck_trips_count    CHECK (participant_count > 0),
    CONSTRAINT uq_trips_id_status UNIQUE (trip_id, status)
);

CREATE TABLE trip_reports (
	report_id INT PRIMARY KEY,
    trip_id INT NOT NULL UNIQUE,
    status VARCHAR(20) NOT NULL DEFAULT 'Completed',
    finished_at DATETIME NOT NULL,
    itinerary_summary TEXT NOT NULL,
    feedback TEXT,
    fee DECIMAL(12,2) NOT NULL,
    CONSTRAINT ck_report_status CHECK (status = 'Completed'),
    CONSTRAINT ck_report_fee    CHECK (fee >= 0),
    CONSTRAINT fk_report_trip_completed
        FOREIGN KEY (trip_id, status) REFERENCES trips(trip_id, status)
);

CREATE TABLE payments (
	payment_id INT PRIMARY KEY,
    trip_id INT NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    payment_date DATE NOT NULL,
    method VARCHAR(20) NOT NULL,
    CONSTRAINT ck_payments_amount CHECK (amount > 0),
    CONSTRAINT ck_payments_method CHECK (method IN ('Cash','BankTransfer','Card')),
    CONSTRAINT fk_payments_report FOREIGN KEY (trip_id) REFERENCES trip_reports(trip_id)
);