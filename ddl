-- 1. Справочник отделов
CREATE TABLE departments (
    department_id INT PRIMARY KEY IDENTITY(1,1),
    department_name VARCHAR(255) NOT NULL
);

-- 2. Справочник статей затрат
CREATE TABLE expense_items (
    item_id INT PRIMARY KEY IDENTITY(1,1),
    item_name VARCHAR(255) NOT NULL,    -- Наименование статьи (например, "Командировки", "Канцелярия")
    item_category VARCHAR(255)          -- Возможная группировка статей
);

-- 3. Плановые затраты на год
CREATE TABLE planned_expenses (
    plan_id INT PRIMARY KEY IDENTITY(1,1),
    department_id INT NOT NULL,
    item_id INT NOT NULL,
    plan_year INT NOT NULL CHECK (plan_year >= 2020),  -- Год планирования
    planned_amount DECIMAL(18, 2) NOT NULL CHECK (planned_amount >= 0),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (item_id) REFERENCES expense_items(item_id)
);

-- 4. Фактические затраты (ежемесячный отчет)
CREATE TABLE actual_expenses (
    actual_id INT PRIMARY KEY IDENTITY(1,1),
    department_id INT NOT NULL,
    item_id INT NOT NULL,
    expense_date DATE NOT NULL,      -- Дата совершения расхода (или период отчета)
    amount DECIMAL(18, 2) NOT NULL CHECK (amount >= 0),
    note VARCHAR(500),               -- Примечание/описание (опционально)
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (item_id) REFERENCES expense_items(item_id)
);