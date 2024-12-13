WITH source AS (
    SELECT * FROM {{ ref('src_day2__addrn') }}
)

SELECT *
FROM source
WHERE cast(f1 AS NUMERIC) < cast(f2 AS NUMERIC)