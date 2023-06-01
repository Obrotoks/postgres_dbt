


with final as (
    select 
        distinct num_age
    from {{ source('InfoClients','newclients')}}
)
select * 
from final