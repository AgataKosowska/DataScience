-- analizowane dane: https://www.kaggle.com/datasets/justinas/nba-players-data
select * from nba.seasons_of_players_with_continuous_career; 
select * from nba.seasons_of_players_drafted_from_1996 sopdf;
select * from nba.nba_analysis_dataset nad
order by draft_year desc ; 
select * from players_season_data;

/*players - tabela z zawodnikami
players_season_data - tabela z poszczególnymi sezonami zawodników
seasons_of_players_drafted_from_1996 - widok wycinający zawodników, którzy brali udziału w drafcie i zaczeli karierę w 1996 lub później
seasons_of_players_with_continuous_career - widok korzystający z nba_analysis_dataset_drafted_from_1996 i prezentujący tylko zawodników, którzy zaczeli karierę zaraz po drafcie i kontynuowali ją nieprzerwania.
Jedna zawiera niezmienne dane zawodnika (players), a druga (players_season_data) dane z danego sezonu. Są połączone relacją w której players_season_data.player_id = players.id */

select * from nba.nba_analysis_dataset nad
order by draft_year desc ;

select * from table_for_location order by "avg_gp" desc
select * from table_for_location group by country;

--sprawdzanie korelacji pomiędzy wzrostem zawodników a statystykami
select corr(player_height,oreb_pct) from nba.nba_analysis_dataset nad;
select corr(player_height,gp) from nba.nba_analysis_dataset nad;
select corr(player_height,pts) from nba.nba_analysis_dataset nad;
select corr(player_height,reb) from nba.nba_analysis_dataset nad;
select corr(player_height,ast) from nba.nba_analysis_dataset nad;
select corr(player_height,net_rating) from nba.nba_analysis_dataset nad;
select corr(player_height,dreb_pct) from nba.nba_analysis_dataset nad;
select corr(player_height,usg_pct) from nba.nba_analysis_dataset nad;
select corr(player_height,ts_pct) from nba.nba_analysis_dataset nad;
select corr(player_height,ast_pct) from nba.nba_analysis_dataset nad;
select corr(player_height,player_weight) from nba.nba_analysis_dataset nad;
select corr(player_height,draft_year::real) from nba.nba_analysis_dataset nad;


--najwięcej gp w przeliczeniu na kraj dzieląc przez liczbę zawodników
select avg(gp)/count(player_name) as avg_gp_as_country, "country"  
from nba.nba_analysis_dataset nad 
group by nad."country"
order by avg_gp_as_country desc;

--najwięcej gp w przeliczeniu na uczelnię dzieląc przez liczbę zawodników
select avg(gp)/count("career_length") as avg_gp_as_college, "college"  
from nba.nba_analysis_dataset nad 
group by nad."college"
order by avg_gp_as_college desc;

--najwięcej zawodników z uczelni 
select count(DISTINCT("player_name")) as amount_of_players, "college"  
from nba.nba_analysis_dataset nad 
where "college" != 'None'
group by nad."college"
order by amount_of_players desc;

--srednia najdluzsza kariera zawodnika
with
table_career_length as (select avg(career_length) over (partition by nad."college") as career_length, player_name, "college" 
					from nba.nba_analysis_dataset nad 
					order by career_length desc)
select "college", avg(career_length)as avg_career_lenght from table_career_length 
group by table_career_length."college"
order by avg_career_lenght desc ;

--srednia najdluzsza kariera zawodnika w każdej uczelni 
select avg(career_length)/count("career_length") as avg_career_lenght, "college"  
from nba.nba_analysis_dataset nad 
where "college" != 'No College'
group by nad."college"
order by avg_career_lenght desc;

 --najwięcej ast w przeliczeniu na kraj dzieląc przez liczbę zawodników
select avg(ast)/count(player_name) as avg_ast_as_country, "country"  
from nba.nba_analysis_dataset nad 
group by nad."country"
order by avg_ast_as_country desc;

--najwięcej ast w przeliczeniu na uczelnię dzieląc przez liczbę zawodników
select avg(ast)/count("career_length") as avg_ast_as_college, "college"  
from nba.nba_analysis_dataset nad 
group by nad."college"
order by avg_ast_as_college desc;

 --najwięcej ast_pct w przeliczeniu na kraj dzieląc przez liczbę zawodników
select avg(ast_pct)/count(player_name) as avg_ast_pct_as_country, "country"  
from nba.nba_analysis_dataset nad 
group by nad."country"
order by avg_ast_pct_as_country desc;

--najwięcej ast_pct w przeliczeniu na uczelnię dzieląc przez liczbę zawodników
select avg(ast_pct)/count("career_length") as avg_ast_pct_as_college, "college"  
from nba.nba_analysis_dataset nad 
group by nad."college"
order by avg_ast_pct_as_college desc;

 --najwięcej oreb_pct w przeliczeniu na kraj dzieląc przez liczbę zawodników
select avg(oreb_pct)/count(player_name) as avg_oreb_pct_as_country, "country"  
from nba.nba_analysis_dataset nad 
group by nad."country"
order by avg_oreb_pct_as_country desc;

--najwięcej oreb_pct w przeliczeniu na uczelnię dzieląc przez liczbę zawodników
select avg(oreb_pct)/count("career_length") as avg_oreb_pct_as_college, "college"  
from nba.nba_analysis_dataset nad 
group by nad."college"
order by avg_oreb_pct_as_college desc;







