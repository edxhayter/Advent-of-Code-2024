WITH source_asc AS (

    SELECT
        *
    FROM {{ ref('stg_day2__unpivot_asc') }}

),

source_desc AS (

    SELECT
        *
    FROM {{ ref('stg_day2__unpivot_desc') }}
),

-- identify the min and max diferences 
-- ensure min dif is greater than 0 and max dif is less than 3 
diff_summary_asc AS (

    SELECT 
        record_id,
        min(dif) as min_dif,
        max(dif) as max_dif
    FROM source_asc
    GROUP BY 1

),

diff_summary_desc AS (

    SELECT 
        record_id,
        min(dif) as min_dif,
        max(dif) as max_dif
    FROM source_desc
    GROUP BY 1

),

final AS (
    
SELECT 
    record_id,
    'asc' as direction
FROM diff_summary_asc
WHERE min_dif > 0 
AND max_dif < 4
GROUP BY 1
UNION ALL
SELECT
    record_id,
    'desc' as direction
FROM diff_summary_desc
WHERE max_dif < 0
AND min_dif > -4
GROUP BY 1

)

SELECT count(*) as answer FROM final