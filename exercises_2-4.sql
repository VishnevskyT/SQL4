CREATE DATABASE MyJoinsDB; 					-- Завдання 2-4
										-- Завдання 2: Создайте базу данных с именем “MyJoinsDB”.
USE MyJoinsDB;

DROP DATABASE MyJoinsDB;

DROP TABLE contacts;

CREATE TABLE contacts
(					-- Завдання 3: В данной базе данных создайте 3 таблицы, В 1-й таблице содержатся имена и номера телефонов сотрудников компании.
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(20) NOT NULL,
tel VARCHAR(30) NOT NULL
);

INSERT INTO contacts
(name, tel)
VALUES
('Vasya', '(099)225-65-14'),
('Petya', '(050)187-32-24'),
('Tosha', '(097)278-12-65'),
('Moisha', '(063)876-87-23'),
('Izya', '(067)002-44-77');

SELECT * FROM contacts;

DROP TABLE employees;

CREATE TABLE employees 					-- Завдання 3: Во 2-й таблице содержатся ведомости о зарплате и должностях сотрудников: главный директор, менеджер, рабочий. 
(
employee_id INT NOT NULL,
salary DOUBLE NOT NULL,
position VARCHAR(50) NOT NULL,
FOREIGN KEY(employee_id) REFERENCES contacts(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

INSERT INTO employees
(employee_id, salary, position)
VALUES
(1, 66000, 'chief'),
(2, 16000, 'manager'),
(3, 16000, 'manager'),
(4, 6000, 'worker'),
(5, 6000, 'worker');

SELECT * FROM employees;

DROP TABLE personal;

CREATE TABLE personal                                             -- Завдання 3: В 3-й таблице содержится информация о семейном положении, дате рождения, и месте проживания. 
(
employee_id INT NOT NULL,
f_status VARCHAR(20) NOT NULL,
birthday DATE NOT NULL,
address VARCHAR(100) NOT NULL,
FOREIGN KEY(employee_id) REFERENCES contacts(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

INSERT INTO personal
(employee_id, f_status, birthday, address)
VALUES
(1, 'free', '1989-02-03', 'Kyiv'),
(2, 'reserved', '1999-05-12', 'Lviv'),
(3, 'married', '2000-06-15', 'Kharkiv'),
(4, 'free', '1992-09-30', 'Dnipro'),
(5, 'widow', '1998-12-01', 'Odesa');

SELECT * FROM personal;


/*
Завдання 4 
Сделайте выборку при помощи JOIN’s для таких заданий: 
1) Получите контактные данные сотрудников (номера телефонов, место жительства). 
2) Получите информацию о дате рождения всех холостых сотрудников и их номера. 
3) Получите информацию обо всех менеджерах компании: дату рождения и номер телефона. 
*/

SELECT id, tel, address FROM contacts
	JOIN personal
    ON contacts.id = personal.employee_id
    GROUP BY	id,
				address;

SELECT id, birthday, tel FROM contacts
	LEFT JOIN personal
    ON contacts.id = personal.employee_id
    WHERE personal.f_Status = 'free';
    
    
    SELECT id, birthday, tel FROM contacts
    JOIN employees
    ON contacts.id = employees.employee_id
    JOIN personal
    ON contacts.id = personal.employee_id
    WHERE employees.position = 'manager';
