WITH src_unpivot AS (

{{ dbt_utils.unpivot(
  relation=ref('src_day2__desc'),
  cast_to='numeric',
  exclude=['record_id'],
  field_name='level',
  value_name='value'
) }}

),

recast AS (

    SELECT
        record_id,
        CAST(right(level, 1) AS NUMERIC) AS level,
        value
    FROM src_unpivot
    WHERE value IS NOT NULL

),

-- split the data into two flows based on if they start ascending or start descending

check_dif AS (

    SELECT
        record_id,
        level,
        value,
        value - lag(value, 1, value + 1) OVER (PARTITION BY record_id ORDER BY level ASC) AS dif,
        lag(value, 1, value + 1) OVER (PARTITION BY record_id ORDER BY level ASC)
    FROM recast
)

SELECT * FROM check_dif
ORDER BY record_id ASC, level ASC