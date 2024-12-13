with source AS (
    SELECT * FROM {{ ref('stg__day3') }}
),
transform AS (
    SELECT
        REGEXP_SUBSTR(payload, '\\d{1,3}', 1, 1) AS number_1,
        REGEXP_SUBSTR(payload, '\\d{1,3}', 1, 2) AS number_2 
    FROM source

)

SELECT 
    sum(number_1*number_2) AS answer
FROM transform