# Two Tables Design Recipe Template

_Copy this recipe template to design and create two related database tables from a specification._

## 1. Extract nouns from the user stories or specification

```
# EXAMPLE USER STORY:
# (analyse only the relevant part - here the final line).

As a blogger
So I can write interesting stuff
I want to write posts having a title.

As a blogger
So I can write interesting stuff
I want to write posts having a content.

As a blogger
So I can let people comment on interesting stuff
I want to allow comments on my posts.

As a blogger
So I can let people comment on interesting stuff
I want the comments to have a content.

As a blogger
So I can let people comment on interesting stuff
I want the author to include their name in comments.
```

```
Nouns:

post title, post content, post comments, content comments, author name comments
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record  | Properties                            |
|---------|---------------------------------------|
| post    | title, content                        |
| comment | post_comments, content_comments, name |

1. Name of the first table (always plural): `posts`

   Column names: `title`, `content`

2. Name of the second table (always plural): `comments`

   Column names: `post_comments`, `content_comments`, `name`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: posts
id: SERIAL
title: text
content: text

Table: comments
id: SERIAL
name: text
post_comments: text
content_comments: text
```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one post have many comments? (Yes)
2. Can one comment have many posts? (No)

You'll then be able to say that:

1. **posts has many comments**
2. And on the other side, **comments belongs to posts**
3. In that case, the foreign key is in the table comments 'comment_id'

Replace the relevant bits in this example with your own:

```
# EXAMPLE

1. Can one post have many comments? YES
2. Can one comment have many post? NO

-> Therefore,
-> An post HAS MANY comment
-> An comment BELONGS TO a post 

-> Therefore, the foreign key is on the post table.
```

*If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).*

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: albums_table.sql

-- Replace the table name, column names and types.

-- Create the table without the foreign key first.
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  name text,
  post_comments text, 
  content_comments text
);

-- Then the table with the foreign key first.
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
-- The foreign key name is always {other_table_singular}_id
  comment_id int,
  constraint fk_content foreign key(comment_id)
    references comments(id)
    on delete cascade
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 database_name < albums_table.sql
```