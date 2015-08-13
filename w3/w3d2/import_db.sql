CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(100) NOT NULL,
  lname VARCHAR(100) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id)
);

CREATE TABLE question_follows (
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Jon', 'Noble'),
  ('Mark', 'Noble'),
  ('Jack', 'Skellington'),
  ('Mindy', 'Mangle'),
  ('Sarah', 'Sampleton'),
  ('Jason', 'Zwick'),
  ('Edmund', 'Wright');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('Sky', 'Why is the sky blue?', (SELECT id FROM users WHERE lname = 'Zwick')),
  ('Rennaisance Fairs', 'Why do Americans love renaissance fairs?',
    (SELECT id FROM users WHERE lname = 'Wright')),
    ('What is this?', 'There is color everywhere!', (SELECT id FROM users WHERE lname = 'Skellington'));

INSERT INTO
  replies (question_id, parent_id, user_id, body)
VALUES
  (
    (SELECT id FROM questions WHERE title = 'Sky'),
    NULL,
    (SELECT id FROM users WHERE lname = 'Mangle'),
    'It is about the way light reflects'
  );

INSERT INTO
  question_likes (question_id, user_id)
VALUES
  (
    (SELECT id FROM questions WHERE title = 'Sky'),
    (SELECT id FROM users WHERE lname = 'Wright')
  ),
  (
    (SELECT id FROM questions WHERE title = 'Sky'),
    (SELECT id FROM users WHERE lname = 'Zwick')
  );

INSERT INTO
  question_follows (question_id, user_id)
VALUES
  (
    (SELECT id FROM questions WHERE title = 'Sky'),
    (SELECT id FROM users WHERE lname = 'Wright')
  ),
  (
    (SELECT id FROM questions WHERE title = 'Sky'),
    (SELECT id FROM users WHERE lname = 'Mangle')
  ),
  (
    (SELECT id FROM questions WHERE title = 'Rennaisance Fairs'),
    (SELECT id FROM users WHERE lname = 'Sampleton')
  );

  /* For children only. Like Trix. THey are for kids. */

  INSERT INTO
    replies (question_id, parent_id, user_id, body)
  VALUES
    (
      (SELECT id FROM questions WHERE title = 'Sky'),
      (SELECT id FROM replies WHERE body = 'It is about the way light reflects'),
      (SELECT id FROM users WHERE lname = 'Zwick'),
      'That is not very helpful, now is it?'
    ),
    (
      (SELECT id FROM questions WHERE title = 'Sky'),
      (SELECT id FROM replies WHERE body = 'It is about the way light reflects'),
      (SELECT id FROM users WHERE lname = 'Wright'),
      'Do not listen to Jason, he is a jerk.'
    );
