SELECT
    *
FROM
    Users
WHERE
    email = ?
    AND password = ?
    AND deletedAt IS NULL