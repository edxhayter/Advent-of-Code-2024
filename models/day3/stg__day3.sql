--0 Remove clutter from the data dump only keep our mul(digits of length max 3, digits of length max 3)
WITH remove_clutter AS (
SELECT
    REGEXP_SUBSTR_ALL(dump, 'mul\\(\\d{1,3}\\,\\d{1,3}\\)') AS mul_array
FROM {{ ref('src__day3') }}
),

-- Now flatten the arrays
flatten_mul AS (
    SELECT
        trim(flattened.value, '"') AS payload
    FROM remove_clutter,
        lateral flatten (input => mul_array) flattened
)

SELECT * FROM flatten_mul