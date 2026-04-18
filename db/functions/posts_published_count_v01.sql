CREATE OR REPLACE FUNCTION posts_published_count()
RETURNS integer AS $$
  SELECT COUNT(*)::int
  FROM posts
  WHERE status = 'published'
    AND discarded_at IS NULL;
$$ LANGUAGE SQL STABLE;
