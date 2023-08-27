-- Crea el usuario
CREATE USER 'mariauser'@'%' IDENTIFIED BY '123456';

-- Otorga todos los privilegios al usuario
GRANT ALL PRIVILEGES ON *.* TO 'mariauser'@'%';

-- Refresca los privilegios
FLUSH PRIVILEGES;
