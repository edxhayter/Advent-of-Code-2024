WITH source AS (

    SELECT
        row_number() over (ORDER BY NULL) AS record_id,
        *
    FROM {{ ref('day2') }}
)

SELECT * FROM source