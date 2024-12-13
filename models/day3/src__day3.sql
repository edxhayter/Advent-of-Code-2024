with 

source as (

    select * from {{ source('advent_of_code', 'raw__day3') }}

),

renamed as (

    select
        dump

    from source

)

select * from renamed
