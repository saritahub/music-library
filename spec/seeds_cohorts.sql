TRUNCATE TABLE cohorts, students RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO cohorts (name, start_date) VALUES ('Anne', '2022-04-01');
INSERT INTO cohorts (name, start_date) VALUES ('Sara', '2022-09-01');