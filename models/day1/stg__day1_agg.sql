SELECT 
    sum(dif) as answer
FROM {{ ref('stg__day1') }}