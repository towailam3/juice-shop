SELECT
    *
FROM
    Users
WHERE
    email = '${req.body.email || ''}'
    AND password = '${security.hash(req.body.password || '')}'
    AND deletedAt IS NULL