# "Database code" for the DB Forum.

import datetime
import psycopg2
import bleach

#POSTS = [("This is the first post.", datetime.datetime.now())]

def get_posts():
  """Return all posts from the 'database', most recent first."""
  DB = psycopg2.connect("dbname=forum")
  c = DB.cursor()
  c.execute("SELECT time, content FROM posts ORDER BY time DESC")
  #posts = ({'content': str(row[1]), 'time': str(row[0])}
  #         for row in c.fetchall())
  posts = c.fetchall()
  DB.close()
  #return reversed(POSTS)
  return posts

def add_post(content):
  """Add a post to the 'database' with the current timestamp."""
  #POSTS.append((content, datetime.datetime.now()))
  DB = psycopg2.connect("dbname=forum")
  c = DB.cursor()
  content = bleach.clean(content)
  #c.execute("INSERT INTO posts (content) VALUES('%s')" % content)
  c.execute("INSERT INTO posts (content) VALUES(%s)", (content,))
  DB.commit()
  DB.close()


