CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    username VARCHAR(30) NOT NULL UNIQUE,
    password VARCHAR(30) NOT NULL,
    email VARCHAR(50) NOT NULL,
    gender CHAR(1) NOT NULL,
    age INT NOT NULL,
    job_title VARCHAR(40) NOT NULL,
    ip VARCHAR(30) NOT NULL,

    CONSTRAINT ck_accounts_gender
        CHECK (gender = 'M' OR gender = 'F')
);

CREATE TABLE addresses (
    id SERIAL PRIMARY KEY,
    street VARCHAR(30) NOT NULL,
    town VARCHAR(30) NOT NULL,
    country VARCHAR(30) NOT NULL,
    account_id INT NOT NULL,

    CONSTRAINT fk_addresses_accounts
        FOREIGN KEY (account_id)
            REFERENCES accounts(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

CREATE TABLE photos (
    id SERIAL PRIMARY KEY,
    description TEXT,
    capture_date TIMESTAMP NOT NULL,
    views INT DEFAULT 0 NOT NULL,

    CONSTRAINT ck_photos_views
        CHECK (views >= 0)
);

CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    content VARCHAR(255) NOT NULL,
    published_on TIMESTAMP NOT NULL,
    photo_id INT NOT NULL,

    CONSTRAINT fk_comments_photos
        FOREIGN KEY (photo_id)
            REFERENCES photos(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

CREATE TABLE accounts_photos (
    account_id INT NOT NULL,
    photo_id INT NOT NULL,

    CONSTRAINT fk_accounts_photos_accounts
        FOREIGN KEY (account_id)
            REFERENCES accounts(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,

    CONSTRAINT fk_accounts_photos_photos
        FOREIGN KEY (photo_id)
            REFERENCES photos(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

CREATE TABLE likes (
    id SERIAL PRIMARY KEY,
    photo_id INT NOT NULL,
    account_id INT NOT NULL,

    CONSTRAINT fk_likes_photos
        FOREIGN KEY (photo_id)
            REFERENCES photos(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,

    CONSTRAINT fk_likes_accounts
        FOREIGN KEY (account_id)
            REFERENCES accounts(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

ALTER TABLE accounts_photos
ADD PRIMARY KEY (account_id, photo_id);