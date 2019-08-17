DROP TABLE IF EXISTS discount_folder_person, article_tag, discount, tag, comment, paragraph, title, article, commentator, author, person, blg_status, folder;

CREATE TABLE folder (
    id serial PRIMARY KEY,
    name varchar(255) NOT NULL,
    parent_id int DEFAULT NULL,
    FOREIGN KEY(parent_id) REFERENCES folder(id) ON DELETE SET NULL
);

CREATE TABLE blg_status (
    id serial PRIMARY KEY,
    name varchar(255) UNIQUE NOT NULL,
    color varchar(255) NOT NULL
);

CREATE TABLE person (
    id serial PRIMARY KEY,
    username varchar(255) UNIQUE NOT NULL,
    password varchar(255) NOT NULL,
    phones varchar(255)[] DEFAULT NULL,
    created_at timestamptz NOT NULL
);

CREATE TABLE author (
    id int PRIMARY KEY,
    is_admin boolean NOT NULL,
    FOREIGN KEY(id) REFERENCES person(id) ON DELETE RESTRICT
);

CREATE TABLE commentator (
    id int PRIMARY KEY,
    email varchar(255) UNIQUE NOT NULL,
    FOREIGN KEY(id) REFERENCES person(id) ON DELETE CASCADE
);

CREATE TABLE article (
    id serial PRIMARY KEY,
    status int NOT NULL,
    author_id int NOT NULL,
    folder_id int NOT NULL,
    created_at timestamptz NOT NULL,
    FOREIGN KEY(status) REFERENCES blg_status(id) ON DELETE RESTRICT,
    FOREIGN KEY(author_id) REFERENCES author(id) ON DELETE RESTRICT,
    FOREIGN KEY(folder_id) REFERENCES folder(id) ON DELETE RESTRICT
);

CREATE TABLE title (
    id serial PRIMARY KEY,
    content text DEFAULT NULL,
    article_id int DEFAULT NULL,
    FOREIGN KEY(article_id) REFERENCES article(id) ON DELETE RESTRICT
);

CREATE TABLE paragraph (
    id serial PRIMARY KEY,
    content text NOT NULL,
    position int NOT NULL,
    article_id int NOT NULL,
    FOREIGN KEY(article_id) REFERENCES article(id) ON DELETE RESTRICT
);

CREATE TABLE comment (
    id serial PRIMARY KEY,
    content text NOT NULL,
    article_id int DEFAULT NULL,
    person_id int NOT NULL,
    created_at timestamptz NOT NULL,
    FOREIGN KEY(article_id) REFERENCES article(id) ON DELETE RESTRICT,
    FOREIGN KEY(person_id) REFERENCES person(id) ON DELETE RESTRICT
);

CREATE TABLE tag (
    id serial PRIMARY KEY,
    content text NOT NULL
);

CREATE TABLE discount (
    id serial PRIMARY KEY,
    code_name varchar(255) NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL
);

CREATE TABLE article_tag (
    article_id int NOT NULL,
    tag_id int NOT NULL,
    created_at timestamptz NOT NULL,
    PRIMARY KEY(article_id, tag_id),
    FOREIGN KEY(article_id) REFERENCES article(id) ON DELETE CASCADE,
    FOREIGN KEY(tag_id) REFERENCES tag(id) ON DELETE CASCADE
);

CREATE TABLE discount_folder_person (
    discount_id int NOT NULL,
    folder_id int NOT NULL,
    person_id int NOT NULL,
    created_at timestamptz NOT NULL,
    PRIMARY KEY(discount_id, folder_id, person_id),
    FOREIGN KEY(discount_id) REFERENCES discount(id) ON DELETE CASCADE,
    FOREIGN KEY(folder_id) REFERENCES folder(id) ON DELETE CASCADE,
    FOREIGN KEY(person_id) REFERENCES person(id) ON DELETE CASCADE
);

INSERT INTO folder (name) VALUES
    ('folder 1');
INSERT INTO folder (name) VALUES
    ('folder 2');
INSERT INTO folder (name) VALUES
    ('folder 3');

INSERT INTO folder (name, parent_id) VALUES
    ('folder 1-1', 1);
INSERT INTO folder (name, parent_id) VALUES
    ('folder 1-2', 1);

INSERT INTO folder (name, parent_id) VALUES
    ('folder 1-1-1', 4);

INSERT INTO folder (name, parent_id) VALUES
    ('folder 3-1', 3);

INSERT INTO blg_status (name, color) VALUES
    ('DRAFT', 'red'),
    ('ONLINE', 'green'),
    ('ARCHIVED', 'blue');

INSERT INTO person (username, password, phones, created_at) VALUES
    ('Vince', 'Vince123', '{"11.11.11.11.11", "22.22.22.22.22", "33.33.33.33.33"}', NOW());

INSERT INTO author (id, is_admin) VALUES
    (1, 't');

INSERT INTO article (status, author_id, folder_id, created_at) VALUES
    (3, 1, 1, '2019-01-25 15:08:56');

INSERT INTO article (status, author_id, folder_id, created_at) VALUES
    (1, 1, 1, '2019-01-28 17:02:08');

INSERT INTO article (status, author_id, folder_id, created_at) VALUES
    (1, 1, 5, '2019-02-16 16:34:28.123');

INSERT INTO article (status, author_id, folder_id, created_at) VALUES
    (2, 1, 6, '2019-03-11 18:23:02');

INSERT INTO title (content, article_id) VALUES
    ('The content of: article 1 - title', 1);

INSERT INTO paragraph (content, position, article_id) VALUES
    ('The content of: article 1 - paragraph 1', 1, 1);

INSERT INTO paragraph (content, position, article_id) VALUES
    ('The content of: article 1 - paragraph 2', 2, 1);

INSERT INTO title (content, article_id) VALUES
    ('The content of: article 2 - title', 2);

INSERT INTO paragraph (content, position, article_id) VALUES
    ('The content of: article 2 - paragraph 1', 1, 2);

INSERT INTO title (content, article_id) VALUES
    ('The content of: article 3 - title', 3);

INSERT INTO paragraph (content, position, article_id) VALUES
    ('The content of: article 3 - paragraph 1', 1, 3);

INSERT INTO paragraph (content, position, article_id) VALUES
    ('The content of: article 3 - paragraph 2', 2, 3);

INSERT INTO title (content, article_id) VALUES
    ('The content of: article 4 - title', 4);

INSERT INTO paragraph (content, position, article_id) VALUES
    ('The content of: article 4 - paragraph 1', 1, 4);

INSERT INTO comment (content, article_id, person_id, created_at) VALUES
    ('The content of: comment 1', 1, 1, NOW());

INSERT INTO comment (content, article_id, person_id, created_at) VALUES
    ('The content of: comment 2', 1, 1, NOW());

INSERT INTO comment (content, article_id, person_id, created_at) VALUES
    ('The content of: comment 3', 2, 1, NOW());

INSERT INTO comment (content, article_id, person_id, created_at) VALUES
    ('The content of: comment 4', 3, 1, NOW());

INSERT INTO comment (content, article_id, person_id, created_at) VALUES
    ('The content of: comment 5', 4, 1, NOW());

INSERT INTO comment (content, article_id, person_id, created_at) VALUES
    ('The content of: comment 6', 4, 1, NOW());

INSERT INTO tag (content) VALUES
    ('tag_1');

INSERT INTO tag (content) VALUES
    ('tag_2');

INSERT INTO discount (code_name, start_date, end_date) VALUES
    ('WINTER2019', '2018-12-01', '2019-02-28');

INSERT INTO discount (code_name, start_date, end_date) VALUES
    ('SUMMER2019', '2019-07-01', '2019-09-30');

INSERT INTO article_tag (article_id, tag_id, created_at) VALUES
    (1, 1, NOW());

INSERT INTO article_tag (article_id, tag_id, created_at) VALUES
    (1, 2, NOW());

INSERT INTO discount_folder_person (discount_id, folder_id, person_id, created_at) VALUES
    (1, 3, 1, NOW());

INSERT INTO discount_folder_person (discount_id, folder_id, person_id, created_at) VALUES
    (2, 6, 1, NOW());
