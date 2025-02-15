create database HarmoniqDB
use HarmoniqDB
select *from album
select *from artist
select *from customer
select *from employee
select *from genre
select *from invoice
select *from media_type
select *from playlist
select *from playlist_track


---1.who is the senior most employee with the job title ?

select *from employee
order by levels desc

---2. which country have most invoices ?
select *from invoice

select count (*)as co ,billing_country
from invoice
group by billing_country
order by co desc

---3. what are the top 3 values of total invoices ?

select top 3 total
from invoice 
order by total desc;



--- 4.which city has the best customer ? the company would like to throw a promotional music festival
---in the city that the company made the most money.

select top 1sum(total)  invoice_total ,billing_city
from invoice 
group by billing_city
order by invoice_total desc

---5.who is the best customer ? the customer who spent the most money will be diclared the best customer 
---write a query that returns the person who has spent the most money?

SELECT TOP 1 
    c.first_name,
    c.last_name,
    c.customer_id, 
    SUM(i.total) AS total
FROM customer c
INNER JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total DESC;


---6.write a query to return the email ,first name,last name ,genre of all rock music listeners. return your 
--- list order alphabetically by email startig with A?


SELECT DISTINCT c.email, c.first_name, c.last_name
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
WHERE il.track_id IN (
    SELECT t.track_id
    FROM track t
    JOIN genre g ON t.genre_id = g.genre_id
    WHERE g.name LIKE 'Rock'
)
order by email;

----


----7.find the artist who have written the most rock music in our dataset.
select *from track

 CREATE TABLE track (
    track_id INT PRIMARY KEY,
    name VARCHAR(255),
    album_id INT,
    media_type_id INT,
    genre_id INT,
    composer VARCHAR(255),
    milliseconds INT,
    bytes INT,
    unit_price DECIMAL(3, 2)
);
INSERT INTO track (track_id, name, album_id, media_type_id, genre_id, composer, milliseconds, bytes, unit_price) VALUES
(41, 'Hand In My Pocket', 6, 1, 1, 'Alanis Morissette & Glenn Ballard', 221570, 7224246, 0.99),
(42, 'Right Through You', 6, 1, 1, 'Alanis Morissette & Glenn Ballard', 176117, 5793082, 0.99),
(43, 'Forgiven', 6, 1, 1, 'Alanis Morissette & Glenn Ballard', 300355, 9753256, 0.99),
(44, 'You Learn', 6, 1, 1, 'Alanis Morissette & Glenn Ballard', 239699, 7824837, 0.99),
(45, 'Head Over Feet', 6, 1, 1, 'Alanis Morissette & Glenn Ballard', 267493, 8758008, 0.99),
(46, 'Mary Jane', 6, 1, 1, 'Alanis Morissette & Glenn Ballard', 280607, 9163588, 0.99),
(47, 'Ironic', 6, 1, 1, 'Alanis Morissette & Glenn Ballard', 229825, 7598866, 0.99),
(48, 'Not The Doctor', 6, 1, 1, 'Alanis Morissette & Glenn Ballard', 227631, 7604601, 0.99),
(49, 'Wake Up', 6, 1, 1, 'Alanis Morissette & Glenn Ballard', 293485, 9703359, 0.99),
(5, 'Princess of the Dawn', 3, 2, 1, 'Deaffy & R.A. Smith-Diesel', 375418, 6290521, 0.99),
(50, 'You Oughta Know (Alternate)', 6, 1, 1, 'Alanis Morissette & Glenn Ballard', 491885, 16008629, 0.99),
(6, 'Put The Finger On You', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 205662, 6713451, 0.99),
(7, 'Let\s Get It Up', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 233926, 7636561, 0.99),
(8, 'Inject The Venom', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 210834, 6852860, 0.99),
(9, 'Snowballed', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 203102, 6599424, 0.99);


select *from track
select *from artist

SELECT top 10
    artist.artist_id, 
    artist.name, 
    COUNT(track.track_id) AS number_of_songs
FROM 
    track
JOIN 
    album ON album.album_id = track.album_id
JOIN 
    artist ON artist.artist_id = album.artist_id
JOIN 
    genre ON genre.genre_id = track.genre_id
WHERE 
    genre.name LIKE 'Rock'
GROUP BY 
    artist.artist_id, artist.name
ORDER BY 
    number_of_songs DESC;

----


---3.Return all the track names that have a song length longer than the average song length. 
-----Return the Name and Milliseconds for each track. Order by the song length with the longest songs
----listed first.


select name,milliseconds
from track
where milliseconds >(
select avg (milliseconds) as avg_track_length
from track)

-----
