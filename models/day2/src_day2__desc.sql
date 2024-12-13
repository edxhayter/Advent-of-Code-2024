WITH source AS (
    SELECT * FROM {{ ref('src_day2__addrn') }}
)

SELECT *
FROM source
WHERE CAST(f1 AS numeric) > CAST(f2 AS numeric)