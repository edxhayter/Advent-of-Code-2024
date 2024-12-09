WITH source AS (

    SELECT
        *
    FROM {{ ref('day1') }}
),

first_col AS (
    SELECT
        row_number() OVER (ORDER BY col1) AS rn,
        col1
    FROM source
    ORDER BY col1 ASC
),

second_col AS (
    SELECT
        row_number() OVER (ORDER BY col2) AS rn,
        col2
    FROM source
    ORDER BY col2 ASC
)

SELECT 
    abs(col1 - col2) AS dif
FROM first_col
INNER JOIN second_col ON first_col.rn = second_col.rn
