 
 select * from data1
  select * from data1
 -- Counting No. of Rows -- 
select count(*) from data1

-- Population of India
select sum(population) as Total_population from data2

-- Average Growth % of India
select  avg(growth)*100 as avg_growth_pct from data1

-- Average Growth % of Indian States
select state, avg(growth)*100 as avg_growth_pct from data1
group by state 
order by avg_growth_pct desc

-- Average Sex Ratio
select state, round(avg(Sex_ratio),0) as avg_sex_ratio from data1
group by state 
order by avg_sex_ratio desc

-- Average Litreracy Rate
select state, round(avg(literacy),0) as avg_literacy_rate from data1
group by state 
order by avg_literacy_rate desc

-- top 3 state showing highest growth ratio


select state,avg(growth)*100 avg_growth from data1 
group by state order by avg_growth desc 
limit 3;


-- bottom 3 state showing lowest sex ratio

select state,round(avg(sex_ratio),0) avg_sex_ratio from data1
group by state order by avg_sex_ratio asc
limit 3;





-- states starting with letter a

select distinct state from data1 where lower(state) like 'a%' or lower(state) like 'b%'

select distinct state from data1 where lower(state) like 'a%' and lower(state) like '%m'


-- joining both table

-- total males and females

select d.state,sum(d.males) total_males,sum(d.females) total_females from
(select c.district,c.state state,round(c.population/(c.sex_ratio+1),0) males, 
round((c.population*c.sex_ratio)/(c.sex_ratio+1),0) females from
(select a.district,a.state,a.sex_ratio/1000 sex_ratio,b.population from data1 a 
inner join data2 b on a.district=b.district ) c) d
group by d.state;

-- total literacy rate

select c.state,sum(literate_people) total_literate_pop,sum(illiterate_people) total_lliterate_pop from 
(select d.district,d.state,round(d.literacy_ratio*d.population,0) literate_people,
round((1-d.literacy_ratio)* d.population,0) illiterate_people from
(select a.district,a.state,a.literacy/100 literacy_ratio,b.population from data1 a 
inner join data2 b on a.district=b.district) d) c
group by c.state

-- population in previous census


 select sum(m.previous_census_population) previous_census_population,sum(m.current_census_population) current_census_population from(
 select e.state,sum(e.previous_census_population) previous_census_population,sum(e.current_census_population) current_census_population from
 (select d.district,d.state,round(d.population/(1+d.growth),0) previous_census_population,d.population current_census_population from
 (select a.district,a.state,a.growth growth,b.population from data1 a inner join data2 b on a.district=b.district) d) e
 group by e.state)m





