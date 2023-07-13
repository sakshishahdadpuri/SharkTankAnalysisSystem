USE SHARKTANKPROJECT;
SELECT * FROM SHARKTANK;
SET @counter := 1;
UPDATE SHARKTANK
SET Epno =(@counter := @counter+1)
ORDER by Epno;

-- QUESTIONS 
-- total episodes conducted
SELECT COUNT(distinct Epno) FROM SHARKTANK;

-- pitches that got fundings
SELECT DISTINCT BRAND,AmountInvestedlakhs FROM SHARKTANK WHERE AmountInvestedlakhs > 0;

-- were the pitches converted or not 
SELECT BRAND, CASE WHEN AMOUNTINVESTEDLAKHS>0 THEN "yes" ELSE "no" END AS converted_not_converted from sharktank;

-- how much percent people got fundings from sharks

SELECT CAST(SUM(A.CONVERTED_NOT_CONVERTED)AS FLOAT)/CAST(COUNT(*) AS FLOAT) FROM(
SELECT AMOUNTINVESTEDLAKHS , 
CASE WHEN AMOUNTINVESTEDLAKHS>0 
	THEN 1 
ELSE 0 
END 
AS CONVERTED_NOT_CONVERTED FROM SHARKTANK) A;


-- total number of male participants
select sum(male) from sharktank;

-- total female participants
select sum(female) from sharktank;

-- gender ratio
select sum(female)/sum(male) from sharktank;

-- total amount invested
select sum(AmountInvestedlakhs) from sharktank;

-- avg equity taken
select avg(a.EquityTaken) from (
select * from sharktank where EquityTaken>0) a;

-- highest deal taken
select max(AmountInvestedlakhs) from sharktank;

-- how many participant teams had atleast one women 
select sum(female_count) where female = ( 
(select female,case when female>0 then 1 else 0 end as female_count from sharktank));

--  avg team members
select avg(teammembers) from sharktank;


-- amount invested per deal
select avg(a.AmountInvestedlakhs) as "amount_invested_per_deal" from(
(select * from sharktank where deal!='No Deal')) a;

-- which age group is seen to come more at sharktank
select avgage,count(avgage) cnt from sharktank group by avgage order by cnt desc;

-- location group of contestants from where more contestants are coming
select location,count(location) count from sharktank group by location order by count desc limit 1;

-- which sector has most startups coming from
select sector,count(sector) cnt from sharktank group by sector order by cnt desc limit 1;

-- partner deals (max deals together)
select partners,count(partners) as cnt from sharktank where partners!='-' group by partners order by cnt desc;

-- making the matrix
-- total number of deals in which ashneer was present
 select count(AshneerAmountInvested) as totalDealsPresent from sharktank where AshneerAmountInvested IS NOT NULL;
 
 -- number of deals in which ashneer invested
 select count(AshneerAmountInvested) as totalAmountInvested from sharktank where AshneerAmountInvested>0 and AshneerAmountInvested IS NOT NULL;
 
 -- total deals present and total deals taken together
 
select a.keyy,a.total_deals_present,b.total_deals from(
select 'Ashnner' as keyy , count(AshneerAmountInvested) total_deals_present from sharktank where AshneerAmountInvested IS NOT NULL) a
inner join(
select 'Ashnner' as keyy,count(AshneerAmountInvested) total_deals from sharktank
where AshneerAmountInvested IS NOT NULL AND AshneerAmountInvested!=0) b
on a.keyy=b.keyy;
 
 -- ramking the brands which are present in different sectors
 