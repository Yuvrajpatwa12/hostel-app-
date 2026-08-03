# Database Setup Artifact

This document contains the SQL `CREATE TABLE` statements for the Hostinger backend supporting the Hostel Management Flutter app.

## SQL Statements

```sql
-- Create Students Table
CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    room_no VARCHAR(10),
    course VARCHAR(100),
    status ENUM('Active', 'Inactive') DEFAULT 'Active',
    image_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Rooms Table
CREATE TABLE IF NOT EXISTS rooms (
    room_no VARCHAR(10) PRIMARY KEY,
    block VARCHAR(10),
    floor INT,
    capacity INT,
    occupied_count INT DEFAULT 0,
    status ENUM('Available', 'Full') DEFAULT 'Available',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Complaints Table
CREATE TABLE IF NOT EXISTS complaints (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(255) NOT NULL,
    room_no VARCHAR(10),
    category VARCHAR(100),
    description TEXT,
    priority ENUM('High', 'Medium', 'Low') DEFAULT 'Medium',
    status ENUM('Pending', 'In Progress', 'Resolved') DEFAULT 'Pending',
    assigned_staff VARCHAR(255),
    student_image TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Notices Table
CREATE TABLE IF NOT EXISTS notices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category ENUM('Events', 'Alerts', 'Maintenance', 'General') NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Activities Table
CREATE TABLE IF NOT EXISTS activities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    subtitle VARCHAR(255),
    time VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## How to Run in Hostinger PHPMyAdmin

1. **Log in to Hostinger hPanel**: Access your Hostinger account and navigate to the dashboard of your hosting plan.
2. **Open MySQL Databases**: In the left sidebar or the main grid, go to **Databases** > **MySQL Databases**.
3. **Access phpMyAdmin**:
   - Scroll down to the **List of Current MySQL Databases and Users** section.
   - Locate the database you created for this project.
   - Click the **Enter phpMyAdmin** button next to it.
4. **Execute SQL**:
   - Once phpMyAdmin opens, click on the **SQL** tab located in the top navigation bar.
   - Copy the SQL code provided above and paste it into the text box.
   - Ensure the "Delimiters" and other settings are at their defaults.
   - Click the **Go** button (usually at the bottom right) to execute the statements.
5. **Verify**: Check the sidebar on the left to ensure the `students`, `rooms`, `complaints`, `notices`, and `activities` tables have been created successfully.
