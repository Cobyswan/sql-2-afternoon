-- Returns invoice prices greater than 0.99$
select unit_price from invoice_line
where unit_price > 0.99

---- Get the invoice_date, customer first_name and last_name, and total from all invoices.
select invoice_date, first_name, last_name, total from invoice
join customer
on customer.customer_id = invoice.customer_id;

-- Get the customer first_name and last_name and the support rep's first_name and last_name from all customers.
select customer.first_name as customer_first_name, customer.last_name as customer_last_name, employee.first_name as reps_first_name, employee.last_name as reps_last_name from customer
join employee
on customer.support_rep_id = employee.employee_id

-- Get the album title and the artist name from all albums.
select album.title as album, artist.name as artist from album
join artist
on album.artist_id = artist.artist_id;

-- Get all playlist_track track_ids where the playlist name is Music.
select playlist_track_id, playlist.name from playlist_track
join playlist
on playlist_track.playlist_id = playlist.playlist_id
where playlist.name = 'Music'

-- Get all track names for playlist_id 5.
select name as Track_Name from track 
join playlist_track
on track.track_id = playlist_track.track_id
where playlist_track_id = 5

-- Get all track names and the playlist name that they're on ( 2 joins ).
select t.name as track_name, p.name as playlist_name from track t
join playlist_track pt on pt.track_id = t.track_id
join playlist p on p.playlist_id = pt.playlist_id;

-- Get all track names and album titles that are the genre Alternative & Punk ( 2 joins ).
select t.name as track_name, a.title as album_title from track t 
join album a on t.album_id = a.album_id
join genre g on t.genre_id = g.genre_id;

-- BLACK DIAMOND Get all tracks on the playlist(s) called Music and show their name, genre name, album name, and artist name. (atleast 5 joins)



-- Get all invoices where the unit_price on the invoice_line is greater than $0.99.
SELECT *
FROM invoice
WHERE invoice_id IN ( SELECT invoice_id FROM invoice_line WHERE unit_price > 0.99 );

-- Get all playlist tracks where the playlist name is Music.
select * from playlist_track
where playlist_id in (select playlist_id from playlist where name = 'Music')

-- Get all track names for playlist_id 5.
select t.name from track t
where t.track_id in (select track_id from playlist_track where track_id = 5)


-- Get all tracks where the genre is Comedy.
select * from track
where genre_id in (select genre_id from genre where name = 'Comedy')

-- Get all tracks where the album is Fireball.
select * from track
where album_id in (select album_id from album where title = 'Fireball')

--Get all tracks for the artist Queen ( 2 nested subqueries ).
select * from track
where album_id in (select album_id from album where artist_id in (select artist_id from artist where name = 'Queen' ))

-- Find all customers with fax numbers and set those numbers to null.
update customer
set fax = null

-- Find all customers with no company (null) and set their company to "Self".
update customer
set company = 'Self'
where company = null;

-- Find the customer Julia Barnett and change her last name to Thompson.
update customer
set last_name = 'Thompson'
where customer_id = 28; -- Julias customer ID is 28

-- Find the customer with this email luisrojas@yahoo.cl and change his support rep to 4.
update customer
set support_rep_id = 4
where email = 'luisrojas@yahoo.cl'

-- Find all tracks that are the genre Metal and have no composer. Set the composer to "The darkness around us".
update track
set composer = 'The darkness around us'
where genre_id = (select genre_id from genre where name = 'Metal') and composer = null;

-- Find a count of how many tracks there are per genre. Display the genre name with the count.
select count(*), g.name from track t
join genre g on t.genre_id = g.genre_id
group by g.name

-- Find a count of how many tracks are the "Pop" genre and how many tracks are the "Rock" genre.
select count(*), g.name from track t 
join genre g on t.genre_id = g.genre_id
where g.name = 'Pop' or g.name = 'Rock'
group by g.name
