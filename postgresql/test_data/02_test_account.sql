INSERT INTO account(active) VALUES (TRUE);

INSERT INTO account_profile(id, name, last_name, email, language_id)
SELECT acc.id, 'Андрей', 'Ганюшкин', 'andrey@ganyushkin.ru', 1
FROM account AS acc
WHERE acc.active IS TRUE
LIMIT 1;

INSERT INTO account_login_type(title) VALUES ('Yandex ID');
