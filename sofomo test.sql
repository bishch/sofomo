select
  dimension_1
, dimension_2
, sum(measure_1) as measure_1
, sum(measure_2) as measure_2 
	from(
		select 
			  a.dimension_1
			, (select top 1 correct_dimension_2 
				from Table_MAP m where m.dimension_1 = a.dimension_1) 
					as dimension_2
			, a.measure_1
			, 0 as measure_2 
		from Table_A a
	union all
		select 
			  b.dimension_1
			, (select top 1 correct_dimension_2
				from Table_MAP m where m.dimension_1 = b.dimension_1) 
					as dimension_2
			, 0 as measure_1
			, b.measure_2 
		from Table_B b
		)a
group by
dimension_1, dimension_2
