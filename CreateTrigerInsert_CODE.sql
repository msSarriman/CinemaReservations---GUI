DROP DATABASE IF EXISTS cinema;
CREATE database cinema;
use cinema;

CREATE TABLE Movies (
    movie_ID BIGINT(11) NOT NULL AUTO_INCREMENT,
    movie_title VARCHAR(100) NOT NULL,
    movie_plot TEXT NOT NULL,
    movie_url TEXT NOT NULL,
    movie_release DATE NOT NULL,
    PRIMARY KEY (movie_ID)
)  engine=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE movie_Genres (
    movie_genre SET('Action', 'Adventure', 'Animation', 'Biography', 'Comedy', 'Crime', 'Documentary', 'Drama', 'Family', 'Fantasy', 'History', 'Horror', 'Musical', 'Mystery', 'Romance', 'Sci-Fi', 'Sport', 'Thriller', 'War', 'Western') NOT NULL,
    mg_movie BIGINT(11) NOT NULL,
    PRIMARY KEY (movie_genre , mg_movie),
    CONSTRAINT MoviesKeyForMovieGenres FOREIGN KEY (mg_movie)
        REFERENCES Movies (movie_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
)  engine=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Movie_Awards (
    maw_title VARCHAR(50) NOT NULL,
    maw_description VARCHAR(200) NOT NULL,
    PRIMARY KEY (maw_title)
)  engine=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE movie_nominated (
    mn_movie BIGINT(11) NOT NULL,
    mn_award VARCHAR(50) NOT NULL,
    mn_nominee_date DATE NOT NULL,
    mn_nominee_condition SET('Nominated', 'Won') NOT NULL,
    PRIMARY KEY (mn_award , mn_movie),
    CONSTRAINT MovieskeyForMovieNominated FOREIGN KEY (mn_movie)
        REFERENCES Movies (movie_ID),
    CONSTRAINT AwardsKeyForMovieNominated FOREIGN KEY (mn_award)
        REFERENCES Movie_Awards (maw_title)
        ON DELETE CASCADE ON UPDATE CASCADE
)  engine=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Artist (
    artist_ID INT(11) NOT NULL AUTO_INCREMENT,
    artist_name VARCHAR(30) NOT NULL,
    artist_surname VARCHAR(30) NOT NULL,
    artist_biography TEXT NOT NULL,
    artist_picurl VARCHAR(300) NOT NULL,
    artist_dob DATE NOT NULL,
    PRIMARY KEY (artist_ID)
)  engine=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE artist_specialization (
    as_artist_ID INT(11) NOT NULL,
    as_specialization VARCHAR(30) NOT NULL,
    PRIMARY KEY (as_artist_ID , as_specialization),
    CONSTRAINT ArtistKeyForArtistSpecialization FOREIGN KEY (as_artist_ID)
        REFERENCES Artist (artist_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
)  engine=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Artist_Awards (
    aaw_title VARCHAR(50) NOT NULL,
    aaw_summary VARCHAR(200) NOT NULL,
    PRIMARY KEY (aaw_title)
)  engine=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Artist_Nominated (
    an_aaw_title VARCHAR(50) NOT NULL,
    an_artist_ID INT(11) NOT NULL,
    an_date DATE NOT NULL,
    an_condition ENUM('Nominated', 'won'),
    PRIMARY KEY (an_aaw_title , an_artist_ID),
    CONSTRAINT ArtistAwardsKeyArtistNominated FOREIGN KEY (an_aaw_title)
        REFERENCES Artist_Awards (aaw_title),
    CONSTRAINT ArtistKeyForArtistNominated FOREIGN KEY (an_artist_ID)
        REFERENCES Artist (artist_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
)  engine=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Directed (
    dir_artist_ID INT(11) NOT NULL,
    dir_movie_ID BIGINT(11) NOT NULL,
    PRIMARY KEY (dir_artist_ID , dir_movie_ID),
    CONSTRAINT ArtistKeyForDirected FOREIGN KEY (dir_artist_ID)
        REFERENCES Artist (artist_ID),
    CONSTRAINT MoviesKeyForDirected FOREIGN KEY (dir_movie_ID)
        REFERENCES Movies (movie_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
)  engine=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Casting (
    casting_artist_ID INT(11) NOT NULL,
    casting_movie_ID BIGINT(11) NOT NULL,
    PRIMARY KEY (casting_artist_ID , casting_movie_ID),
    CONSTRAINT ArtistKeyForCasting FOREIGN KEY (casting_artist_ID)
        REFERENCES Artist (artist_ID),
    CONSTRAINT MoviesKeyForCasting FOREIGN KEY (casting_movie_ID)
        REFERENCES Movies (movie_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
)  engine=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Staff (
    staff_ID INT(11) NOT NULL AUTO_INCREMENT,
    staff_name VARCHAR(30) NOT NULL,
    staff_surname VARCHAR(30) NOT NULL,
    staff_phone BIGINT(12) NOT NULL,
    staff_adress VARCHAR(255) NOT NULL,
    staff_bankacc VARCHAR(30) NOT NULL,
    staff_bio TEXT NOT NULL,
    staff_exp TEXT NOT NULL,
    staff_recdt DATE NOT NULL,
    staff_years_of_service INT(2) NOT NULL DEFAULT '0',
    PRIMARY KEY (staff_id)
)  engine=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Salary (
    salary_staff_ID INT(11) NOT NULL,
    salary_payment_ID BIGINT(20) ZEROFILL NOT NULL AUTO_INCREMENT,
    salary_month ENUM('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December') NOT NULL,
    salary_year YEAR(4) NOT NULL,
	salary_money FLOAT(8 , 2 ) NOT NULL,
	salary_hours INT(11) NOT NULL DEFAULT 10,
    PRIMARY KEY (salary_payment_ID, salary_staff_ID),
    CONSTRAINT StaffKeyForSalary FOREIGN KEY (salary_staff_ID)
        REFERENCES Staff (staff_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
)  engine=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Stage (
    st_name VARCHAR(255) NOT NULL,
    st_floor TINYINT(1) NOT NULL,
    st_3Dsupport ENUM('Yes', 'No') NOT NULL,
    st_aircondition_status ENUM('Yes', 'No') NOT NULL,
    st_capacity SMALLINT(5) NOT NULL,
    st_availability ENUM('Available', 'Not Available'),
    PRIMARY KEY (st_name)
)  engine=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE TimeTable (
	timetable_movie_ID BIGINT(11) NOT NULL,
	timetable_weaktimetablekey INT(10) AUTO_INCREMENT,
	timetable_date DATE NOT NULL DEFAULT '2000-10-10',
	timetable_starttime TIME NOT NULL,
	timetable_endtime TIME NOT NULL,
	timetable_movietype VARCHAR(3) NOT NULL,
	timetable_stage VARCHAR(255) NOT NULL,
	PRIMARY KEY(timetable_weaktimetablekey, timetable_movie_id, timetable_stage),
	CONSTRAINT MoviesKeyForTimeTable FOREIGN KEY(timetable_movie_id)
		REFERENCES Movies (movie_id),
	CONSTRAINT StageKeyForTimeTable FOREIGN KEY(timetable_stage)
		REFERENCES Stage(st_name)
        ON DELETE CASCADE ON UPDATE CASCADE
)  engine=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Seats (
    seat_st_name VARCHAR(255) NOT NULL,
    seat_number VARCHAR(3) NOT NULL,
    seat_heightposition ENUM('High', 'Core', 'Low'),
    seat_zone ENUM('Left', 'Center', 'Right'),
    seat_sidewalk_status ENUM('Yes', 'No'),
    PRIMARY KEY (seat_st_name , seat_number),
    CONSTRAINT StageKeyForSeats FOREIGN KEY (seat_st_name)
        REFERENCES Stage (st_name)
        ON DELETE CASCADE ON UPDATE CASCADE
)  engine=InnoDB DEFAULT CHARSET=utf8;

CREATE INDEX seat_index ON Seats (seat_number);

CREATE TABLE Customer (
    customer_tabID INT(11) NOT NULL AUTO_INCREMENT,
    customer_name VARCHAR(30) NOT NULL,
    customer_surname VARCHAR(30) NOT NULL,
    customer_date DATE NOT NULL,
    customer_cardID BIGINT(20) NOT NULL,
    customer_sex ENUM('Male', 'Female') NOT NULL,
    customer_status SET('Married', 'Student', 'Single', 'Senior') NOT NULL,
    customer_favoriteGenre SET('Action', 'Adventure', 'Animation', 'Biography', 'Comedy', 'Crime', 'Documentary', 'Drama', 'Family', 'Fantasy', 'History', 'Horror', 'Musical', 'Mystery', 'Romance', 'Sci-Fi', 'Sport', 'Thriller', 'War', 'Western') NOT NULL,
    customer_email VARCHAR(30) NOT NULL,
    customer_phone BIGINT(12) NOT NULL,
	customer_dob DATE NOT NULL,
    PRIMARY KEY (customer_tabID)
)  engine=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE CustomerHistory (
    customerhistory_customer_tabID INT(11) NOT NULL AUTO_INCREMENT,
    customerhistory_history VARCHAR(30),
    PRIMARY KEY (customerhistory_customer_tabID, customerhistory_history),
    CONSTRAINT CustomerKey FOREIGN KEY (customerhistory_customer_tabID)
        REFERENCES Customer (customer_tabID)
        ON DELETE CASCADE ON UPDATE CASCADE
)  engine=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Card (
    card_customer_tabID INT(11) NOT NULL,
    card_ID BIGINT(20) NOT NULL,
    card_points INT(11) DEFAULT '0',
	card_total_bonus_tickets INT(3) DEFAULT '0',
	card_total_bonus_tickets_taken INT(3) DEFAULT '0',
    PRIMARY KEY (card_customer_tabID , card_ID),
    CONSTRAINT CustomerKeyForCard FOREIGN KEY (card_customer_tabID)
        REFERENCES Customer (customer_tabID)
        ON DELETE CASCADE ON UPDATE CASCADE
)  engine=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Rated (
    rated_movie_ID BIGINT(11) NOT NULL,
    rated_customer_tabID INT(11) NOT NULL,
    rated_customerRatio FLOAT(2 , 1 ) NOT NULL,
    PRIMARY KEY (rated_movie_ID , rated_customer_tabID),
    CONSTRAINT MoviesIDforRated FOREIGN KEY (rated_movie_ID)
        REFERENCES Movies (movie_ID),
    CONSTRAINT CustomerKeyforRated FOREIGN KEY (rated_customer_tabID)
        REFERENCES Customer (customer_tabID)
        ON DELETE CASCADE ON UPDATE CASCADE
)  engine=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE StageOrders (
    stageorder_staff_ID INT(11) NOT NULL,
	stageorder_days ENUM('Monday' ,'Tuesday' , 'Wednesday' , 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL,
    stageorder_shift ENUM('Morning', 'Afternoon') NOT NULL,
    stageorder_date DATE NOT NULL,
	stageorder_shift_time TIME NOT NULL,
    PRIMARY KEY (stageorder_staff_ID, stageorder_date),
	CONSTRAINT StaffkeyInStageOrders FOREIGN KEY (stageorder_staff_ID)
		REFERENCES Staff (staff_ID)
)  engine=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE SuperVisor (
    supervisor_staff_ID INT(11) NOT NULL,
	supervisor_days ENUM('Monday' ,'Tuesday' , 'Wednesday' , 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL,
    supervisor_shift ENUM('Morning', 'Afternoon') NOT NULL,
    supervisor_notes TEXT,
    supervisor_date DATE NOT NULL,
    PRIMARY KEY (supervisor_staff_ID, supervisor_date),
	CONSTRAINT StaffkeyInSupervisor FOREIGN KEY (supervisor_staff_ID)
		REFERENCES Staff (staff_ID)
)  engine=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE TicketSeller (
    ticketseller_staff_ID INT(11) NOT NULL,
    ticketseller_days ENUM('Monday' ,'Tuesday' , 'Wednesday' , 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL,
    ticketseller_shift ENUM('Morning', 'Afternoon') NOT NULL,
    ticketseller_ticketsSold INT(11) DEFAULT '0',
	ticketseller_date DATE NOT NULL,
	ticketseller_shift_time TIME NOT NULL,
    PRIMARY KEY (ticketseller_staff_ID, ticketseller_date),
	CONSTRAINT StaffkeyInTickeSeller FOREIGN KEY (ticketseller_staff_ID)
		REFERENCES Staff (staff_ID)
)  engine=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Cleaner (
    cleaner_staff_ID INT(11) NOT NULL,
	cleaner_days ENUM('Monday' ,'Tuesday' , 'Wednesday' , 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL,
    cleaner_shift ENUM('Morning', 'Afternoon') NOT NULL,
	cleaner_date DATE NOT NULL,
	cleaner_shift_time TIME NOT NULL,
    PRIMARY KEY (cleaner_staff_ID, cleaner_date),
	CONSTRAINT StaffkeyInCleaner FOREIGN KEY (cleaner_staff_ID)
		REFERENCES Staff (staff_ID)
)  engine=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Tickets (
	ticket_customer_tabID INT(11) NOT NULL, 
    ticket_movie_ID BIGINT(11) NOT NULL,
	ticket_stage VARCHAR(30),
    ticket_seat_number VARCHAR(3) NOT NULL,
    ticket_number INT(11) NOT NULL AUTO_INCREMENT,
    ticket_price DOUBLE(5,2) NOT NULL DEFAULT '0.0',
    ticket_type VARCHAR(30) DEFAULT 'Regular',
    ticket_starttime TIME NOT NULL,
    ticket_endtime TIME,
	ticket_bonpoints DOUBLE(5,2),
	ticket_date DATE NOT NULL DEFAULT '2010-10-10',
	ticket_kind VARCHAR(3),
    PRIMARY KEY (ticket_number, ticket_customer_tabID, ticket_movie_ID, ticket_seat_number),
    CONSTRAINT CustomerKeyForTickets FOREIGN KEY (ticket_customer_tabID)
        REFERENCES Customer (customer_tabID),
	CONSTRAINT MovieKeyForTickets FOREIGN KEY (ticket_movie_ID)
        REFERENCES Movies (movie_ID),
	CONSTRAINT StageKeyForTickets FOREIGN KEY (ticket_stage)
        REFERENCES Stage (st_name),
	CONSTRAINT SeatsKeyForTickets FOREIGN KEY (ticket_seat_number)
		REFERENCES Seats (seat_number)
        ON DELETE CASCADE ON UPDATE CASCADE
)  engine=InnoDB DEFAULT CHARSET=utf8; 

-- Eisagwgh Trigger
DROP TRIGGER IF EXISTS BonusPointsAndDiscountRegardingCustomerStatus;
DROP TRIGGER IF EXISTS BonusTicketRealizer;

DELIMITER $

CREATE TRIGGER BonusPointsAndCardPointsSum BEFORE INSERT ON Tickets
FOR EACH ROW
BEGIN
	DECLARE tickettypediscount VARCHAR(15);
	DECLARE tickettypeprice VARCHAR(3);
	DECLARE ticketstage VARCHAR(255);
	DECLARE ticketendtime TIME;

	-- Ticket Stage auto-setting according to customer's movie choise.	
	SET @ticketstage = (SELECT timetable_stage
		FROM TimeTable
		WHERE timetable_movie_ID = NEW.ticket_movie_ID AND timetable_starttime = NEW.ticket_starttime AND timetable_date = NEW.ticket_date);
	SET NEW.ticket_stage = @ticketstage;
	-- End of Ticket Stage auto-setting according to customer's movie choise.	

	-- Ticket End Time auto-setting according timetable.	
	SET @ticketendtime = (SELECT timetable_endtime 
		FROM TimeTable
		WHERE NEW.ticket_movie_ID = timetable_movie_ID AND NEW.ticket_starttime = timetable_starttime AND NEW.ticket_date = timetable_date);
	SET NEW.ticket_endtime = @ticketendtime;
	-- End of "Ticket End Time auto-setting according timetable".

	-- Ticket Initial Price auto-setting according to timetable_movietype starts from here.	
	SET @tickettypeprice = (SELECT timetable_movietype
		FROM TimeTable
		WHERE timetable_movie_ID = NEW.ticket_movie_ID AND timetable_date = NEW.ticket_date AND timetable_starttime = NEW.ticket_starttime);
	SET NEW.ticket_kind = @tickettypeprice;
	IF @tickettypeprice LIKE '3D' THEN
		SET NEW.ticket_price=40;
	ELSE
		SET NEW.ticket_price=20;
	END IF;	
	-- Ticket Initial Price auto-setting according to timetable_movietype ends here.	
	-- ----------------------------------------------------------------------
	-- Ticket Discount code according to customer status starts here.
	SET @tickettypediscount = (SELECT customer_status 
		FROM Customer
		WHERE NEW.ticket_customer_tabID = customer_tabID);
	SET NEW.ticket_type = @tickettypediscount;
	IF  NEW.ticket_type LIKE 'Student' THEN
		SET NEW.ticket_price = NEW.ticket_price * 0.75;
	ELSEIF  NEW.ticket_type LIKE 'Senior' THEN
		SET NEW.ticket_price=NEW.ticket_price * 0.90;	
	END IF;
	-- Ticket Discount code according to customer status ends here.
	-- -----------------------------------------------------------

	-- Bonus Points Summary and collection of them at the card--
	IF @tickettypeprice LIKE '2D' THEN
    SET NEW.ticket_bonpoints = NEW.ticket_price * 0.10;
	
		UPDATE Card 
			SET card_points = (NEW.ticket_bonpoints + card_points)
			WHERE NEW.ticket_customer_tabID=card_customer_tabID;

	ELSE
	SET NEW.ticket_bonpoints = NEW.ticket_price * 0.15;
	
		UPDATE Card 
			SET card_points = (NEW.ticket_bonpoints + card_points)
			WHERE NEW.ticket_customer_tabID=card_customer_tabID;

	END IF;
	-- Bonus points summary end.--

END$

CREATE TRIGGER BonusTicketRealizer BEFORE UPDATE ON Card
FOR EACH ROW
BEGIN 
	IF NEW.card_points > 50 THEN
				SET NEW.card_total_bonus_tickets = ( NEW.card_total_bonus_tickets + 1 );
				SET NEW.card_points =  NEW.card_points - 40 ;
	END IF;
END $
DELIMITER ;

USE `cinema`;

INSERT INTO `cinema`.`Movies` (`movie_title`, `movie_plot`, `movie_url`, `movie_release`) VALUES ('The Two Jakes', 'The sequel to Chinatown (1974) finds Jake Gittes investigating adultery and murder... and the money that comes from oil.', 'http://www.imdb.com/title/tt0100828/?ref_=nm_flmg_dr_1', '1991-11-21'),
('Goin\' South', 'Henry Moon is captured for a capital offense by a posse when his horse quits while trying to escape to Mexico. He finds that there is a post-Civil War law in the small town that any single or widowed woman can save him from the gallows by marrying him. Julia Tate needs a man to help her work her mine and marries him. The sheriff makes it very clear to Moon what the consequences of his leaving Julia will be. The two begin to try to form a relationship based on necessity in which they have nothing in common.', 'http://www.imdb.com/title/tt0077621/?ref_=nm_flmg_dr_2', '1978-09-06'),
('Drive, He Said', 'Hector is a star basketball player for the College basketball team he plays for, the Leopards. His girlfriend, Olive, doesn\'t know whether to stay with him or leave him. And his friend, Gabriel, who may have dropped out from school and become a protestor, wants desperately not to get drafted for Vietnam.', 'http://www.imdb.com/title/tt0068509/?ref_=nm_flmg_dr_3', '1971-05-28'),
('The Terror', '\nA young officer in Napoleon\'s army pursues a mysterious woman to the castle of an elderly Baron.', 'http://www.imdb.com/title/tt0057569/?ref_=nm_flmg_dr_4', '1963-05-16'),
('One-Eyed Jacks', 'After robbing a Mexican bank, Dad Longworth takes the loot and leaves his partner Rio to be captured but Rio escapes and searches for Dad in California.', 'http://www.imdb.com/title/tt0055257/?ref_=nm_flmg_dr_1', '1961-03-30'),
('The Good Shepherd', '\nThe tumultuous early history of the Central Intelligence Agency is viewed through the prism of one man\'s life.', 'http://www.imdb.com/title/tt0343737/?ref_=nm_flmg_dr_1', '2007-02-23'),
('A Bronx Tale', 'A father becomes worried when a local gangster befriends his son in the Bronx in the 1960s.', 'http://www.imdb.com/title/tt0106489/?ref_=nm_flmg_dr_2', '1993-02-18'),
('Salome', 'The Biblical story of Salome, a girl who agrees to perform the \"dance of the seven veils\" in return for John the Baptist\'s head on a silver platter.', 'http://www.imdb.com/title/tt3112900/?ref_=nm_flmg_dr_1', '2014-09-21'),
('Chinese Coddee', 'Harry and Jake, two unsuccessful writers, spend a cathartic evening arguing about money, aesthetics, their friendship, and Harry\'s new manuscript.', 'http://www.imdb.com/title/tt0118852/?ref_=nm_flmg_dr_3', '2000-09-02'),
('Looking For Richard', '\nAl Pacino\'s deeply-felt rumination on Shakespeare\'s significance and relevance to the modern world through interviews and an in-depth analysis of \"Richard III.\"', 'http://www.imdb.com/title/tt0116913/?ref_=nm_flmg_dr_4', '1996-01-31'),
('The Shining', 'A family heads to an isolated hotel for the winter where an evil and spiritual presence influences the father into violence, while his psychic son sees horrific forebodings from the past and of the future.', 'http://www.imdb.com/title/tt0081505/?ref_=nm_knf_i1', '1980-11-07'),
('The Godfather', 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.', 'http://www.imdb.com/title/tt0068646/?ref_=nm_knf_i1', '1972-08-24'),
('Goodfellas', 'Henry Hill and his friends work their way up through the mob hierarchy.', 'http://www.imdb.com/title/tt0099685/?ref_=nm_knf_i1', '1990-10-26'),
('There Will Be Blood', '\nA story of family, religion, hatred, oil and madness, focusing on a turn-of-the-century prospector in the early days of the business.', 'http://www.imdb.com/title/tt0469494/?ref_=nm_knf_t1', '2007-02-15'),
('No Country for Old Men', 'Violence and mayhem ensue after a hunter stumbles upon a drug deal gone wrong and more than two million dollars in cash near the Rio Grande.', 'http://www.imdb.com/title/tt0477348/?ref_=nm_knf_i1', '2007-01-18'),
('The Silence of The Lambs', '\nA young F.B.I. cadet must confide in an incarcerated and manipulative killer to receive his help on catching another serial killer who skins his victims.', 'http://www.imdb.com/title/tt0102926/?ref_=fn_al_nm_1a', '1991-05-31'),
('We are the Millers', 'A veteran pot dealer creates a fake family as part of his plan to move a huge shipment of weed into the U.S. from Mexico.', 'http://www.imdb.com/title/tt1723121/?ref_=nm_knf_t2', '2013-08-23'),
('Horrible Bosses', 'Three friends conspire to murder their awful bosses when they realize they are standing in the way of their happiness.', 'http://www.imdb.com/title/tt1499658/?ref_=nm_flmg_act_12', '2011-07-22'),
('The Sting', 'In Chicago in September 1936, a young con man seeking revenge for his murdered partner teams up with a master of the big con to win a fortune from a criminal banker.', 'http://www.imdb.com/title/tt0070735/?ref_=nm_knf_t1', '1973-12-26'),
('Maleficent', 'A vengeful fairy is driven to curse an infant princess, only to discover that the child may be the one person who can restore peace to their troubled land.', 'http://www.imdb.com/title/tt1587310/?ref_=nm_knf_i1', '2014-05-28'),
('Mr. & Mrs. Smith ', '\nA bored married couple is surprised to learn that they are both assassins hired by competing agencies to kill each other.', 'http://www.imdb.com/title/tt0356910/?ref_=nm_knf_i3', '2005-06-10'),
('Salt', 'A CIA agent goes on the run after a defector accuses her of being a Russian spy.', 'http://www.imdb.com/title/tt0944835/?ref_=nm_knf_i4', '2010-08-18'),
('Rebecca', '\nA self-conscious bride is tormented by the memory of her husband\'s dead first wife.', 'http://www.imdb.com/title/tt0032976/?ref_=nm_knf_i1', '1940-12-12'),
('Lucy', 'A woman, accidentally caught in a dark deal, turns the tables on her captors and transforms into a merciless warrior evolved beyond human logic.', 'http://www.imdb.com/title/tt2872732/?ref_=fn_al_tt_1', '2014-08-22');

INSERT INTO `cinema`.`Movie_Awards` (`maw_title`, `maw_description`) VALUES ('Oscar Best Picture', 'Oscar for the Best Picture movie of the Year.');
INSERT INTO `cinema`.`Movie_Awards` (`maw_title`, `maw_description`) VALUES ('Oscar Best Scenario', 'Oscar for the Best Scenario movie of the Year.');
INSERT INTO `cinema`.`Movie_Awards` (`maw_title`, `maw_description`) VALUES ('Oscar Best Music', 'Oscar for the Best Music in a movie of the Year.');
INSERT INTO `cinema`.`Movie_Awards` (`maw_title`, `maw_description`) VALUES ('Oscar Best Costumes', 'Oscar for the Best Costumes in a movie of the Year.');
INSERT INTO `cinema`.`Movie_Awards` (`maw_title`, `maw_description`) VALUES ('Oscar Best Effects', 'Oscar for the Best Effects in a movie of the Year.');

INSERT INTO `cinema`.`movie_nominated` (`mn_movie`, `mn_award`, `mn_nominee_date`, `mn_nominee_condition`) VALUES (1, 'Oscar Best Picture', '1992-11-21', 'Won');
INSERT INTO `cinema`.`movie_nominated` (`mn_movie`, `mn_award`, `mn_nominee_date`, `mn_nominee_condition`) VALUES (6, 'Oscar Best Picture', '2008-02-23', 'Nominated');
INSERT INTO `cinema`.`movie_nominated` (`mn_movie`, `mn_award`, `mn_nominee_date`, `mn_nominee_condition`) VALUES (7, 'Oscar Best Scenario', '1994-02-18', 'Nominated');
INSERT INTO `cinema`.`movie_nominated` (`mn_movie`, `mn_award`, `mn_nominee_date`, `mn_nominee_condition`) VALUES (10, 'Oscar Best Music', '1997-01-28', 'Nominated');
INSERT INTO `cinema`.`movie_nominated` (`mn_movie`, `mn_award`, `mn_nominee_date`, `mn_nominee_condition`) VALUES (1, 'Oscar Best Costumes', '1992-11-21', 'Won');
INSERT INTO `cinema`.`movie_nominated` (`mn_movie`, `mn_award`, `mn_nominee_date`, `mn_nominee_condition`) VALUES (22, 'Oscar Best Effects', '2011-08-18', 'Won');
INSERT INTO `cinema`.`movie_nominated` (`mn_movie`, `mn_award`, `mn_nominee_date`, `mn_nominee_condition`) VALUES (13, 'Oscar Best Effects', '1991-03-15', 'Nominated');
INSERT INTO `cinema`.`movie_nominated` (`mn_movie`, `mn_award`, `mn_nominee_date`, `mn_nominee_condition`) VALUES (18, 'Oscar Best Effects', '2012-07-22', 'Won');

INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Crime', 1);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Drama', 1);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Mystery', 1);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Comedy', 2);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Western', 2);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Drama', 3);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Comedy', 3);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Horror', 4);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Thriller', 4);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Western', 5);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Drama', 6);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('History', 6);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Thriller', 6);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Crime', 7);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Drama', 7);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Drama', 8);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Documentary', 8);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Drama', 9);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Documentary', 10);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Drama', 10);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Drama', 11);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Horror', 11);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Crime', 12);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Drama', 12);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Biography', 13);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Drama', 13);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Crime', 13);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Drama', 14);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Crime', 14);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Drama', 15);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Thriller', 15);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Crime', 16);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Drama', 16);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Thriller', 16);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Adventure', 17);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Comedy', 17);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Crime', 17);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Comedy', 18);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Crime', 18);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Comedy', 19);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Crime', 19);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Drama', 19);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Action', 20);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Adventure', 20);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Family', 20);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Action', 21);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Comedy', 21);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Crime', 21);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Action', 22);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Crime', 22);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Mystery', 22);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Drama', 23);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Mystery', 23);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Thriller', 23);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Action', 24);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Sci-Fi', 4);
INSERT INTO `cinema`.`movie_Genres` (`movie_genre`, `mg_movie`) VALUES ('Thriller', 24);

INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Jack', 'Nicholson', 'Jack Nicholson, an American actor, producer, screen-writer and director, is a three-time Academy Award winner and twelve-time nominee. Nicholson is also notable for being one of two actors - the other being Michael Caine - who have received Oscar nods in every decade from sixties through the naughts.\n\nNicholson was born on April 22, 1937 in Neptune, New Jersey. He was raised believing that his grandmother was his mother, and that his mother, June Frances Nicholson, a show-girl, was his older sister. He discovered the truth in 1975 from a Time magazine journalist who was researching a profile on him. His real father is believed to have been either Donald Furcillo, an Italian-American show-man, or Eddie King (Edgar Kirschfeld), born in Latvia and also in show-business. Jack\'s mother\'s ancestry was Irish, English, as well as German, Scottish, and Welsh.\n\nNicholson made his film debut in a B-movie titled The Cry Baby Killer (1958). His rise in Hollywood was far from meteoric, and for years, he sustained his career with guest spots in television series and a number of Roger Corman films, including The Little Shop of Horrors (1960).\n\nNicholson\'s first turn in the director\'s chair was for Drive, He Said (1971). Before that, he wrote the screenplay for The Trip (1967), and co-wrote Head (1968), a vehicle for The Monkees. His big break came with Easy Rider (1969) and his portrayal of liquor-soaked attorney George Hanson, which earned Nicholson his first Oscar nomination. Nicholson\'s film career took off in the 1970s with a definitive performance in Five Easy Pieces (1970). Nicholson\'s other notable work during this period includes leading roles in Roman Polanski\'s noir masterpiece Chinatown (1974) and One Flew Over the Cuckoo\'s Nest (1975), for which he won his first Best Actor Oscar.\n\nThe 1980s kicked off with another career-defining role for Nicholson as Jack Torrance in Stanley Kubrick\'s adaptation of Stephen King\'s novel The Shining (1980). A string of well-received films followed, including Terms of Endearment (1983) which earned Nicholson his second Oscar; Prizzi\'s Honor (1985) and The Witches of Eastwick (1987). He portrayed another renowned villain, The Joker, in Tim Burton\'s Batman (1989). In the 1990s, he starred in such varied films as A Few Good Men (1992), for which he received another Oscar nomination, and a dual role in Mars Attacks! (1996).\n\nAlthough a glimpse at the darker side of Nicholson\'s acting range reappeared in The Departed (2006), the actor\'s most recent roles highlight the physical and emotional complications one faces late in life. The most notable of these is the unapologetically misanthropic Melvin Udall in As Good as It Gets (1997), for which he won his third Oscar. Shades of this persona are apparent in About Schmidt (2002), Something\'s Gotta Give (2003) and The Bucket List (2007). In addition to his Oscar wins and nominations, Nicholson has seven Golden Globe Awards, and received a Kennedy Center Honor in 2001. He also became one of the youngest actors to receive the American Film Institute\'s Life Achievement award in 1994.\n\nNicholson has five children: Eldest daughter Jennifer Nicholson (b. 1963), from his marriage to Sandra Knight which ended in 1968; Caleb James Goddard (b. 1970) with Susan Anspach; Honey Hollman (b. 1981) with Danish supermodel, Winnie Hollman; and Lorraine Nicholson (b. 1990) and Ray Nicholson (b. 1992) with Rebecca Broussard. Nicholson\'s longest relationship was the seventeen years he spent with actress Anjelica Huston; it ended when Broussard become pregnant with his child.', 'http://ia.media-imdb.com/images/M/MV5BMTQ3OTY0ODk0M15BMl5BanBnXkFtZTYwNzE4Njc4._V1_UY317_CR7,0,214,317_AL_.jpg', '1937-04-22');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Marlon', 'Brando', 'Marlon Brando is widely considered the greatest movie actor of all time, rivaled only by the more theatrically oriented Laurence Olivier in terms of esteem. Unlike Olivier, who preferred the stage to the screen, Brando concentrated his talents on movies after bidding the Broadway stage adieu in 1949, a decision for which he was severely criticized when his star began to dim in the 1960s and he was excoriated for squandering his talents. No actor ever exerted such a profound influence on succeeding generations of actors as did Brando. More than 50 years after he first scorched the screen as Stanley Kowalski in the movie version of Tennessee Williams\' A Streetcar Named Desire (1951) and a quarter-century after his last great performance as Col. Kurtz in Francis Ford Coppola\'s Apocalypse Now (1979), all American actors are still being measured by the yardstick that was Brando. It was if the shadow of John Barrymore, the great American actor closest to Brando in terms of talent and stardom, dominated the acting field up until the 1970s. He did not, nor did any other actor so dominate the public\'s consciousness of what WAS an actor before or since Brando\'s 1951 on-screen portrayal of Stanley made him a cultural icon. Brando eclipsed the reputation of other great actors circa 1950, such as Paul Muni and Fredric March. Only the luster of Spencer Tracy\'s reputation hasn\'t dimmed when seen in the starlight thrown off by Brando. However, neither Tracy nor Olivier created an entire school of acting just by the force of his personality. Brando did.\n\nMarlon Brando, Jr. was born on April 3, 1924, in Omaha, Nebraska, to Marlon Brando, Sr., a calcium carbonate salesman, and his artistically inclined wife, the former Dorothy Julia Pennebaker. \"Bud\" Brando was one of three children. His ancestry included English, and smaller amounts of Irish, German, Dutch, French Huguenot, Welsh, and Scottish; his surname originated with a distant German immigrant ancestor named \"Brandau\". His oldest sister Jocelyn Brando was also an actress, taking after their mother, who engaged in amateur theatricals and mentored a then-unknown Henry Fonda, another Nebraska native, in her role as director of the Omaha Community Playhouse. Frannie, Brando\'s other sibling, was a visual artist. Both Brando sisters contrived to leave the Midwest for New York City, Jocelyn to study acting and Frannie to study art. Marlon managed to escape the vocational doldrums forecast for him by his cold, distant father and his disapproving schoolteachers by striking out for The Big Apple in 1943, following Jocelyn into the acting profession. Acting was the only thing he was good at, for which he received praise, so he was determined to make it his career - a high-school dropout, he had nothing else to fall back on, having been rejected by the military due to a knee injury he incurred playing football at Shattuck Military Academy, Brando Sr.\'s alma mater. The school booted Marlon out as incorrigible before graduation.\n\nActing was a skill he honed as a child, the lonely son of alcoholic parents. With his father away on the road, and his mother frequently intoxicated to the point of stupefaction, the young Bud would play-act for her to draw her out of her stupor and to attract her attention and love. His mother was exceedingly neglectful, but he loved her, particularly for instilling in him a love of nature, a feeling which informed his character Paul in Last Tango in Paris (1972) (\"Last Tango in Paris\") when he is recalling his childhood for his young lover Jeanne. \"I don\'t have many good memories,\" Paul confesses, and neither did Brando of his childhood. Sometimes he had to go down to the town jail to pick up his mother after she had spent the night in the drunk tank and bring her home, events that traumatized the young boy but may have been the grain that irritated the oyster of his talent, producing the pearls of his performances. Anthony Quinn, his Oscar-winning co-star in Viva Zapata! (1952) told Brando\'s first wife Anna Kashfi, \"I admire Marlon\'s talent, but I don\'t envy the pain that created it.\"\n\nBrando enrolled in Erwin Piscator\'s Dramatic Workshop at New York\'s New School, and was mentored by Stella Adler, a member of a famous Yiddish Theatre acting family. Adler helped introduce to the New York stage the \"emotional memory\" technique of Russian theatrical actor, director and impresario Konstantin Stanislavski, whose motto was \"Think of your own experiences and use them truthfully.\" The results of this meeting between an actor and the teacher preparing him for a life in the theater would mark a watershed in American acting and culture.\n\nBrando made his debut on the boards of Broadway on October 19, 1944, in \"I Remember Mama,\" a great success. As a young Broadway actor, Brando was invited by talent scouts from several different studios to screen-test for them, but he turned them down because he would not let himself be bound by the then-standard seven-year contract. Brando would make his film debut quite some time later in Fred Zinnemann\'s The Men (1950) for producer Stanley Kramer. Playing a paraplegic soldier, Brando brought new levels of realism to the screen, expanding on the verisimilitude brought to movies by Group Theatre alumni John Garfield, the predecessor closest to him in the raw power he projected on-screen. Ironically, it was Garfield whom producer Irene Mayer Selznick had chosen to play the lead in a new Tennessee Williams play she was about to produce, but negotiations broke down when Garfield demanded an ownership stake in \"A Streetcar Named Desire.\" Burt Lancaster was next approached, but couldn\'t get out of a prior film commitment. Then director Elia Kazan suggested Brando, whom he had directed to great effect in Maxwell Anderson\'s play \"Truckline Café,\" in which Brando co-starred with Karl Malden, who was to remain a close friend for the next 60 years.\n\nDuring the production of \"Truckline Café\", Kazan had found that Brando\'s presence was so magnetic, he had to re-block the play to keep Marlon near other major characters\' stage business, as the audience could not take its eyes off of him. For the scene where Brando\'s character re-enters the stage after killing his wife, Kazan placed him upstage-center, partially obscured by scenery, but where the audience could still see him as Karl Malden and others played out their scene within the café set. When he eventually entered the scene, crying, the effect was electric. A young Pauline Kael, arriving late to the play, had to avert her eyes when Brando made this entrance as she believed the young actor on stage was having a real-life conniption. She did not look back until her escort commented that the young man was a great actor.\n\nThe problem with casting Brando as Stanley was that he was much younger than the character as written by Williams. However, after a meeting between Brando and Williams, the playwright eagerly agreed that Brando would make an ideal Stanley. Williams believed that by casting a younger actor, the Neanderthalish Kowalski would evolve from being a vicious older man to someone whose unintentional cruelty can be attributed to his youthful ignorance. Brando ultimately was dissatisfied with his performance, though, saying he never was able to bring out the humor of the character, which was ironic as his characterization often drew laughs from the audience at the expense of Jessica Tandy\'s Blanche Dubois. During the out-of-town tryouts, Kazan realized that Brando\'s magnetism was attracting attention and audience sympathy away from Blanche to Stanley, which was not what the playwright intended. The audience\'s sympathy should be solely with Blanche, but many spectators were identifying with Stanley. Kazan queried Williams on the matter, broaching the idea of a slight rewrite to tip the scales back to more of a balance between Stanley and Blanche, but Williams demurred, smitten as he was by Brando, just like the preview audiences.\n\nFor his part, Brando believed that the audience sided with his Stanley because Jessica Tandy was too shrill. He thought Vivien Leigh, who played the part in the movie, was ideal, as she was not only a great beauty but she WAS Blanche Dubois, troubled as she was in her real life by mental illness and nymphomania. Brando\'s appearance as Stanley on stage and on screen revolutionized American acting by introducing \"The Method\" into American consciousness and culture. Method acting, rooted in Adler\'s study at the Moscow Art Theatre of Stanislavsky\'s theories that she subsequently introduced to the Group Theatre, was a more naturalistic style of performing, as it engendered a close identification of the actor with the character\'s emotions. Adler took first place among Brando\'s acting teachers, and socially she helped turn him from an unsophisticated Midwestern farm boy into a knowledgeable and cosmopolitan artist who one day would socialize with presidents.\n\nBrando didn\'t like the term \"The Method,\" which quickly became the prominent paradigm taught by such acting gurus as Lee Strasberg at the Actors Studio. Brando denounced Strasberg in his autobiography \"Songs My Mother Taught Me\" (1994), saying that he was a talentless exploiter who claimed he had been Brando\'s mentor. The Actors Studio had been founded by Strasberg along with Kazan and Stella Adler\'s husband, Harold Clurman, all Group Theatre alumni, all political progressives deeply committed to the didactic function of the stage. Brando credits his knowledge of the craft to Adler and Kazan, while Kazan in his autobiography \"A Life\" claimed that Brando\'s genius thrived due to the thorough training Adler had given him. Adler\'s method emphasized that authenticity in acting is achieved by drawing on inner reality to expose deep emotional experience\n\nInterestingly, Elia Kazan believed that Brando had ruined two generations of actors, his contemporaries and those who came after him, all wanting to emulate the great Brando by employing The Method. Kazan felt that Brando was never a Method actor, that he had been highly trained by Adler and did not rely on gut instincts for his performances, as was commonly believed. Many a young actor, mistaken about the true roots of Brando\'s genius, thought that all it took was to find a character\'s motivation, empathize with the character through sense and memory association, and regurgitate it all on stage to become the character. That\'s not how the superbly trained Brando did it; he could, for example, play accents, whereas your average American Method actor could not. There was a method to Brando\'s art, Kazan felt, but it was not The Method.\n\nAfter A Streetcar Named Desire (1951), for which he received the first of his eight Academy Award nominations, Brando appeared in a string of Academy Award-nominated performances - in Viva Zapata! (1952), Julius Caesar (1953) and the summit of his early career, Kazan\'s On the Waterfront (1954). For his \"Waterfront\" portrayal of meat-headed longshoreman Terry Malloy, the washed-up pug who \"coulda been a contender,\" Brando won his first Oscar. Along with his iconic performance as the rebel-without-a-cause Johnny in The Wild One (1953) (\"What are you rebelling against?\" Johnny is asked. \"What have ya got?\" is his reply), the first wave of his career was, according to Jon Voight, unprecedented in its audacious presentation of such a wide range of great acting. Director John Huston said his performance of Marc Antony was like seeing the door of a furnace opened in a dark room, and co-star John Gielgud, the premier Shakespearean actor of the 20th century, invited Brando to join his repertory company.\n\nIt was this period of 1951-54 that revolutionized American acting, spawning such imitators as James Dean - who modeled his acting and even his lifestyle on his hero Brando - the young Paul Newman and Steve McQueen. After Brando, every up-and-coming star with true acting talent and a brooding, alienated quality would be hailed as the \"New Brando,\" such as Warren Beatty in Kazan\'s Splendour in the Grass (1961). \"We are all Brando\'s children,\" Jack Nicholson pointed out in 1972. \"He gave us our freedom.\" He was truly \"The Godfather\" of American acting - and he was just 30 years old. Though he had a couple of failures, like Désirée (1954) and The Teahouse of the August Moon (1956), he was clearly miscast in them and hadn\'t sought out the parts so largely escaped blame.\n\nIn the second period of his career, 1955-62, Brando managed to uniquely establish himself as a great actor who also was a Top 10 movie star, although that star began to dim after the box-office high point of his early career, Sayonara (1957) (for which he received his fifth Best Actor Oscar nomination). Brando tried his hand at directing a film, the well-reviewed One-Eyed Jacks (1961) that he made for his own production company, Pennebaker Productions (after his mother\'s maiden name). Stanley Kubrick had been hired to direct the film, but after months of script rewrites in which Brando participated, Kubrick and Brando had a falling out and Kubrick was sacked. According to his widow Christiane Kubrick, Stanley believed that Brando had wanted to direct the film himself all along.\n\nTales proliferated about the profligacy of Brando the director, burning up a million and a half feet of expensive VistaVision film at 50 cents a foot, fully ten times the normal amount of raw stock expended during production of an equivalent motion picture. Brando took so long editing the film that he was never able to present the studio with a cut. Paramount took it away from him and tacked on a re-shot ending that Brando was dissatisfied with, as it made the Oedipal figure of Dad Longworth into a villain. In any normal film Dad would have been the heavy, but Brando believed that no one was innately evil, that it was a matter of an individual responding to, and being molded by, one\'s environment. It was not a black-and-white world, Brando felt, but a gray world in which once-decent people could do horrible things. This attitude explains his sympathetic portrayal of Nazi officer Christian Diestl in the film he made before shooting One-Eyed Jacks (1961), Edward Dmytryk\'s filming of Irwin Shaw\'s novel The Young Lions (1958). Shaw denounced Brando\'s performance, but audiences obviously disagreed, as the film was a major hit. It would be the last hit movie Brando would have for more than a decade.\n\nOne-Eyed Jacks (1961) generated respectable numbers at the box office, but the production costs were exorbitant - a then-staggering $6 million - which made it run a deficit. A film essentially is \"made\" in the editing room, and Brando found cutting to be a terribly boring process, which was why the studio eventually took the film away from him. Despite his proved talent in handling actors and a large production, Brando never again directed another film, though he would claim that all actors essentially direct themselves during the shooting of a picture.\n\nBetween the production and release of One-Eyed Jacks (1961), Brando appeared in Sidney Lumet\'s film version of Tennessee Williams\' play \"Orpheus Descending\", The Fugitive Kind (1960) which teamed him with fellow Oscar winners Anna Magnani and Joanne Woodward. Following in Elizabeth Taylor\'s trailblazing footsteps, Brando became the second performer to receive a $1-million salary for a motion picture, so high were the expectations for this re-teaming of Kowalski and his creator (in 1961 critic Hollis Alpert had published a book \"Brando and the Shadow of Stanley Kowalski). Critics and audiences waiting for another incendiary display from Brando in a Williams work were disappointed when the renamed The Fugitive Kind (1960) finally released. Though Tennessee was hot, with movie versions of Cat on a Hot Tin Roof (1958) and Suddenly, Last Summer (1959) burning up the box office and receiving kudos from the Academy of Motion Picture Arts & Sciences, The Fugitive Kind (1960) was a failure. This was followed by the so-so box-office reception of One-Eyed Jacks (1961) in 1961 and then by a failure of a more monumental kind: Mutiny on the Bounty (1962), a remake of the famed 1935 film.\n\nBrando signed on to Mutiny on the Bounty (1962) after turning down the lead in the David Lean classic Lawrence of Arabia (1962) because he didn\'t want to spend a year in the desert riding around on a camel. He received another $1-million salary, plus $200,000 in overages as the shoot went overtime and over budget. During principal photography, highly respected director Carol Reed (an eventual Academy Award winner) was fired, and his replacement, two-time Oscar winner Lewis Milestone, was shunted aside by Brando as Marlon basically took over the direction of the film himself. The long shoot became so notorious that President John F. Kennedy asked director Billy Wilder at a cocktail party not \"when\" but \"if\" the \"Bounty\" shoot would ever be over. The MGM remake of one of its classic Golden Age films garnered a Best Picture Oscar nomination and was one of the top grossing films of 1962, yet failed to go into the black due to its Brobdingnagian budget estimated at $20 million, which is equivalent to $120 million when adjusted for inflation.\n\nBrando and Taylor, whose Cleopatra (1963) nearly bankrupted 20th Century-Fox due to its huge cost overruns (its final budget was more than twice that of Brando\'s Mutiny on the Bounty (1962)), were pilloried by the show business press for being the epitome of the pampered, self-indulgent stars who were ruining the industry. Seeking scapegoats, the Hollywood press conveniently ignored the financial pressures on the studios. The studios had been hurt by television and by the antitrust-mandated divestiture of their movie theater chains, causing a large outflow of production to Italy and other countries in the 1950s and 1960s in order to lower costs. The studio bosses, seeking to replicate such blockbuster hits as the remakes of The Ten Commandments (1956) and Ben-Hur (1959), were the real culprits behind the losses generated by large-budgeted films that found it impossible to recoup their costs despite long lines at the box office.\n\nWhile Elizabeth Taylor, receiving the unwanted gift of reams of publicity from her adulterous romance with Cleopatra (1963) co-star Richard Burton, remained hot until the tanking of her own Tennessee Williams-renamed debacle Boom (1968), Brando from 1963 until the end of the decade appeared in one box-office failure after another as he worked out a contract he had signed with Universal Pictures. The industry had grown tired of Brando and his idiosyncrasies, though he continued to be offered prestige projects up through 1968.\n\nSome of the films Brando made in the 1960s were noble failures, such as The Ugly American (1963), The Chase (1966) and Reflections in a Golden Eye (1967). For every \"Reflections,\" though, there seemed to be two or three outright debacles, such as Bedtime Story (1964), Morituri (1965), A Countess from Hong Kong (1967), Candy (1968), The Night of the Following Day (1968). By the time Brando began making the anti-colonialist picture Burn! (1969) in Colombia with Gillo Pontecorvo in the director\'s chair, he was box-office poison, despite having worked in the previous five years with such top directors as Arthur Penn, John Huston and the legendary Charles Chaplin, and with such top-drawer co-stars as David Niven, Yul Brynner, Sophia Loren and Taylor.\n\nThe rap on Brando in the 1960s was that a great talent had ruined his potential to be America\'s answer to Laurence Olivier, as his friend William Redfield limned the dilemma in his book \"Letters from an Actor\" (1967), a memoir about Redfield\'s appearance in Burton\'s 1964 theatrical production of \"Hamlet.\" By failing to go back on stage and recharge his artistic batteries, something British actors such as Burton were not afraid to do, Brando had stifled his great talent, by refusing to tackle the classical repertoire and contemporary drama. Actors and critics had yearned for an American response to the high-acting style of the Brits, and while Method actors such as Rod Steiger tried to create an American style, they were hampered in their quest, as their king was lost in a wasteland of Hollywood movies that were beneath his talent. Many of his early supporters now turned on him, claiming he was a crass sellout.\n\nDespite evidence in such films as The Chase (1966), The Appaloosa (1966) and Reflections in a Golden Eye (1967) that Brando was in fact doing some of the best acting of his life, critics, perhaps with an eye on the box office, slammed him for failing to live up to, and nurture, his great gift. Brando\'s political activism, starting in the early 1960s with his championing of Native Americans\' rights, followed by his participation in the Southern Christian Leadership Conference\'s March on Washington in 1963, and followed by his appearance at a Black Panther rally in 1968, did not win him many admirers in the establishment. In fact, there was a de facto embargo on Brando films in the recently segregated (officially, at least) southeastern US in the 1960s. Southern exhibitors simply would not book his films, and producers took notice. After 1968, Brando would not work for three years.\n\nPauline Kael wrote of Brando that he was Fortune\'s fool. She drew a parallel with the latter career of John Barrymore, a similarly gifted thespian with talents as prodigious, who seemingly threw them away. Brando, like the late-career Barrymore, had become a great ham, evidenced by his turn as the faux Indian guru in the egregious Candy (1968), seemingly because the material was so beneath his talent. Most observers of Brando in the 1960s believed that he needed to be reunited with his old mentor Elia Kazan, a relationship that had soured due to Kazan\'s friendly testimony naming names before the notorious House Un-American Activities Committee. Perhaps Brando believed this, too, as he originally accepted an offer to appear as the star of Kazan\'s film adaptation of his own novel, The Arrangement (1969). However, after the assassination of Martin Luther King, Brando backed out of the film, telling Kazan that he could not appear in a Hollywood film after this tragedy. Also reportedly turning down a role opposite box-office king Paul Newman in a surefire script, Butch Cassidy and the Sundance Kid (1969), Brando decided to make Burn! (1969) with Pontecorvo. The film, a searing indictment of racism and colonialism, flopped at the box office but won the esteem of progressive critics and cultural arbiters such as Howard Zinn.\n\nKazan, after a life in film and the theater, said that, aside from Orson Welles, whose greatness lay in filmmaking, he only met one actor who was a genius: Brando. Richard Burton, an intellectual with a keen eye for observation if not for his own film projects, said that he found Brando to be very bright, unlike the public perception of him as a Terry Malloy-type character that he himself inadvertently promoted through his boorish behavior. Brando\'s problem, Burton felt, was that he was unique, and that he had gotten too much fame too soon at too early an age. Cut off from being nurtured by normal contact with society, fame had distorted Brando\'s personality and his ability to cope with the world, as he had not had time to grow up outside the limelight.\n\nTruman Capote, who eviscerated Brando in print in the mid-\'50s and had as much to do with the public perception of the dyslexic Brando as a dumbbell, always said that the best actors were ignorant, and that an intelligent person could not be a good actor. However, Brando was highly intelligent, and possessed of a rare genius in a then-deprecated art, acting. The problem that an intelligent performer has in movies is that it is the director, and not the actor, who has the power in his chosen field. Greatness in the other arts is defined by how much control the artist is able to exert over his chosen medium, but in movie acting, the medium is controlled by a person outside the individual artist. It is an axiom of the cinema that a performance, as is a film, is \"created\" in the cutting room, thus further removing the actor from control over his art. Brando had tried his hand at directing, in controlling the whole artistic enterprise, but he could not abide the cutting room, where a film and the film\'s performances are made. This lack of control over his art was the root of Brando\'s discontent with acting, with movies, and, eventually, with the whole wide world that invested so much cachet in movie actors, as long as \"they\" were at the top of the box-office charts. Hollywood was a matter of \"they\" and not the work, and Brando became disgusted.\n\nCharlton Heston, who participated in Martin Luther King\'s 1963 March on Washington with Brando, believes that Marlon was the great actor of his generation. However, noting a story that Brando had once refused a role in the early 1960s with the excuse \"How can I act when people are starving in India?\", Heston believes that it was this attitude, the inability to separate one\'s idealism from one\'s work, that prevented Brando from reaching his potential. As Rod Steiger once said, Brando had it all, great stardom and a great talent. He could have taken his audience on a trip to the stars, but he simply would not. Steiger, one of Brando\'s children even though a contemporary, could not understand it. When James Mason\' was asked in 1971 who was the best American actor, he had replied that since Brando had let his career go belly-up, it had to be George C. Scott, by default.\n\nParamount thought that only Laurence Olivier would suffice, but Lord Olivier was ill. The young director believed there was only one actor who could play godfather to the group of Young Turk actors he had assembled for his film, The Godfather of method acting himself - Marlon Brando. Francis Ford Coppola won the fight for Brando, Brando won - and refused - his second Oscar, and Paramount won a pot of gold by producing the then top-grossing film of all-time, The Godfather (1972), a gangster movie most critics now judge one of the greatest American films of all time. Brando followed his iconic portrayal of Don Corleone with his Oscar-nominated turn in the high-grossing and highly scandalous Last Tango in Paris (1972) (\"Last Tango in Paris\"), the first film dealing explicitly with sexuality in which an actor of Brando\'s stature had participated. He was now again a Top-Ten box office star and once again heralded as the greatest actor of his generation, an unprecedented comeback that put him on the cover of \"Time\" magazine and would make him the highest-paid actor in the history of motion pictures by the end of the decade. Little did the world know that Brando, who had struggled through many projects in good faith during the 1960s, delivering some of his best acting, only to be excoriated and ignored as the films did not do well at the box office, essentially was through with the movies.\n\nAfter reaching the summit of his career, a rarefied atmosphere never reached before or since by any actor, Brando essentially walked away. He would give no more of himself after giving everything as he had done in \"Last Tango in Paris,\" a performance that embarrassed him, according to his autobiography. Brando had come as close to any actor to being the \"auteur,\" or author, of a film, as the English-language scenes of \"Tango\" were created by encouraging Brando to improvise. The improvisations were written down and turned into a shooting script, and the scripted improvisations were shot the next day. Pauline Kael, the Brando of movie critics in that she was the most influential arbiter of cinematic quality of her generation and spawned a whole legion of Kael wanna-bes, said Brando\'s performance in Last Tango in Paris (1972) had revolutionized the art of film. Brando, who had to act to gain his mother\'s attention; Brando, who believed acting at best was nothing special as everyone in the world engaged in it every day of their lives to get what they wanted from other people; Brando, who believed acting at its worst was a childish charade and that movie stardom was a whorish fraud, would have agreed with Sam Peckinpah\'s summation of Pauline Kael: \"Pauline\'s a brilliant critic but sometimes she\'s just cracking walnuts with her ass.\" Probably in a simulacrum of those words, too.\n\nAfter another three-year hiatus, Brando took on just one more major role for the next 20 years, as the bounty hunter after Jack Nicholson in Arthur Penn\'s The Missouri Breaks (1976), a western that succeeded neither with the critics or at the box office. From then on, Brando concentrated on extracting the maximum amount of capital for the least amount of work from producers, as when he got the Salkind brothers to pony up a then-record $3.7 million against 10% of the gross for 13 days work on Superman (1978). Factoring in inflation, the straight salary for \"Superman\" equals or exceeds the new record of $1 million a day Harrison Ford set with K-19: The Widowmaker (2002). Before cashing his first paycheck for Superman (1978), Brando had picked up $2 million for his extended cameo in Francis Ford Coppola\'s Apocalypse Now (1979) in a role, that of Col. Kurtz, that he authored on-camera through improvisation while Coppola shot take after take. It was Brando\'s last bravura star performance. He co-starred with \'George C. Scott\' and \'John Gielud\' in _The Formula_, but the film was another critical and financial failure. Years later though, he did receive an eighth and final Oscar nomination for his supporting role in A Dry White Season (1989) after coming out of a near-decade-long retirement. Contrary to those who claimed he now only was in it for the money, Brando donated his entire seven-figure salary to an anti-apartheid charity. He then did an amusing performance in the comedy The Freshman (1990), winning rave reviews. He portrayed Tomas de Torquemada in the historical drama 1492: Conquest of Paradise (1992), but his performance was denounced and the film was a box office failure. He made another comeback in the Johnny Depp romantic drama Don Juan DeMarco (1994), which co-starred Faye Dunaway as his wife.\n\nBrando had first attracted media attention at the age of 24, when \"Life\" magazine ran a photo of himself and his sister Jocelyn, who were both then appearing on Broadway. The curiosity continued, and snowballed. Playing the paraplegic soldier of The Men (1950), Brando had gone to live at a Veterans Administration hospital with actual disabled veterans, and confined himself to a wheelchair for weeks. It was an acting method, research, that no one in Hollywood had ever heard of before, and that willingness to experience life.', 'http://ia.media-imdb.com/images/M/MV5BMTg3MDYyMDE5OF5BMl5BanBnXkFtZTcwNjgyNTEzNA@@._V1_UY317_CR97,0,214,317_AL_.jpg', '1924-04-03');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Robert Anthony', 'De Niro Jr. ', 'Robert De Niro, thought of as one of the greatest actors of all time, was born in Greenwich Village, Manhattan, New York City, to artists Virginia (Admiral) and Robert De Niro Sr. His paternal grandfather was of Italian descent, and his other ancestry is Irish, German, Dutch, English, and French. He was trained at the Stella Adler Conservatory and the American Workshop. He first gained fame for his role in Bang the Drum Slowly (1973), but he gained his reputation as a volatile actor in Mean Streets (1973), which was his first film with director Martin Scorsese. In 1974 De Niro received an Academy Award for best supporting actor for his role in The Godfather: Part II (1974) and received Academy Award nominations for best actor in Taxi Driver (1976), The Deer Hunter (1978), and Cape Fear (1991). He won the best actor award in 1980 for Raging Bull (1980). De Niro heads his own production company, Tribeca Film Center, and made his directorial debut in 1993 with A Bronx Tale (1993).', 'http://ia.media-imdb.com/images/M/MV5BMjAwNDU3MzcyOV5BMl5BanBnXkFtZTcwMjc0MTIxMw@@._V1_UY317_CR13,0,214,317_AL_.jpg', '1943-08-17');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Alfredo James', 'Pacino', 'One of the greatest actors in all of film history, Al Pacino established himself during one of film\'s greatest decades, the 1970s, and has become an enduring and iconic figure in the world of American movies.\n\nPacino was born on April 25, 1940, in the Bronx, New York, to an Italian-American family. His parents, Rose (Gerardi) and Sal Pacino, divorced when he was young. His mother moved them into his grandparents\' house. Pacino found himself often repeating the plots and voices of characters he had seen in the movies, one of his favorite activities. Bored and unmotivated in school, the young Al Pacino found a haven in school plays, and his interest soon blossomed into a full-time career. Starting on the stage, he went through a lengthy period of depression and poverty, sometimes having to borrow bus fare to make it to auditions. He made it into the prestigious Actors Studio in 1966, studying under legendary acting coach Lee Strasberg, creator of the Method Approach that would become the trademark of many \'70s-era actors. After appearing in a string of plays in supporting roles, he finally hit it big with \"The Indian Wants the Bronx\", winning an Obie award for the 1966-67 season. That was followed by a Tony Award for \"Does the Tiger Wear a Necktie?\". His first feature films made little departure from the gritty realistic stage performances that earned him respect: he played a junkie in The Panic in Needle Park (1971) after his film debut in Me, Natalie (1969). What came next would change his life forever. The role of Michael Corleone in The Godfather (1972) was one of the most sought-after of the time: Robert Redford, Warren Beatty, Jack Nicholson, Ryan O\'Neal, Robert De Niro and a host of others either wanted it or were mentioned for it, but director Francis Ford Coppola had his heart set on the unknown Italian Pacino for the role, although pretty much everyone else--from the studio to the producers to some of the cast members--didn\'t want him. Though Coppola won out through slick persuasion, Pacino was in constant fear of being fired during the hellish shoot. Much to his (and Coppola\'s) relief, the film was a monster hit that did wonders for everyone\'s career, including Pacino\'s, and earned him his first Academy Award nomination for Best Supporting Actor. Instead of taking on easier projects for the big money he could now command, however, Pacino threw his support behind what he considered tough but important films, such as the true-life crime drama Serpico (1973) and the tragic real-life bank robbery film Dog Day Afternoon (1975). He opened eyes around the film world for his brave choice of roles, and he was nominated three consecutive years for the \"Best Actor\" Academy Award. He faltered slightly with Bobby Deerfield (1977), but regained his stride with ...and justice for all. (1979), for which he received another Academy Award nomination for Best Actor. This would, unfortunately, signal the beginning of a decline in his career, which produced such critical and commercial flops as Cruising (1980) and Author! Author! (1982). He took on another vicious gangster role and cemented his legendary status in the ultra-violent cult hit Scarface (1983), but a monumental mistake was about to follow. Revolution (1985) endured an endless and seemingly cursed shoot in which equipment was destroyed, weather was terrible, and Pacino became terribly ill with pneumonia. Constant changes in the script also further derailed a project that seemed doomed from the start anyway. The Revolutionary War film is considered one of the worst films ever, not to mention one of the worst of his career, resulted in his first truly awful reviews and kept him off the screen for the next four years. Returning to the stage, Pacino has done much to give back and contribute to the theatre, which he considers his first love. He directed a film, The Local Stigmatic (1990), but it remains unreleased. He lifted his self-imposed exile with the striking Sea of Love (1989) as a hard-drinking cop. It marked the second phase of Pacino\'s career, being the first to feature his now famous dark, owl eyes and hoarse, gravelly voice. Returning to the Corleones, he made The Godfather: Part III (1990) and earned raves for his first comedic role in the colorful Dick Tracy (1990). This earned him another Academy Award nomination for Best Supporting Actor, and two years later he was nominated for Glengarry Glen Ross (1992). He went into romantic mode for Frankie and Johnny (1991). In 1992 he finally won the Academy Award for Best Actor for his amazing performance in Scent of a Woman (1992). A mixture of technical perfection (he plays a blind man) and charisma, the role was tailor-made for him, and remains a classic. The next few years would see Pacino becoming more comfortable with acting and movies as a business, turning out great roles in great films with more frequency and less of the demanding personal involvement of his wilder days. Carlito\'s Way (1993) proved another gangster classic, as did the epic crime drama Heat (1995) directed by Michael Mann and co-starring Robert De Niro, although they only had a few scenes together. He returned to the director\'s chair for the highly acclaimed and quirky Shakespeare adaptation Looking for Richard (1996). City Hall (1996), Donnie Brasco (1997) and The Devil\'s Advocate (1997) all came out in this period. Reteaming with Mann and then Oliver Stone, he gave two commanding performances in The Insider (1999) and Any Given Sunday (1999).\n\nIn the 2000s, Pacino starred in a number of theatrical blockbusters, including _Ocean\'s Thirteen (2007)_, but his choice in television roles (the vicious Roy Cohn in HBO\'s miniseries Angels in America (2003) and his sensitive portrayal of Jack Kevorkian, in the television movie You Don\'t Know Jack (2010)) are reminiscent of the bolder choices of his early career. Each television project garnered him an Emmy for Outstanding Lead Actor in a Miniseries or a Movie.\n\nIn his personal life, Pacino is one of Hollywood\'s most enduring and notorious bachelors, having never been married. He has a daughter, Julie Marie, with acting teacher Jan Tarrant, and a new set of twins with longtime girlfriend Beverly D\'Angelo. His romantic history includes a long-time romance with \"Godfather\" co-star Diane Keaton. With his intense and gritty performances, Pacino was an original in the acting profession. His Method approach would become the process of many actors throughout time, and his unbeatable number of classic roles has already made him a legend among film buffs and all aspiring actors and directors. His commitment to acting as a profession and his constant screen dominance has established him as one of the movies\' true legends.\n\nPacino has never abandoned his love for the theater, and Shakespeare in particular, having directed the Shakespeare adaptation Looking for Richard (1996) and played Shylock in The Merchant of Venice (2004).', 'http://ia.media-imdb.com/images/M/MV5BMTQzMzg1ODAyNl5BMl5BanBnXkFtZTYwMjAxODQ1._V1_UX214_CR0,0,214,317_AL_.jpg', '1940-04-25');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Daniel Michael Blake', 'Day-Lewis', 'Born in London, England, Daniel Michael Blake Day-Lewis is the second child of Cecil Day-Lewis (A.K.A. Nicholas Blake) (Poet Laureate of England) and his second wife, Jill Balcon. His maternal grandfather was Sir Michael Balcon, an important figure in the history of British cinema and head of the famous Ealing Studios. His older sister, Tamasin Day-Lewis, is a documentarian. His mother\'s family were Jewish immigrants (from Poland and Latvia), and his father was of Northern Irish and English descent. Daniel was educated at Sevenoaks School in Kent, which he despised, and the more progressive Bedales in Petersfield, which he adored. He studied acting at the Bristol Old Vic School. Daniel made his film debut in Sunday Bloody Sunday (1971), but then acted on stage with the Bristol Old Vic and Royal Shakespeare Companies and did not appear on screen again until 1982, when he landed his first adult role, a bit part in Gandhi (1982). He also appeared on British TV that year in Frost in May (1982) and BBC2 Playhouse: How Many Miles to Babylon? (1982). Notable theatrical performances include Another Country (1982-83), Dracula (1984), and The Futurists (1986).\n\nHis first major supporting role in a feature film was in The Bounty (1984), quickly followed by My Beautiful Laundrette (1985) and A Room with a View (1985). The latter two films opened in New York on the same day, offering audiences and critics evidence of his remarkable range and establishing him as a major talent. The New York Film Critics named him Best Supporting Actor for those performances. In 1986, he appeared on stage in Richard Eyre\'s The Futurists and on television in Eyre\'s production of Screen Two: The Insurance Man (1986). He also had a small role in a British/French film, Nanou (1986). In 1987 he assumed leading-man status in Philip Kaufman\'s The Unbearable Lightness of Being (1988), followed by a comedic role in the unsuccessful Stars and Bars (1988). His brilliant performance as \"Christy Brown\" in Jim Sheridan\'s My Left Foot (1989) won him numerous awards, including The Academy Award for best actor.\n\nHe returned to the stage to work again with Eyre, as Hamlet at the National Theater, but was forced to leave the production close to the end of its run because of exhaustion, and has not appeared on stage since. He took a hiatus from film as well until 1992, when he starred in The Last of the Mohicans (1992), a film that met with mixed reviews but was a great success at the box office. He worked with American director Martin Scorsese in The Age of Innocence (1993) in 1994. Subsequently, he teamed again with Jim Sheridan to star in Εις το όνομα του πατρός (1993), a critically acclaimed performance that earned him another Academy Award nomination. His next project was in the role of John Proctor in father-in-law Arthur Miller\'s play The Crucible (1996), directed by Nicholas Hytner.', 'http://ia.media-imdb.com/images/M/MV5BMjE2NDY2NDc1Ml5BMl5BanBnXkFtZTcwNjAyMjkwOQ@@._V1_UY317_CR13,0,214,317_AL_.jpg', '1957-04-29');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Dustin', 'Hoffman', 'Dustin Lee Hoffman was born in Los Angeles, California, to Lillian (Gold) and Harry Hoffman, who was a furniture salesman and prop supervisor for Columbia Pictures. He was raised in a Jewish family (from Ukraine, Russia-Poland, and Romania). Hoffman graduated from Los Angeles High School in 1955, and went to Santa Monica City College, where he dropped out after a year due to bad grades. But before he did, he took an acting course because he was told that \"nobody flunks acting.\" Also received some training at Los Angeles Conservatory of Music. Decided to go into acting because he did not want to work or go into the service. Trained at The Pasadena Playhouse for two years.', 'http://ia.media-imdb.com/images/M/MV5BMTc3NzU0ODczMF5BMl5BanBnXkFtZTcwODEyMDY5Mg@@._V1_UY317_CR11,0,214,317_AL_.jpg', '1937-08-08');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Thomas Jeffrey', 'Hanks', 'Thomas Jeffrey Hanks was born in Concord, California, to Janet Marylyn (Frager), a hospital worker, and Amos Mefford Hanks, an itinerant cook. His father had English, and some German, ancestry, while his mother\'s family, originally surnamed \"Fraga\", was entirely Portuguese. Tom grew up in what he has called a \"fractured\" family. He moved around a lot after his parents\' divorce, living with a succession of step-families. No problems, no abuse, no alcoholism - just a confused childhood. He had no acting experience in college and, in fact, credits the fact that he couldn\'t get cast in a college play with actually starting his career. He went downtown, auditioned for a community theater play, was invited by the director of that play to go to Cleveland, and there his acting career started. He met his second wife, actress Rita Wilson on the set of his television show Bosom Buddies (1980) - she appeared in one episode in the second season (1981), Bosom Buddies: All You Need Is Love (1981). They have two children, and Tom has another son and daughter by his first wife, Samantha Lewes. In 1996, he made his first step behind the camera, directing and writing as well as starring in the film, That Thing You Do! (1996).', 'http://ia.media-imdb.com/images/M/MV5BMTQ2MjMwNDA3Nl5BMl5BanBnXkFtZTcwMTA2NDY3NQ@@._V1_UY317_CR2,0,214,317_AL_.jpg', '1956-07-09');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Philip Anthony', 'Hopkins', 'Anthony Hopkins was born on December 31, 1937, in Margam, Wales, to Muriel Anne (Yeats) and Richard Arthur Hopkins, a baker. His parents were both of half Welsh and half English descent. Influenced by Richard Burton, he decided to study at College of Music and Drama and graduated in 1957. In 1965, he moved to London and joined the National Theatre, invited by Laurence Olivier, who could see the talent in Hopkins. In 1967, he made his first film for television, A Flea in Her Ear (1967).\n\nFrom this moment on, he enjoyed a successful career in cinema and television. In 1968, he worked on The Lion in Winter (1968) with Timothy Dalton. Many successes came later, and Hopkins\' remarkable acting style reached the four corners of the world. In 1977, he appeared in two major films: A Bridge Too Far (1977) with James Caan, Gene Hackman, Sean Connery, Michael Caine, Elliott Gould and Laurence Olivier, and Maximilian Schell. In 1980, he worked on The Elephant Man (1980). Two good television literature adaptations followed: Othello (1981) and The Hunchback of Notre Dame (1982). In 1987 he was awarded with the Commander of the order of the British Empire. This year was also important in his cinematic life, with 84 Charing Cross Road (1987), acclaimed by specialists. In 1993, he was knighted.\n\nIn the 1990s, Hopkins acted in movies like Desperate Hours (1990) and Howards End (1992), The Remains of the Day (1993) (nominee for the Oscar), Legends of the Fall (1994), Nixon (1995) (nominee for the Oscar), Surviving Picasso (1996), Amistad (1997) (nominee for the Oscar), The Mask of Zorro (1998), Meet Joe Black (1998) and Instinct (1999). His most remarkable film, however, was The Silence of the Lambs (1991), for which he won the Oscar for Best Actor. He also got a B.A.F.T.A. for this role.', 'http://ia.media-imdb.com/images/M/MV5BMTg5ODk1NTc5Ml5BMl5BanBnXkFtZTYwMjAwOTI4._V1_UY317_CR6,0,214,317_AL_.jpg', '1937-12-31');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Paul Leonard', 'Newman', 'Screen legend, superstar, and the man with the most famous blue eyes in movie history, Paul Leonard Newman was born in January 1925, in Cleveland, Ohio, the second son of Theresa (Fetsko) and Arthur Sigmund Newman. Paul\'s father was Jewish, the son of immigrants from Poland and Hungary; he owned a successful sporting goods store. Paul\'s mother, a practicing Christian Scientist of Slovak decent, and his uncle Joe, had an interest in creative arts, and it rubbed off on him. He acted in grade school and high school plays. The Newmans were a well-to-do family, and Paul grew up in a nice home in Shaker Heights.\n\nBy 1950, the 25 year-old Newman had been kicked out of Ohio University for unruly behavior, served three years in the Navy during World War II as a radio operator, graduated from Ohio\'s Kenyon College, married his first wife, Jackie, and had his first child, Scott. 1950 was also the year that Paul\'s father died. When he became successful in later years, Newman said if he had any regrets it would be that his father wasn\'t around to see it. He brought Jackie back to Shaker Heights and he ran his father\'s store for a short period. Then, knowing that wasn\'t the career path he wanted to take, he moved Jackie and Scott to New Haven, Connecticut, where he attended Yale University\'s School of Drama. While doing a play there, Paul was spotted by two agents, who invited him to come to New York City to pursue a career as a professional actor. After moving to New York, Paul acted in guest spots for various television shows and in 1953 came a big break. He got the part of understudy of the lead role in the successful Broadway play Picnic. Through this play, he met actress Joanne Woodward, who was also an understudy in the play. While they got on very well and there was a strong attraction, Paul was married and his second child, Susan, was born that year. During this time, Newman was also accepted into the much admired and popular New York Actors Studio, although he wasn\'t technically auditioning. In 1954, a film Paul was very reluctant to do was released, The Silver Chalice (1954). He considered his performance in this costume epic to be so bad that he took out a full-page ad in a trade paper apologizing for it to anyone who might have seen it. He had always been embarrassed about the film and reveled in making fun of it. He immediately wanted to return to the stage, and performed in The Desperate Hours. In 1956, Newman got the chance to redeem himself in the film world by portraying boxer Rocky Graziano in Somebody Up There Likes Me (1956), and critics praised his performance. In 1957, with a handful of films to his credit, he was cast in The Long, Hot Summer (1958), co-starring none other than Joanne Woodward. During the shooting of this film, they realized they were meant to be together and by now, so did Paul\'s wife Jackie. After Jackie gave Paul a divorce, he and Joanne married in Las Vegas in January of 1958. They went on to have three daughters together and raised them in Westport, Connecticut. In 1959, Paul received his first Academy Award nomination for Best Actor, in Cat on a Hot Tin Roof (1958). The 1960s would bring Paul Newman into superstar status, as he became one of the most popular actors of the decade, and garnered three more Best Actor Oscar nominations, for The Hustler (1961), Hud (1963) and Cool Hand Luke (1967). In 1968, his debut directorial effort Rachel, Rachel (1968) was given good marks, and although the film and Joanne Woodward were nominated for Oscars, Newman was not nominated for Best Director. He did, however, win a Golden Globe for his direction. 1969 brought the popular screen duo Paul Newman and Robert Redford together for the first time when Butch Cassidy and the Sundance Kid (1969) was released. It was a box office smash. Throughout the 1970s, Newman had hits and misses from such popular films as The Sting (1973) and The Towering Inferno (1974) to lesser known films as The Life and Times of Judge Roy Bean (1972) to a now cult classic Slap Shot (1977). After the death of his only son, Scott, in 1978, Newman\'s personal life and film choices moved in a different direction. His acting work in the 1980s and on is what is often most praised by critics today. He became more at ease with himself and it was evident in The Verdict (1982) for which he received his 6th Best Actor Oscar nomination and in 1987 finally received his first Oscar for The Color of Money (1986). Friend and director of Somebody Up There Likes Me (1956), Robert Wise accepted the award on Newman\'s behalf as he did not attend the ceremony. Films were not the only thing on his mind during this period. A passionate race car driver since the early 1970s, Newman became co-owner of Newman-Haas racing in 1982, and also founded \"Newman\'s Own\", a successful line of food products that has earned in excess of $100 million, every penny of which Newman donated to charity. He also started The Hole in the Wall Gang Camps, an organization for terminally ill children. He was as well known for his philanthropic ways and highly successful business ventures as he was for his legendary actor status. Newman enjoyed a 50-year marriage to Joanne in Connecticut, their main residence since moving away from the bright lights of Hollywood in 1960. Renowned for his sense of humor, in 1998 he quipped that he was a little embarrassed to see his salad dressing grossing more than his movies. During his later years, he still attended races, was much involved in his charitable organizations, and in 2006, he opened a restaurant called Dressing Room, which helps out the Westport Country Playhouse, a place that Paul took great pride in. In 2007, he made some headlines when he said that he was losing his invention and confidence in his acting abilities and that acting is \"pretty much a closed book for me.\" He died the next year. Whether he was on the screen or not, Paul Newman remained synonymous with the anti-heroism of the 1960s and 1970s cinema, and with the rebellious nature his characters so often embodied.', 'http://ia.media-imdb.com/images/M/MV5BODUwMDYwNDg3N15BMl5BanBnXkFtZTcwODEzNTgxMw@@._V1_UY317_CR22,0,214,317_AL_.jpg', '1925-01-26');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Denzel Hayes Jr.', 'Washington', 'Denzel Hayes Washington, Jr. was born on December 28, 1954 in Mount Vernon, New York. He is the middle of three children of a beautician mother, Lennis (Lowe), from Georgia, and a Pentecostal minister father, Denzel Washington, Sr., from Virginia. After graduating from high school, Denzel enrolled at Fordham University, intent on a career in journalism. However, he caught the acting bug while appearing in student drama productions and, upon graduation, he moved to San Francisco and enrolled at the American Conservatory Theater. He left A.C.T. after only one year to seek work as an actor. His first paid acting role was in a summer stock theater stage production in St. Mary\'s City, Maryland. The play was \"Wings of the Morning\", which is about the founding of the colony of Maryland (now the state of Maryland) and the early days of the Maryland colonial assembly (a legislative body). He played the part of a real historical character, Mathias Da Sousa, although much of the dialogue was created. Afterwards he began to pursue screen roles in earnest. With his acting versatility and powerful sexual presence, he had no difficulty finding work in numerous television productions. He made his first big screen appearance in Carbon Copy (1981) with George Segal. Through the 1980s, he worked in both movies and television and was chosen for the plum role of Dr. Philip Chandler in NBC\'s hit medical series St. Elsewhere (1982), a role that he would play for six years. In 1989, his film career began to take precedence when he won the Oscar for Best Supporting Actor for his portrayal of Tripp, the runaway slave in Edward Zwick\'s powerful historical masterpiece Glory (1989).\n\nThrough the 1990s, Denzel co-starred in such big budget productions as The Pelican Brief (1993), Philadelphia (1993), Crimson Tide (1995), The Preacher\'s Wife (1996) and Courage Under Fire (1996), a role for which he was paid $10 million. His work in critically-acclaimed films continued simultaneously, with roles in Malcolm X (1992) and The Hurricane (1999) garnering him Oscar nominations for Best Actor, before he finally won that statuette in 2002 for his lead role in Training Day (2001). He continued to define his onscreen persona as the tough, no-nonsense hero through the 2000s in films like Inside Man (2006), The Book of Eli (2010), The Taking of Pelham 1 2 3 (2009) and Safe House (2012). Cerebral and meticulous in his film work, he made his debut as a director with Antwone Fisher (2002); he also directed The Great Debaters (2007). During this time period, he also took on the role of producer for some of his films, including The Book of Eli (2010) and Safe House (2012).\n\nHe lives in Los Angeles, California with his wife, Pauletta Washington, and their four children.', 'http://ia.media-imdb.com/images/M/MV5BMjE5NDU2Mzc3MV5BMl5BanBnXkFtZTcwNjAwNTE5OQ@@._V1_UY317_CR12,0,214,317_AL_.jpg', '1954-12-28');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Jeffrey Leon', 'Bridges', 'Jeffrey Leon Bridges was born on December 4, 1949 in Los Angeles, California, the son of well-known film and TV star Lloyd Bridges and his long-time wife Dorothy Dean Bridges (née Simpson). He grew up amid the happening Hollywood scene with big brother Beau Bridges. Both boys popped up, without billing, alongside their mother in the film The Company She Keeps (1951), and appeared on occasion with their famous dad on his popular underwater TV series Sea Hunt (1958) while growing up. At age 14, Jeff toured with his father in a stage production of \"Anniversary Waltz\". The \"troublesome teen\" years proved just that for Jeff and his parents were compelled at one point to intervene when problems with drugs and marijuana got out of hand.\n\nHe recovered and began shaping his nascent young adult career appearing on TV as a younger version of his father in the acclaimed TV-movie Silent Night, Lonely Night (1969), and in the strange Burgess Meredith film O tritos kataskopos (1970). Following fine notices for his portrayal of a white student caught up in the racially-themed Halls of Anger (1970), his career-maker arrived just a year later when he earned a coming-of-age role in the critically-acclaimed ensemble film The Last Picture Show (1971). The Peter Bogdanovich- directed film made stars out off its young leads (Bridges, Timothy Bottoms, Cybill Shepherd) and Oscar winners out of its older cast (Ben Johnson, Cloris Leachman). The part of Duane Jackson, for which Jeff received his first Oscar-nomination (for \"best supporting actor\"), set the tone for the types of roles Jeff would acquaint himself with his fans -- rambling, reckless, rascally and usually unpredictable).\n\nOwning a casual carefree handsomeness and armed with a perpetual grin and sly charm, he started immediately on an intriguing 70s sojourn into offbeat filming. Chief among them were his boxer on his way up opposite a declining Stacy Keach in Fat City (1972); his Civil War-era conman in the western Bad Company (1972); his redneck stock car racer in The Last American Hero (1973); his young student anarchist opposite a stellar veteran cast in Eugene O\'Neill\'s The Iceman Cometh (1973); his bank-robbing (also Oscar-nominated) sidekick to Clint Eastwood in Thunderbolt and Lightfoot (1974); his aimless cattle rustler in Rancho Deluxe (1975); his low-level western writer who wants to be a real-life cowboy in Hollywood Cowboy (1975); and his brother of an assassinated President who pursues leads to the crime in Winter Kills (1979). All are simply marvelous characters that should have propelled him to the very top rungs of stardom...but strangely didn\'t.\n\nPerhaps it was his trademark ease and naturalistic approach that made him somewhat under appreciated at that time when Hollywood was run by a Dustin Hoffman, Robert De Niro and Al Pacino-like intensity. Neverthless, Jeff continued to be a scene-stealing favorite into the next decade, notably as the video game programmer in the 1982 science-fiction cult classic TRON (1982), and the struggling musician brother vying with brother Beau Bridges over the attentions of sexy singer Michelle Pfeiffer in The Fabulous Baker Boys (1989). Jeff became a third-time Oscar nominee with his highly intriguing (and strangely sexy) portrayal of a blank-faced alien in Starman (1984), and earned even higher regard as the ever-optimistic inventor Preston Tucker in Tucker: The Man and His Dream (1988).\n\nSince then Jeff has continued to pour on the Bridges magic on film. Few enjoy such an enduring popularity while maintaining equal respect with the critics. The Fisher King (1991), American Heart (1992), Fearless (1993), The Big Lebowski (1998) (now a cult phenomenon) and The Contender (2000) (which gave him a fourth Oscar nomination) are prime examples. More recently he seized the moment as a bald-pated villain as Robert Downey Jr.\'s nemesis in Iron Man (2008) and then, at age 60, he capped his rewarding career by winning the elusive Oscar, plus the Golden Globe and Screen Actor Guild awards (among many others), for his down-and-out country singer Bad Blake in Crazy Heart (2009). Bridges next starred in TRON: Legacy (2010), reprising one of his more famous roles, and received another Oscar nomination for Best Actor for his role in the Western remake True Grit (2010). In 2014, he co-produced and starred in an adaptation of the Lois Lowry science fiction drama The Giver (2014).\n\nJeff has been married since 1977 to non-professional Susan Geston (they met on the set of Rancho Deluxe (1975)). The couple have three daughters, Isabelle (born 1981), Jessica (born 1983), and Hayley (born 1985). He hobbies as a photographer on and off his film sets, and has been known to play around as a cartoonist and pop musician. His ancestry is English, as well as some Irish and Swiss-German.', 'http://ia.media-imdb.com/images/M/MV5BNTU1NjM4MDYzMl5BMl5BanBnXkFtZTcwMjIwMjMyMw@@._V1_UY317_CR11,0,214,317_AL_.jpg', '1949-12-04');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('James Maitland', 'Stewart', 'James Maitland Stewart was born on 20 May 1908 in Indiana, Pennsylvania, to Elizabeth Ruth (Johnson) and Alexander Maitland Stewart, who owned a hardware store. He was of Scottish, Ulster-Scots, and some English, descent.\n\nStewart was educated at a local prep school, Mercersburg Academy, where he was a keen athlete (football and track), musician (singing and accordion playing), and sometime actor. In 1929 he won a place at Princeton, where he studied architecture with some success and became further involved with the performing arts as a musician and actor with the University Players.\n\nAfter graduation, engagements with the University Players took him around the northeastern United States, including a run on Broadway in 1932. But work dried up as the Great Depression deepened, and it wasn\'t until 1934, when he followed his friend Henry Fonda to Hollywood, that things began to pick up.\n\nAfter his first screen appearance in Art Trouble (1934), he worked for a time for MGM as a contract player and slowly began making a name for himself in increasingly high-profile roles throughout the rest of the 1930s. His famous collaborations with Frank Capra, in You Can\'t Take It With You (1938), Mr. Smith Goes to Washington (1939), and, after World War II, It\'s a Wonderful Life (1946) helped to launch his career as a star and to establish his screen persona as the likable everyman.\n\nHaving learned to fly in 1935, he was drafted into the U.S. Army in 1940 as a private (after twice failing the medical for being underweight). During the course of World War II he rose to the rank of colonel, first as an instructor at home in the United States, and later on combat missions in Europe. He remained involved with the U.S. Air Force Reserve after the war and retired in 1959 as a brigadier general.\n\nStewart\'s acting career took off properly after the war. During the course of his long professional life he had roles in some of Hollywood\'s best remembered films, starring in a string of Westerns (bringing his \"everyman\" qualities to movies like The Man Who Shot Liberty Valance (1962)), biopics (The Stratton Story (1949), The Glenn Miller Story (1954), and The Spirit of St. Louis (1957), for instance) thrillers (most notably his frequent collaborations with Alfred Hitchcock) and even some screwball comedies .\n\nHe continued to work into the 1990s and died at the age of 89 in 1997.', 'http://ia.media-imdb.com/images/M/MV5BMjIwNzMzODY0NV5BMl5BanBnXkFtZTcwMDk3NDQyOA@@._V1_UY317_CR20,0,214,317_AL_.jpg', '1908-05-20');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Laurence Kerr', 'Olivier', 'Laurence Olivier could speak William Shakespeare\'s lines as naturally as if he were \"actually thinking them\", said English playwright Charles Bennett, who met Olivier in 1927.\n\nLaurence Kerr Olivier was born in Dorking, Surrey, England, to Agnes Louise (Crookenden) and Gerard Kerr Olivier, a High Anglican priest. His surname came from a great-great-grandfather who was of French Huguenot origin.\n\nOne of Olivier\'s earliest successes as a Shakespearean actor on the London stage came in 1935 when he played \"Romeo\" and \"Mercutio\" in alternate performances of \"Romeo and Juliet\" with John Gielgud. A young Englishwoman just beginning her career on the stage fell in love with Olivier\'s Romeo. In 1937, she was \"Ophelia\" to his \"Hamlet\" in a special performance at Kronberg Castle, Elsinore, Denmark. In 1940, she became his second wife after both returned from making films in America that were major box office hits of 1939. His film was Wuthering Heights (1939), her film was Gone with the Wind (1939). Vivien Leigh and Olivier were screen lovers in Fire Over England (1937), 21 Days (1940) and That Hamilton Woman (1941). There was almost a fourth film together in 1944 when Olivier and Leigh traveled to Scotland with Charles C. Bennett to research the real-life story of a Scottish girl accused of murdering her French lover. Bennett recalled that Olivier researched the story \"with all the thoroughness of Sherlock Holmes\" and \"we unearthed evidence, never known or produced at the trial, that would most certainly have sent the young lady to the gallows\". The film project was then abandoned. During their two-decade marriage, Olivier and Leigh appeared on the stage in England and America and made films whenever they really needed to make some money. In 1951, Olivier was working on a screen adaptation of Theodore Dreiser\'s novel \"Sister Carrie\" (Carrie (1952)) while Leigh was completing work on the film version of the Tennessee Williams\' play, A Streetcar Named Desire (1951). She won her second Oscar for bringing \"Blanche DuBois\" to the screen. Carrie (1952) was a film that Olivier never talked about. George Hurstwood, a middle-aged married man from Chicago who tricked a young woman into leaving a younger man about to marry her, became a New York street person in the novel. Olivier played him as a somewhat nicer person who didn\'t fall quite as low. A PBS documentary on Olivier\'s career broadcast in 1987 covered his first sojourn in Hollywood in the early 1930s with his first wife, Jill Esmond, and noted that her star was higher than his at that time. On film, he was upstaged by his second wife, too, even though the list of films he made is four times as long as hers. More than half of his film credits come after The Entertainer (1960), which started out as a play in London in 1957. When the play moved across the Atlantic to Broadway in 1958, the role of \"Archie Rice\"\'s daughter was taken over by Joan Plowright, who was also in the film. They married soon after the release of The Entertainer (1960).', 'http://ia.media-imdb.com/images/M/MV5BMTkwNjYwNDE5M15BMl5BanBnXkFtZTYwNzg0MDQ2._V1_UY317_CR18,0,214,317_AL_.jpg', '1907-05-22');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Maruice Joseph', 'Micklewhite', 'Michael Caine was born Maurice Joseph Micklewhite in London, to Ellen Frances Marie (Burchell), a charlady, and Maurice Joseph Micklewhite, a fish-market porter. He left school at 15 and took a series of working-class jobs before joining the British army and serving in Korea during the Korean War, where he saw combat. Upon his return to England he gravitated toward the theater and got a job as an assistant stage manager. He adopted the name of Caine on the advice of his agent, taking it from a marquee that advertised The Caine Mutiny (1954). In the years that followed he worked in more than 100 television dramas, with repertory companies throughout England and eventually in the stage hit, \"The Long and the Short and the Tall.\" Zulu (1964), the 1964 epic retelling of a historic 19th-century battle in South Africa between British soldiers and Zulu warriors, brought Caine to international attention. Instead of being typecast as a low-ranking Cockney soldier, he played a snobbish, aristocratic officer. Although \"Zulu\" was a major success, it was the role of Harry Palmer in The Ipcress File (1965) and the title role in Alfie (1966) that made Caine a star of the first magnitude. He epitomized the new breed of actor in mid-\'60s England, the working-class bloke with glasses and a down-home accent. However, after initially starring in some excellent films, particularly in the 1960s, including Gambit (1966), Funeral in Berlin (1966), Play Dirty (1969), Battle of Britain (1969), Too Late the Hero (1970), The Last Valley (1971) and especially Get Carter (1971), he seemed to take on roles in below-average films, simply for the money he could by then command. There were some gems amongst the dross, however. He gave a magnificent performance opposite Sean Connery in The Man Who Would Be King (1975) and turned in a solid one as a German colonel in The Eagle Has Landed (1976). Educating Rita (1983) and Hannah and Her Sisters (1986) (for which he won his first Oscar) were highlights of the 1980s, while more recently Little Voice (1998), The Cider House Rules (1999) (his second Oscar) and Last Orders (2001) have been widely acclaimed.', 'http://ia.media-imdb.com/images/M/MV5BMjAwNzIwNTQ4Ml5BMl5BanBnXkFtZTYwMzE1MTUz._V1_UY317_CR7,0,214,317_AL_.jpg', '1933-03-14');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Morgan ', 'Freeman', 'With an authoritative voice and calm demeanor, this ever popular American actor has grown into one of the most respected figures in modern US cinema. Morgan was born in June 1937 in Memphis, Tennessee, to Mayme Edna (Revere), a teacher, and Morgan Porterfield Freeman, a barber. The young Freeman attended Los Angeles City College before serving several years in the US Air Force as a mechanic between 1955 and 1959. His first dramatic arts exposure was on the stage including appearing in an all-African American production of the exuberant musical Hello, Dolly!.\n\nThroughout the 1970s, he continued his work on stage, winning Drama Desk and Clarence Derwent Awards and receiving a Tony Award nomination for his performance in The Mighty Gents in 1978. In 1980, he won two Obie Awards, for his portrayal of Shakespearean anti-hero Coriolanus at the New York Shakespeare Festival and for his work in Mother Courage and Her Children. Freeman won another Obie in 1984 for his performance as The Messenger in the acclaimed Brooklyn Academy of Music production of Lee Breuer\'s The Gospel at Colonus and, in 1985, won the Drama-Logue Award for the same role. In 1987, Freeman created the role of Hoke Coleburn in Alfred Uhry\'s Pulitzer Prize-winning play Driving Miss Daisy, which brought him his fourth Obie Award. In 1990, Freeman starred as Petruchio in the New York Shakespeare Festival\'s The Taming of the Shrew, opposite Tracey Ullman. Returning to the Broadway stage in 2008, Freeman starred with Frances McDormand and Peter Gallagher in Clifford Odets\' drama The Country Girl, directed by Mike Nichols.\n\nFreeman first appeared on TV screens as several characters including \"Easy Reader\", \"Mel Mounds\" and \"Count Dracula\" on the Children\'s Television Workshop (now Sesame Workshop) show The Electric Company (1971). He then moved into feature film with another children\'s adventure, Who Says I Can\'t Ride a Rainbow! (1971). Next, there was a small role in the thriller Blade (1973); then he played Casca in Julius Caesar (1979) and the title role in Coriolanus (1979). Regular work was coming in for the talented Freeman and he appeared in the prison dramas Attica (1980) and Brubaker (1980), Eyewitness (1981), and portrayed the final 24 hours of slain Malcolm X in Death of a Prophet (1981). For most of the 1980s, Freeman continued to contribute decent enough performances in films that fluctuated in their quality. However, he really stood out, scoring an Oscar nomination as a merciless hoodlum in Street Smart (1987) and, then, he dazzled audiences and pulled a second Oscar nomination in the film version of Driving Miss Daisy (1989) opposite Jessica Tandy. The same year, Freeman teamed up with youthful Matthew Broderick and fiery Denzel Washington in the epic Civil War drama Glory (1989) about freed slaves being recruited to form the first all-African American fighting brigade.\n\nHis star continued to rise, and the 1990s kicked off strongly with roles in The Bonfire of the Vanities (1990), Robin Hood: Prince of Thieves (1991), and The Power of One (1992). Freeman\'s next role was as gunman Ned Logan, wooed out of retirement by friend William Munny to avenge several prostitutes in the wild west town of Big Whiskey in Clint Eastwood\'s de-mythologized western Unforgiven (1992). The film was a sh and scored an acting Oscar for Gene Hackman, a directing Oscar for Eastwood, and the Oscar for best picture. In 1993, Freeman made his directorial debut on Bopha! (1993) and soon after formed his production company, Revelations Entertainment.\n\nMore strong scripts came in, and Freeman was back behind bars depicting a knowledgeable inmate (and obtaining his third Oscar nomination), befriending falsely accused banker Tim Robbins in The Shawshank Redemption (1994). He was then back out hunting a religious serial killer in Se7en (1995), starred alongside Keanu Reeves in Chain Reaction (1996), and was pursuing another serial murderer in Kiss the Girls (1997).\n\nFurther praise followed for his role in the slave tale of Amistad (1997), he was a worried US President facing Armageddon from above in Deep Impact (1998), appeared in Neil LaBute\'s black comedy Nurse Betty (2000), and reprised his role as Alex Cross in Along Came a Spider (2001). Now highly popular, he was much in demand with cinema audiences, and he co-starred in the terrorist drama The Sum of All Fears (2002), was a military officer in the Stephen King-inspired Dreamcatcher (2003), gave divine guidance as God to Jim Carrey in Bruce Almighty (2003), and played a minor role in the comedy The Big Bounce (2004).\n\n2005 was a huge year for Freeman. First, he he teamed up with good friend Clint Eastwood to appear in the drama, Million Dollar Baby (2004). Freeman\'s on-screen performance is simply world-class as ex-prize fighter Eddie \"Scrap Iron\" Dupris, who works in a run-down boxing gym alongside grizzled trainer Frankie Dunn, as the two work together to hone the skills of never-say-die female boxer Hilary Swank. Freeman received his fourth Oscar nomination and, finally, impressed the Academy\'s judges enough to win the Best Supporting Actor Oscar for his performance. He also narrated Steven Spielberg\'s War of the Worlds (2005) and appeared in Batman Begins (2005) as Lucius Fox, a valuable ally of Christian Bale\'s Bruce Wayne/Batman for director Christopher Nolan. Freeman would reprise his role in the two sequels of the record-breaking, genre-redefining trilogy.\n\nRoles in tentpoles and indies followed; highlights include his role as a crime boss in Lucky Number Slevin (2006), a second go-round as God in Evan Almighty (2007) with Steve Carell taking over for Jim Carrey, and a supporting role in Ben Affleck\'s directorial debut, Gone Baby Gone (2007). He co-starred with Jack Nicholson in the breakout hit The Bucket List (2007) in 2007, and followed that up with another box-office success, Wanted (2008), then segued into the second Batman film, The Dark Knight (2008).\n\nIn 2009, he reunited with Eastwood to star in the director\'s true-life drama Invictus (2009), on which Freeman also served as an executive producer. For his portrayal of Nelson Mandela in the film, Freeman garnered Oscar, Golden Globe and Critics\' Choice Award nominations, and won the National Board of Review Award for Best Actor.\n\nRecently, Freeman appeared in RED (2010), a surprise box-office hit; he narrated the Conan the Barbarian (2011) remake, starred in Rob Reiner\'s The Magic of Belle Isle (2012); and capped the Batman trilogy with The Dark Knight Rises (2012). Freeman has several films upcoming, including the thriller Η συμμορία των μάγων (2013), under the direction of Louis Leterrier, and the science fiction actioner Oblivion (2013), in which he stars with Tom Cruise.', 'http://ia.media-imdb.com/images/M/MV5BMTc0MDMyMzI2OF5BMl5BanBnXkFtZTcwMzM2OTk1MQ@@._V1_UX214_CR0,0,214,317_AL_.jpg', '1937-06-01');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Sean Justin', 'Penn', 'Sean Penn is a powerhouse film performer capable of intensely moving work, who has gone from strength to strength during a colourful film career, and who has drawn much media attention for his stormy private life and political viewpoints.\n\nSean Justin Penn was born in Los Angeles, California, the second son of actress Eileen Ryan (née Annucci) and director, actor, and writer Leo Penn. His brother was actor Chris Penn. His father was from a Lithuanian Jewish/Russian Jewish family, and his mother is of half Italian and half Irish descent.\n\nPenn first appeared in roles as strong-headed or unruly youths such as the military cadet defending his academy against closure in Taps (1981), then as fast-talking surfer stoner Jeff Spicoli in Fast Times at Ridgemont High (1982).\n\nFans and critics were enthused about his obvious talent and he next contributed a stellar performance alongside Timothy Hutton in the Cold War spy thriller The Falcon and the Snowman (1985), followed by a teaming with icy Christopher Walken in the chilling At Close Range (1986). The youthful Sean then paired up with his then wife, pop diva Madonna in the woeful, and painful, Shanghai Surprise (1986), which was savaged by the critics, but Sean bounced back with a great job as a hot-headed young cop in Colors (1988), gave another searing performance as a US soldier in Vietnam committing atrocities in Casualties of War (1989) and appeared alongside Robert De Niro in the uneven comedy We\'re No Angels (1989). However, the 1990s was the decade in which Sean really got noticed by critics as a mature, versatile and accomplished actor, with a string of dynamic performances in first-class films.\n\nAlmost unrecognisable with frizzy hair and thin rimmed glasses, Penn was simply brilliant as corrupt lawyer David Kleinfeld in the Brian De Palma gangster movie Carlito\'s Way (1993) and he was still in trouble with authority as a Death Row inmate pleading with a caring nun to save his life in Dead Man Walking (1995), for which he received his first Oscar nomination. Sean then played the brother of wealthy Michael Douglas, involving him in a mind-snapping scheme in The Game (1997) and also landed the lead role of Sgt. Eddie Walsh in the star-studded anti-war film The Thin Red Line (1998), before finishing the 1990s playing an offbeat jazz musician (and scoring another Oscar nomination) in Sweet and Lowdown (1999).\n\nThe gifted and versatile Sean had also moved into directing, with the quirky but interesting The Indian Runner (1991), about two brothers with vastly opposing views on life, and in 1995 he directed Jack Nicholson in The Crossing Guard (1995). Both films received overall positive reviews from critics. Moving into the new century, Sean remained busy in front of the cameras with even more outstanding work: a mentally disabled father fighting for custody of his seven-year-old daughter (and receiving a third Oscar nomination) for I Am Sam (2001); an anguished father seeking revenge for his daughter\'s murder in the gut-wrenching Clint Eastwood-directed Mystic River (2003) (for which he won the Oscar as Best Actor); a mortally ill college professor in 21 Grams (2003) and a possessed businessman in The Assassination of Richard Nixon (2004).\n\nCertainly Sean Penn is one of Hollywood\'s most controversial, progressive and gifted actors.', 'http://ia.media-imdb.com/images/M/MV5BMTc1NjMzMjY3NF5BMl5BanBnXkFtZTcwMzkxNjQzMg@@._V1_UY317_CR1,0,214,317_AL_.jpg', '1960-08-17');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Robert Selden', 'Duval', 'Veteran actor and director Robert Selden Duvall was born on January 5, 1931, in San Diego, CA, to Mildred Virginia (Hart), an amateur actress, and William Howard Duvall, a career military officer who later became an admiral. Duvall majored in drama at Principia College (Elsah, IL), then served a two-year hitch in the army after graduating in 1953. He began attending The Neighborhood Playhouse School of the Theatre In New York City on the G.I. Bill in 1955, studying under Sanford Meisner along with Dustin Hoffman, with whom Duvall shared an apartment. Both were close to another struggling young actor named Gene Hackman. Meisner cast Duvall in the play \"The Midnight Caller\" by Horton Foote, a link that would prove critical to his career, as it was Foote who recommended Duvall to play the mentally disabled \"Boo Radley\" in To Kill a Mockingbird (1962). This was his first \"major\" role since his 1956 motion picture debut as an MP was in Somebody Up There Likes Me (1956), starring Paul Newman.\n\nDuvall began making a name for himself as a stage actor in New York, winning an Obie Award in 1965 playing incest-minded longshoreman \"Eddie Carbone\" in the off-Broadway revival of Arthur Miller\'s \"A View from the Bridge\", a production for which his old roommate Hoffman was assistant director. He found steady work in episodic TV and appeared as a modestly billed character actor in films, such as Arthur Penn\'s The Chase (1966) with Marlon Brando and in Robert Altman\'s Countdown (1967) and Francis Ford Coppola\'s The Rain People (1969), in both of which he co-starred with James Caan.\n\nHe was also memorable as the heavy who is shot by John Wayne at the climax of True Grit (1969) and was the first \"Maj. Frank Burns\", creating the character in Altman\'s Korean War comedy M.A.S.H. (1970). He also appeared as the eponymous lead in George Lucas\' directorial debut, THX 1138 (1971). It was Francis Ford Coppola, casting The Godfather (1972), who reunited Duvall with Brando and Caan and provided him with his career breakthrough as mob lawyer \"Tom Hagen\". He received the first of his six Academy Award nominations for the role.\n\nThereafter, Duvall had steady work in featured roles in such films as The Godfather: Part II (1974), The Killer Elite (1975), Network (1976), The Seven-Per-Cent Solution (1976) and The Eagle Has Landed (1976). Occasionally this actor\'s actor got the chance to assay a lead role, most notably in Tomorrow (1972), in which he was brilliant as William Faulkner\'s inarticulate backwoods farmer. He was less impressive as the lead in Badge 373 (1973), in which he played a character based on real-life NYPD detective Eddie Egan, the same man his old friend Gene Hackman had won an Oscar for playing, in fictionalized form as \"Popeye Doyle\" in The French Connection (1971).\n\nIt was his appearance as \"Lt. Col. Kilgore\" in another Coppola picture, Apocalypse Now (1979), that solidified Duvall\'s reputation as a great actor. He got his second Academy Award nomination for the role, and was named by the Guinness Book of World Records as the most versatile actor in the world. Duvall created one of the most memorable characters ever assayed on film, and gave the world the memorable phrase, \"I love the smell of napalm in the morning!\".\n\nSubsequently, Duvall proved one of the few established character actors to move from supporting to leading roles, with his Oscar-nominated turns in The Great Santini (1979) and Tender Mercies (1983), the latter of which won him the Academy Award for Best Actor. Now at the summit of his career, Duvall seemed to be afflicted with the fabled \"Oscar curse\" that had overwhelmed the careers of fellow Academy Award winners Luise Rainer, Rod Steiger and Cliff Robertson. He could not find work equal to his talents, either due to his post-Oscar salary demands or a lack of perception in the industry that he truly was leading man material. He did not appear in The Godfather: Part III (1990), as the studio would not give in to his demands for a salary commensurate with that of Al Pacino, who was receiving $5 million to reprise Michael Corleone.\n\nHis greatest achievement in his immediate post-Oscar period was his triumphant characterization of grizzled Texas Ranger Gus McCrae in the TV mini-series Lonesome Dove (1989), for which he received an Emmy nomination. He received a second Emmy nomination and a Golden Globe for his portrayal of Soviet dictator Joseph Stalin in Stalin (1992), and a third Emmy nomination playing Nazi war criminal Adolf Eichmann in The Man Who Captured Eichmann (1996).\n\nThe shakeout of his career doldrums was that Duvall eventually settled back into his status as one of the premier character actors in the industry, rivaled only by his old friend Gene Hackman. Duvall, unlike Hackman, also has directed pictures, including the documentary We\'re Not the Jet Set (1977), Angelo My Love (1983) and Assassination Tango (2002). As a writer-director, Duvall gave himself one of his most memorable roles, that of the preacher on the run from the law in The Apostle (1997), a brilliant performance for which he received his third Best Actor nomination and fifth Oscar nomination overall. The film brought Duvall back to the front ranks of great actors, and was followed by a Best Supporting Actor Oscar nod for A Civil Action (1998).\n\nRobert Duvall will long be remembered as one of the great naturalistic American screen actors in the mode of Spencer Tracy and his frequent co-star Marlon Brando. His performances as \"Boo Radley\" in To Kill a Mockingbird (1962), \"Jackson Fentry\" in Tomorrow (1972), \"Tom Hagen\" in the first two \"Godfather\" movies, \"Frank Hackett\" in Network (1976), \"Lt. Col. Kilgore\" in Apocalypse Now (1979), \"Bull Meechum\" in The Great Santini (1979), \"Mac Sledge\" in Tender Mercies (1983), \"Gus McCrae\" in Lonesome Dove (1989) and \"Sonny Dewey\" in The Apostle (1997) rank as some of the finest acting ever put on film. It\'s a body of work that few actors can equal, let alone surpass.', 'http://ia.media-imdb.com/images/M/MV5BMjk1MjA2Mjc2MF5BMl5BanBnXkFtZTcwOTE4MTUwMg@@._V1_UY317_CR6,0,214,317_AL_.jpg', '1931-01-05');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Robin McLaurin', 'Williams', 'Robin McLaurin Williams was born on Saturday, July 21st, 1951, in Chicago, Illinois, a great-great-grandson of Mississippi Governor and Senator, Anselm J. McLaurin. His mother, Laurie McLaurin (née Janin), was a former model from Mississippi, and his father, Robert Fitzgerald Williams, was a Ford Motor Company executive from Indiana. Williams had English, German, French, Welsh, Irish, and Scottish ancestry.\n\nRobin briefly studied political science before enrolling at Juilliard School to study theatre. After leaving Juilliard, he performed in nightclubs where he was discovered for the role of \"Mork, from Ork\", in an episode of Happy Days (1974). The episode, Happy Days: My Favorite Orkan (1978), led to his famous spin-off weekly TV series, Mork & Mindy (1978). He made his feature starring debut playing the title role in Popeye (1980), directed by Robert Altman.\n\nWilliams\' continuous comedies and wild comic talents involved a great deal of improvisation, following in the footsteps of his idol Jonathan Winters. Williams also proved to be an effective dramatic actor, receiving Academy Award nominations for Best Actor in a Leading Role in Good Morning, Vietnam (1987), Dead Poets Society (1989), and The Fisher King (1991), before winning the Academy Award for Best Actor in a Supporting Role in Good Will Hunting (1997).\n\nDuring the 1990s, Williams became a beloved hero to children the world over for his roles in a string of hit family-oriented films, including Hook (1991), FernGully: The Last Rainforest (1992), Aladdin (1992), Mrs. Doubtfire (1993), Jumanji (1995), Flubber (1997), and Bicentennial Man (1999). He continued entertaining children and families into the 21st century with his work in Robots (2005), Happy Feet (2006), Night at the Museum (2006), Night at the Museum 2 (2009), Happy Feet 2 (2011), and Night at the Museum: Secret of the Tomb (2014). Other more adult-oriented films for which Williams received acclaim include The World According to Garp (1982), Moscow on the Hudson (1984), Awakenings (1990), The Birdcage (1996), Insomnia (2002), One Hour Photo (2002), World\'s Greatest Dad (2009), and Boulevard (2014).\n\nOn Monday, August 11th, 2014, Robin Williams was found dead at his home in Tiburon, California USA, the victim of an apparent suicide, according to the Marin County Sheriff\'s Department. A 911 call was received at 11:55 AM PDT, firefighters and paramedics arrived at his home at 12:00 PM PDT, and he was pronounced dead at 12:02 PM PDT.', 'http://ia.media-imdb.com/images/M/MV5BNTYzMjc2Mjg4MF5BMl5BanBnXkFtZTcwODc1OTQwNw@@._V1_UX214_CR0,0,214,317_AL_.jpg', '1951-07-21');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Philip Seymour', 'Hoffman', 'Film and stage actor and theater director Philip Seymour Hoffman was born in the Rochester, New York, suburb of Fairport on July 23, 1967. He was the son of Marilyn (Loucks), a lawyer and judge, and Gordon Stowell Hoffman, a Xerox employee, and was mostly of German, Irish, English and Dutch ancestry. After becoming involved in high school theatrics, he attended New York University\'s Tisch School of the Arts, graduating with a B.F.A. degree in Drama in 1989. He made his feature film debut in the indie production Triple Bogey on a Par Five Hole (1991) as Phil Hoffman, and his first role in a major release came the next year in My New Gun (1992). While he had supporting roles in some other major productions like Scent of a Woman (1992) and Twister (1996), his breakthrough role came in Paul Thomas Anderson\'s Boogie Nights (1997). He quickly became an icon of indie cinema, establishing a reputation as one of the screen\'s finest actors, in a variety of supporting and second leads in indie and major features, including Todd Solondz\'s Happiness (1998), Flawless (1999), The Talented Mr. Ripley (1999), Paul Thomas Anderson\'s Magnolia (1999), Almost Famous (2000) and State and Main (2000). He also appeared in supporting roles in such mainstream, big-budget features as Red Dragon (2002), Cold Mountain (2003) and Mission: Impossible III (2006). Hoffman was also quite active on the stage. On Broadway, he has earned two Tony nominations, as Best Actor (Play) in 2000 for a revival of Sam Shepard\'s \"True West\" and as Best Actor (Featured Role - Play) in 2003 for a revival of Eugene O\'Neill (I)\'s \"Long Day\'s Journey into Night\". His other acting credits in the New York theater include \"The Seagull\" (directed by Mike Nichols for The New York Shakespeare Festival), \"Defying Gravity\", \"The Merchant of Venice\" (directed by Peter Sellars), \"Shopping and F*@%ing\" and \"The Author\'s Voice\" (Drama Desk nomination). He is the Co-Artistic Director of the LAByrinth Theater Company in New York, for which he directed \"Our Lady of 121st Street\" by Stephen Adly Guirgis. He also has directed \"In Arabia, We\'d All Be Kings\" and \"Jesus Hopped the A Train\" by Guirgis for LAByrinth, and \"The Glory of Living\" by Rebecca Gilman at the Manhattan Class Company. Hoffman consolidated his reputation as one of the finest actors under the age of 40 with his turn in the title role of Truman Capote (2005), for which he won the Los Angeles Film Critics Award as Best Actor. In 2006, he was awarded the Best Actor Oscar for the same role. On February 2, 2014, Philip Seymour Hoffman was found dead in an apartment in Greenwich village, New York. Investigators found Hoffman with a syringe in his arm and two open envelopes of heroin next to him. Mr. Hoffman was long known to struggle with addiction. In 2006, he said in an interview with \"60 Minutes\" that he had given up drugs and alcohol many years earlier, when he was age 22. In 2013, he checked into a rehabilitation program for about 10 days after a reliance on prescription pills resulted in his briefly turning again to heroin.', 'http://ia.media-imdb.com/images/M/MV5BMTQ0NTA1NTg3Ml5BMl5BanBnXkFtZTcwNzkxNzgxNw@@._V1_UY317_CR8,0,214,317_AL_.jpg', '1967-07-23');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Russell Ira', 'Crowe', 'Russell Ira Crowe was born in Wellington, New Zealand, to Jocelyn Yvonne (Wemyss) and John Alexander Crowe, both of whom catered movie sets. His maternal grandfather, Stanley Wemyss, was a cinematographer. Crowe\'s recent ancestry includes Welsh (where his paternal grandfather was born, in Wrexham), English, Irish, Scottish, Norwegian, Swedish, and Maori (one of Crowe\'s maternal great-grandmothers, Erana Putiputi Hayes Heihi, was Maori).\n\nCrowe\'s family moved to Australia when he was a small child, and Russell got the acting bug early in life. Beginning as a child star on a local Australian TV show, Russell\'s first big break came with two films ... the first, Σαρώνω (1992), gained him a name throughout the film community in Australia and the neighboring countries. The second, The Sum of Us (1994), helped put him on the American map, so to speak. Sharon Stone heard of him from Σαρώνω (1992) and wanted him for her film, Γρήγορη και Θανάσιμη (1995). But filming on The Sum of Us (1994) had already begun. Sharon is reported to have held up shooting until she had her gunslinger-Crowe, for her film. With Γρήγορη και Θανάσιμη (1995) under his belt as his first American film, the second was offered to him soon after. Virtuosity (1995), starring Denzel Washington, put Russell in the body of a Virtual Serial Killer, Sid6.7 ... a role unlike any he had played so far. Virtuosity (1995), a Sci-Fi extravaganza, was a fun film and, again, opened the door to even more American offers. L.A. Confidential (1997), Russell\'s third American film, brought him the US fame and attention that his fans have felt he deserved all along. Missing the Oscar nod this time around, he didn\'t seem deterred and signed to do his first film with The Walt Disney Company, Mystery, Alaska (1999). He achieved even more success and awards for his performances in Gladiator (2000) and A Beautiful Mind (2001).', 'http://ia.media-imdb.com/images/M/MV5BMTQyMTExNTMxOF5BMl5BanBnXkFtZTcwNDg1NzkzNw@@._V1_UX214_CR0,0,214,317_AL_.jpg', '1964-04-07');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Clinton Jr.', 'Eastwood', 'Perhaps the icon of macho movie stars, Clint Eastwood has become a standard in international cinema. He was born in 1930 in San Francisco, to Margaret Ruth (Runner), a factory worker, and Clinton Eastwood, Sr., a steelworker. Eastwood briefly attended Los Angeles City College but dropped out to pursue acting. He found bit work in such B-films as Revenge of the Creature (1955) and Tarantula (1955) until he got his first breakthrough in the long-running TV series Rawhide (1959). As Rowdy Yates, he made the show his own and became a household name around the country.\n\nEastwood found bigger and better things in Italy with the spaghetti westerns A Fistful of Dollars (1964) and For a Few Dollars More (1965), but it was the third installment in the trilogy where he found one of his signature roles: The Good, the Bad and the Ugly (1966). The movie was a big hit and brought him instant international recognition. He followed it up with his first American-made western, Hang \'Em High (1968), before playing second fiddle to Richard Burton in the World War II epic Where Eagles Dare (1968) and Lee Marvin in the unusual musical Paint Your Wagon (1969). In Οι γύπες πετούν χαμηλά (1970) and Kelly\'s Heroes (1970), Eastwood combined tough-guy action with offbeat humor.\n\n1971 proved to be one of his best years in film, if not the best. He starred in The Beguiled (1971) and the cult classic Play Misty for Me (1971). But it was his role as the hard edge police inspector in Dirty Harry (1971) that elevated Eastwood to superstar status and invented the loose-cannon cop genre that has been imitated even to this day. Eastwood had constant quality films over the following years with Thunderbolt and Lightfoot (1974) opposite Jeff Bridges, the Dirty Harry sequels Magnum Force (1973) and The Enforcer (1976), the westerns Joe Kidd (1972), High Plains Drifter (1973) and The Outlaw Josey Wales (1976), and the fact-based thriller Escape from Alcatraz (1979). In 1978 Eastwood branched out into the comedy genre with Every Which Way But Loose (1978), which became the biggest hit of his career up to that time. Taking inflation into account, it still is.\n\nEastwood kicked off the eighties with Any Which Way You Can (1980), the blockbuster sequel to Every Which Way But Loose. The fourth Dirty Harry film, Sudden Impact (1983), was the highest-grossing film of the franchise and spawned Eastwood\'s trademark catchphrase, \"Make my day\". Eastwood also starred in Firefox (1982), Tightrope (1984), City Heat (1984) (with Burt Reynolds), Pale Rider (1985), and Heartbreak Ridge (1986), which were all big hits. In 1988 Eastwood did his fifth and final Dirty Harry movie, The Dead Pool (1988). Although it was a success overall, it did not have the box office punch his previous films had. Shortly thereafter, with outright bombs like Pink Cadillac (1989) and The Rookie (1990), it became apparent that Eastwood\'s star was declining as it never had before. He then started taking on more personal projects, such as directing Bird (1988), a biopic of Charlie Parker, and starring in and directing White Hunter Black Heart (1990), an uneven, loose biopic of John Huston.\n\nBut Eastwood bounced back, first with his western, Unforgiven (1992), which garnered him an Oscar for Best Director, and a nomination for Best Actor. Then he took on the secret service in In the Line of Fire (1993), which was a big hit, followed by the interesting but poorly received drama, A Perfect World (1993), with Kevin Costner. Next up was a love story, The Bridges of Madison County (1995), which was yet again a success. Eastwood\'s subsequent films were solid but nothing really stuck out. Among them were the well-received Absolute Power (1997) and Space Cowboys (2000), and the badly received True Crime (1999) and Blood Work (2002). Then in 2004, Eastwood surprised yet again when he produced, directed and starred in Million Dollar Baby (2004). The movie earned Eastwood an Oscar for Best Director and a Best Actor nomination for the second time. He had other successes directing the multi-award-winning films Mystic River (2003), Flags of Our Fathers (2006), Letters from Iwo Jima (2006), and Changeling (2008) which starred Angelina Jolie. After a four-year hiatus from acting, Eastwood\'s return to the screen in Gran Torino (2008) gave him a $30 million opening weekend, proving his box office appeal has not waned.\n\nEastwood has managed to keep his extremely complicated personal life private and has rarely been featured in the tabloids. He had a long time relationship with frequent co-star Sondra Locke and has eight children by six other women, although he has only been married twice. Eastwood divides his time between Los Angeles and Carmel.', 'http://ia.media-imdb.com/images/M/MV5BMTg3MDc0MjY0OV5BMl5BanBnXkFtZTcwNzU1MDAxOA@@._V1_UY317_CR10,0,214,317_AL_.jpg', '1930-05-31');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Krishna', 'Bhanji', 'Ben Kingsley was born in Scarborough, Yorkshire, England. His father, Rahimtulla Harji Bhanji, is of Gujarati Indian descent, and his mother Anna Lyna Mary, was English. Ben began to act in stage plays during the 1960s. He soon became a successful stage actor, and also began to have roles in films and TV. His birth name was Krishna Bhanji, but he changed his name to \"Ben Kingsley\" soon after gaining fame as a stage actor, fearing that a foreign name could hamper his acting career.\n\nBen Kingsley first earned international fame for his performance in the 1982 movie, Gandhi (1982). His performance as \"Mahatma Gandhi\" earned him international fame. He won many awards - including an Oscar for Best Actor. He also won Golden Globe, BAFTA and London Film Critics\' Circle Awards. After acting in Gandhi (1982), Ben was recognized as one of the finest British actors.\n\nAfter his international fame for appearing in Gandhi (1982), Kingsley appeared in many other famous movies. His success as an actor continued. In 1993, his performance as \"Itzhak Stern\" in the movie, Schindler\'s List (1993) earned him a BAFTA nomination. Schindler\'s List (1993) won seven Oscars, including Best Picture. During the late 1990s, Kingsley acted in many successful movies. He played \"Sweeney Todd\" in the 1998 TV movie, The Tale of Sweeney Todd (1997). For his performance in this movie, he was nominated for the Screen Actors\' Guild Award. His other notable role was as \"Otto Frank\" in the TV movie Anne Frank (2001), for which he won a Screen Actors\' Guild Award.\n\nBen Kingsley lives in Spelsbury, Oxfordshire, in England.', 'http://ia.media-imdb.com/images/M/MV5BNjE0Mjc5Nzg4OV5BMl5BanBnXkFtZTcwMzk3Njg0Mw@@._V1_UX214_CR0,0,214,317_AL_.jpg', '1943-12-31');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Tommy Lee', 'Jones', 'Tommy Lee Jones was born in San Saba, Texas, the son of Lucille Marie (Scott), a police officer and beauty shop owner, and Clyde C. Jones, who worked on oil fields. Tommy himself worked in underwater construction and on an oil rig. He attended St. Mark\'s School of Texas, a prestigious prep school for boys in Dallas, on a scholarship, and went to Harvard on another scholarship. He roomed with future Vice President Al Gore and played offensive guard in the famous 29-29 Harvard-Yale football game of \'68 known as \"The Tie.\" He received a B.A. in English literature and graduated cum laude from Harvard in 1969.\n\nFollowing college, he moved to New York and began his theatrical career on Broadway in \"A Patriot for Me\" (1969). In 1970, he made his film debut in Love Story (1970). While living in New York, he continued to appear in various plays, both on- and off-Broadway: \"Fortune and Men\'s Eyes\" (1969); \"Four on a Garden\" (1971); \"Blue Boys\" (1972); \"Ulysses in Nighttown\" (1974). During this time, he also appeared on a daytime soap opera, One Life to Live (1968) as Dr. Mark Toland from 1971-75. He moved with wife Kate Lardner, granddaughter of short-story writer/columnist Ring Lardner, and her two children from a previous marriage, to Los Angeles.\n\nThere he began to get some roles on television: Charlie\'s Angels (1976) (pilot episode); Smash-Up on Interstate 5 (1976); and The Amazing Howard Hughes (1977). While working on the movie Back Roads (1981), he met and fell in love with Kimberlea Cloughley, whom he later married. More roles in television--both on network and cable--stage and film garnered him a reputation as a strong, explosive, thoughtful actor who could handle supporting as well as leading roles. He made his directorial debut in The Good Old Boys (1995) on TNT. In addition to directing and starring in the film, he co-wrote the teleplay (with J.T. Allen). The film, based on Elmer Kelton\'s novel, is set in west Texas where Jones has strong family ties. Consequently, this story of a cowboy facing the end of an era has special meaning for him.', 'http://ia.media-imdb.com/images/M/MV5BMTkyNjc4MDc0OV5BMl5BanBnXkFtZTcwOTc5OTUwOQ@@._V1_UX214_CR0,0,214,317_AL_.jpg', '1946-09-15');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Angelina', 'Jolie', 'Angelina Jolie is an Oscar-winning actress who became popular after playing the title role in the \"Lara Croft\" blockbuster movies, as well as Mr. & Mrs. Smith (2005), Wanted (2008), Salt (2010) and Maleficent (2014). Off-screen, Jolie has become prominently involved in international charity projects, especially those involving refugees. She often appears on many \"most beautiful women\" lists, and she has a personal life that is avidly covered by the tabloid press.\n\nJolie was born Angelina Jolie Voight in Los Angeles, California. In her earliest years, Angelina began absorbing the acting craft from her actor parents, Jon Voight, an Oscar-winner, and Marcheline Bertrand, who had studied with Lee Strasberg. Her good looks may derive from her ancestry, which is German and Slovak on her father\'s side, and French-Canadian, Dutch, German, Czech, and remote Huron, on her mother\'s side. At age eleven, Angelina began studying at the Lee Strasberg Theatre Institute, where she was seen in several stage productions. She undertook some film studies at New York University and later joined the renowned Met Theatre Group in Los Angeles. At age 16, she took up a career in modeling and appeared in some music videos.\n\nIn the mid-1990s, Jolie appeared in various small films where she got good notices, including Hackers (1995) and Foxfire (1996). Her critical acclaim increased when she played strong roles in the made-for-TV movies True Women (1997), and in George Wallace (1997) which won her a Golden Globe Award and an Emmy nomination. Jolie\'s acclaim increased even further when she played the lead role in the HBO production Gia (1998). This was the true life story of supermodel Gia Carangi, a sensitive wild child who was both brazen and needy and who had a difficult time handling professional success and the deaths of people who were close to her. Carangi became involved with drugs and because of her needle-using habits she became, at the tender age of 26, one of the first celebrities to die of AIDS. Jolie\'s performance in Gia (1998) again garnered a Golden Globe Award and another Emmy nomination, and she additionally earned a SAG Award.\n\nAngelina got a major break in 1999 when she won a leading role in the successful feature The Bone Collector (1999), starring alongside Denzel Washington. In that same year, Jolie gave a tour de force performance in Girl, Interrupted (1999) playing opposite Winona Ryder. The movie was a true story of women who spent time in a psychiatric hospital. Jolie\'s role was reminiscent of Jack Nicholson\'s character in One Flew Over the Cuckoo\'s Nest (1975), the role which won Nicholson his first Oscar. Unlike \"Cuckoo\", \"Girl\" was a small film that received mixed reviews and barely made money at the box office. But when it came time to give out awards, Jolie won the triple crown -- \"Girl\" propelled her to win the Golden Globe Award, the SAG Award and the Academy Award for best leading actress in a supporting role.\n\nWith her new-found prominence, Jolie began to get in-depth attention from the press. Numerous aspects of her controversial personal life became news. At her wedding to her Hackers (1995) co-star Jonny Lee Miller, she had displayed her husband\'s name on the back of her shirt painted in her own blood. Jolie and Miller divorced, and in 2000, she married her Pushing Tin (1999) co-star Billy Bob Thornton. Jolie had become the fifth wife of a man twenty years her senior. During her marriage to Thornton, the spouses each wore a vial of the other\'s blood around their necks. That marriage came apart in 2002 and ended in divorce. In addition, Jolie was estranged from her famous father, Jon Voight.\n\nIn 2000, Jolie was asked to star in Lara Croft: Tomb Raider (2001). At first, she expressed disinterest, but then decided that the required training for the athletic role was intriguing. The Croft character was drawn from a popular video game. Lara Croft was a female cross between Indiana Jones and James Bond. When the film was released, critics were unimpressed with the final product, but critical acclaim wasn\'t the point of the movie. The public paid $275 million for theater tickets to see a buffed up Jolie portray the adventuresome Lara Croft. Jolie\'s father Jon Voight appeared in \"Croft\", and during filming there was a brief rapprochement between father and daughter.\n\nOne of the Croft movie\'s filming locations was Cambodia. While there, Jolie witnessed the natural beauty, culture and poverty of that country. She considered this an eye opening experience, and so began the humanitarian chapter of her life. Jolie began visiting refugee camps around the world and came to be formally appointed as a Goodwill Ambassador for the United Nations High Commissioner for Refugees (UNHCR). Some of her experiences were written and published in her popular book \"Notes from My Travels\" whose profits go to UNHCR.\n\nJolie has stated that she now plans to spend most of her time in humanitarian efforts, to be financed by her actress salary. She devotes one third of her income to savings, one third to living expenses and one third to charity. In 2002, Angelina adopted a Cambodian refugee boy named Maddox, and in 2005, adopted an Ethiopian refugee girl named Zahara. Jolie\'s dramatic feature film Beyond Borders (2003) parallels some of her real life humanitarian experiences although, despite the inclusion of a romance between two westerners, many of the movie\'s images were too depressingly realistic -- the film was not popular among critics or at the box office.\n\nIn 2004, Jolie began filming Mr. & Mrs. Smith (2005) with co-star Brad Pitt. The film became a major box office success. There were rumors that Pitt and Jolie had an affair while filming \"Smith\". Jolie insisted that because her mother had been hurt by adultery, she herself could never participate in an affair with a married man, therefore there had been no affair with Pitt at that time. Nonetheless, Pitt separated from his wife Jennifer Aniston in January 2005 and, in the months that followed, he was frequently seen in public with Jolie, apparently as a couple. Pitt\'s divorce was finalized later in 2005.\n\nJolie and Pitt announced in early 2006 that they would have a child together, and Jolie gave birth to daughter Shiloh that May. They also adopted a three-year-old Vietnamese boy named Pax. The couple, who married in 2014, continue to pursue movie and humanitarian projects, and now have a total of six children.', 'http://ia.media-imdb.com/images/M/MV5BODg3MzYwMjE4N15BMl5BanBnXkFtZTcwMjU5NzAzNw@@._V1_UY317_CR22,0,214,317_AL_.jpg', '1975-06-04');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Julie', 'Delpy', 'ulie Delpy was born in Paris, France, in 1969 to Albert Delpy and Marie Pillet, both actors.\n\nShe was first featured in Jean-Luc Godard\'s Detective (1985) at the age of fourteen. She has starred in many American and European productions since then, including Disney\'s The Three Musketeers (1993), Killing Zoe (1993), Three Colours: White (1994), and the \"Before\" series, alongside Ethan Hawke: Before Sunrise (1995), Before Sunset (2004), and Before Midnight (2013).\n\nShe graduated from NYU\'s film school, and wrote and directed the short film Blah Blah Blah (1995), which screened at the Sundance Film Festival. She is a resident of Los Angeles.', 'http://ia.media-imdb.com/images/M/MV5BMTg4ODM0MjI5NV5BMl5BanBnXkFtZTYwNDQ5NjM1._V1_UY317_CR13,0,214,317_AL_.jpg', '1969-12-21');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Ida', 'Lupino', 'Ida was born in London to a show business family. In 1933, her mother brought Ida with her to an audition and Ida got the part her mother wanted. The picture was Her First Affaire (1932). Ida, a bleached blonde, came to Hollywood in 1934 and played small and insignificant parts. Peter Ibbetson (1935) was one of her few noteworthy movies and it was not until The Light That Failed (1939) that she got a chance to get better parts. In most of her movies, she was cast as the hard, but sympathetic woman from the wrong side of the tracks. In The Sea Wolf (1941) and High Sierra (1941), she played the part magnificently. It has been said that no one could do hard-luck dames the way Lupino could do them. She played tough, knowing characters who held their own against some of the biggest leading men of the day - Humphrey Bogart, Ronald Colman, John Garfield and Edward G. Robinson. She made a handful of films during the forties playing different characters ranging from Pillow to Post (1945), where she played a traveling saleswoman to the tough nightclub singer in The Man I Love (1947). But good roles for women were hard to get and there were many young actresses and established stars competing for those roles. She left Warner Brothers in 1947 and became a freelance actress. When better roles did not materialize, Ida stepped behind the camera as a director, writer and producer. Her first directing job came when director Elmer Clifton fell ill on a script that she co-wrote Not Wanted (1949). Ida had joked that as an actress, she was the poor man\'s Bette Davis. Now, she said that as a director, she became the poor man\'s Don Siegel. The films that she wrote, or directed, or appeared in during the fifties were mostly inexpensive melodramas. She later turned to Television where she directed episodes in shows such as The Untouchables (1959) and The Fugitive (1963). In the seventies, she did guest appearances on various television show and small parts in a few movies.', 'http://ia.media-imdb.com/images/M/MV5BMTg3OTk1MTgwMl5BMl5BanBnXkFtZTYwMTQyNTU2._V1_UY317_CR4,0,214,317_AL_.jpg', '1918-02-04');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Jodie', 'Foster', 'Alicia Christian Foster was born in Los Angeles on November 19, 1962. She is the daughter of Evelyn Ella \"Brandy\" (Almond) and Lucius Fisher Foster III, an Air Force lieutenant colonel and later real estate broker. Brandy had filed for divorce in 1959 after having three children with Lucius, but the exes had a brief re-encounter in 1962 which resulted in Alicia\'s birth. Her older siblings nicknamed her \"Jodie\", a name she has used in her profession. She started her career at the age of two and made commercials for four years before making her debut as an actress in the TV series Mayberry R.F.D. (1968), on which her brother, Buddy Foster, was a regular. She stayed very busy as a child actress, working on television programs such as The Doris Day Show (1968), Adam-12 (1968), The Courtship of Eddie\'s Father (1969), The Partridge Family (1970), Bonanza (1959), and Gunsmoke (1955). In movies, her roles included playing Raquel Welch\'s daughter in Kansas City Bomber (1972) and a delinquent tomboy in Alice Doesn\'t Live Here Anymore (1974). Jodie first drew attention from critics with her appearance in Martin Scorsese\'s Taxi Driver (1976) alongside Robert De Niro and Harvey Keitel, where she played a prostitute at the tender age of 12 (she was 13 when the movie premiered) and received her first Oscar nomination as Best Supporting Actress. She went on to have a very successful career in her early teens with leading roles in the Disney films Freaky Friday (1976) with Barbara Harris and Candleshoe (1977) opposite veteran film legends David Niven and Helen Hayes. The last film she made during this era was the coming-of-age drama Foxes (1980), before enrolling at Yale University. During her freshman year at Yale, she was attached to a worldwide scandal when a crazed and obsessed fan named John Hinckley shot President Ronald Reagan to impress her.\n\nJodie graduated from Yale in 1985 with a degree in literature. She resumed her acting career and sought a breakthrough role that would return her to stardom. After appearing in a few obscure movies with limited release, Jodie landed an audition for Οι Κατηγορούμενοι (1988) and was cast in the part of Sarah Tobias, a waitress who is gang-raped in a bar during a night of partying and teams up with a lawyer played by Kelly McGillis to prosecute the attackers. This performance earned her an Academy Award for Best Actress, but despite the Oscar win, Jodie still hadn\'t re-established herself as a bankable star. Her next film, Catchfire (1990), went straight to video, and she had to campaign hard to get her next good role. In 1991, she starred as Clarice Starling, an FBI trainee assisting in a hunt for a serial killer in The Silence of the Lambs (1991) with Anthony Hopkins, Scott Glenn, Ted Levine, and Brooke Smith. The film was a blockbuster hit, winning Jodie her second Academy Award for Best Actress and establishing her as an international movie star at the age of 28. With the wealth and fame to do anything she wanted, Jodie turned to directing. She made her directorial debut with Little Man Tate (1991), which was followed by Home for the Holidays (1995). These movies were critically acclaimed but did not do well at the box office, and she proved to be a far more successful actress than she was a director. 1994 was a huge triumph for her acting career. She first played a sexy con artist in the successful western comedy Maverick (1994) with Mel Gibson and James Garner. Then, she played title role in Nell (1994), co-starring Liam Neeson and Natasha Richardson. For her compelling performance as a wild, backwoods hermit who speaks an invented language and must return to civilization, Jodie was nominated for another Academy Award and won a Screen Actors Guild Award as Best Actress.\n\nAlthough she was working far less frequently as an adult than she did as a child, the films she turned out were commercially successful and critically acclaimed. Her next big screen role was in the science fiction drama Contact (1997) opposite Matthew McConaughey. She played a scientist who receives signals from space aliens. The film was a huge hit and brought her a Golden Globe nomination. She starred in the non-musical remake of The King and I (1956) entitled Anna and the King (1999), which was only modestly received in the U.S. but was very successful overseas. Three years after that she headlined the thriller Panic Room (2002), which co-starred Kristen Stewart, Forest Whitaker, Dwight Yoakam, and Jared Leto. The film was a smash box-office hit and gave Jodie a $30 million opening weekend, the biggest of her career yet. She then appeared in two low-profile projects: the independent film The Dangerous Lives of Altar Boys (2002) and the foreign film A Very Long Engagement (2004). She returned to making Hollywood mainstream films, first with Flightplan (2005), in which she played a woman whose daughter disappears on an airplane that she designed. Once again Jodie proved herself to be a box-office draw, and the film was a worldwide hit. The following year she starred in another hit, the bank heist thriller Inside Man (2006) with Denzel Washington and Clive Owen. Jodie was on a roll. Her next film was the revenge thriller The Brave One (2007), which once again opened at #1 at the box office and earned her another Golden Globe nomination for Best Actress. Following this succession of thrillers that all had her playing tough women, Jodie returned to the comedy genre in Nim\'s Island (2008) with Gerard Butler and Abigail Breslin. She will reunite with Mel Gibson in the upcoming movie The Beaver (2011), which is scheduled for general release in 2011.', 'http://ia.media-imdb.com/images/M/MV5BMTM3MjgyOTQwNF5BMl5BanBnXkFtZTcwMDczMzEwNA@@._V1_UY317_CR1,0,214,317_AL_.jpg', '1962-11-19');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Liv', 'Ullmann', 'Liv Ullmann\'s father was a Norwegian engineer who used to work abroad, so as a child she lived in Tokyo, Canada, New York and Oslo. In the mid-\'50s she made her stage debut and in 1957 made her film debut. She really became successful, however, when she began to work for Swedish director Ingmar Bergman in such films as Persona (1966), The Passion of Anna (1969) and Face to Face (1976). She also had a successful film career away from Bergman (The Abdication (1974), Dangerous Moves (1984).', 'http://ia.media-imdb.com/images/M/MV5BMjA1MDQ2MDY3Nl5BMl5BanBnXkFtZTYwMzQ3NzQ2._V1_UY317_CR12,0,214,317_AL_.jpg', '1938-12-16');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Courtney', 'Cox', 'Courteney Cox was born on June 15th, 1964 in Birmingham, Alabama, into an affluent Southern family. She is the daughter of Courteney (Bass) and Richard Lewis Cox (1930-2001), a businessman. She was the baby of the family with two older sisters (Virginia and Dottie) and an older brother, Richard, Jr. She was raised in an exclusive society town, Mountain Brook, Alabama. Courteney was the archetypal daddy\'s girl, and therefore was understandably devastated when, in 1974, her parents divorced, and her father moved to Florida.\n\nShe became a rebellious teen, and did not make things easy for her mother, and new stepfather, New York businessman Hunter Copeland. Now, she is great friends with both. She attended Mountain Brook High School, where she was a cheerleader, tennis player and swimmer. In her final year, she received her first taste of modeling. She appeared in an advert for the store, Parisians. Upon graduation, she left Alabama to study architecture and interior design at Mount Vernon College. After one year she dropped out to a pursue a modeling career in New York, after being signed by the prestigious Ford Modelling Agency. She appeared on the covers of teen magazines such as Tiger Beat and Little Miss, plus numerous romance novels. She then moved on to commercials for Maybeline, Noxema, New York Telephone Company and Tampax.\n\nWhile modeling, she attended acting classes, as her real dream and ambition was to be an actress. In 1984, she landed herself a small part in one episode of As the World Turns (1956) as a young débutante named Bunny. Her first big break, however, was being cast by Brian De Palma in the Bruce Springsteen video \"Dancing in The Dark\". In 1985, she moved to LA to star alongside Dean Paul Martin in Misfits of Science (1985). It was a flop, but a few years later, she was chosen out of thousands of hopefuls to play Michael J. Fox\'s girlfriend, psychology major Lauren Miller in Family Ties (1982).\n\nIn 1989, Family Ties (1982) ended, and Cox went through a lean spell in her career, featuring in unmemorable movies such as Mr. Destiny (1990) with Michael Caine. Fortunes changed dramatically for Cox, when in 1994, she starred alongside Jim Carrey in the unexpected hit Ace Ventura: Pet Detective (1994), and a year later she was cast as Monica Geller on the hugely successful sitcom Friends (1994). It was this part that turned her into an international superstar and led to an American Comedy Award nomination. In 1996 Cox starred in Wes Craven\'s horror/comedy Scream (1996) . This movie grossed over $100 million at the box office, and won Cox rave reviews for her standout performance as the wickedly bitchy and smug TV reporter Gale Weathers. She went on to play this character again in each of the three sequels. Not only did her involvement in this movie lead to critical acclaim, but it also led to her meeting actor husband David Arquette. He played her on-screen love interest Dewey, and life imitated art as the two fell in love for real. Their wedding took place in San Francisco, at the historic Grace Cathedral atop Nob Hill, on June 12th, 1999. Joined by 200 guests, including Cox\'s film star friends Liam Neeson and Kevin Spacey, the happy couple finally became Mr. and Mrs. Arquette.', 'http://ia.media-imdb.com/images/M/MV5BMTA4OTczNDExNDNeQTJeQWpwZ15BbWU3MDUyNTIzMTM@._V1_UY317_CR7,0,214,317_AL_.jpg', '1964-06-15');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Jennifer', 'Aniston', 'Jennifer Aniston was born in Sherman Oaks, California, to actors John Aniston and Nancy Dow. Her father is Greek, and her mother is of English, Irish, Scottish, and Italian descent. Jennifer spent a year of her childhood living in Greece with her family. Her family then relocated to New York City where her parents divorced when she was 9. Jennifer was raised by her mother and her father landed a role, as \"Victor Kiriakis\", on the daytime soap Days of Our Lives (1965). Jennifer had her first taste of acting at age 11 when she joined the Rudolf Steiner School\'s drama club. It was also at the Rudolf Steiner School that she developed her passion for art. She began her professional training as a drama student at New York\'s School of Performing Arts, aka the \"Fame\" school. It was a division of Fiorello H. LaGuardia High School of Music and the Arts. In 1987, after graduation, she appeared in such Off-Broadway productions as \"For Dear Life\" and \"Dancing on Checker\'s Grave\". In 1989, she landed her first television role, as a series regular on Molloy (1989). She also appeared in The Edge (1992), Ferris Bueller (1990), and had a recurring part on Herman\'s Head (1991). By 1993, she was floundering. Then, in 1994, a pilot called \"Friends Like These\" came along. Originally asked to audition for the role of \"Monica\", Aniston refused and auditioned for the role of \"Rachel Green\", the suburban princess turned coffee peddler. With the success of the series Friends (1994), Jennifer has become famous and sought-after as she turns her fame into movie roles during the series hiatus.', 'http://ia.media-imdb.com/images/M/MV5BNjk1MjIxNjUxNF5BMl5BanBnXkFtZTcwODk2NzM4Mg@@._V1_UY317_CR3,0,214,317_AL_.jpg', '1969-02-11');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Scarlett', 'Johansson', 'Scarlett Johansson was born in New York City. Her mother, Melanie Sloan, is from an Ashkenazi Jewish family, and her father, Karsten Johansson, is Danish. She has a sister, Vanessa Johansson, who is also an actress, a brother, Adrian, a twin brother, Hunter Johansson, born three minutes after her, and a paternal half-brother, Christian. Scarlett showed a passion for acting at a young age and starred in many plays. She began her acting career starring as Laura Nelson in the comedy film North (1994). The acclaimed drama film The Horse Whisperer (1998) brought Johansson critical praise and worldwide recognition. Following the film\'s success, she starred in many other films including the critically acclaimed cult film Ghost World (2001) and then the hit Lost in Translation (2003) with Bill Murray in which she again stunned critics. Later on, she appeared in the drama film Girl with a Pearl Earring (2003).\n\nIn 2003, she was nominated for two Golden Globe Awards, one for drama (Girl with a Pearl Earring (2003)) and one for comedy (Lost in Translation (2003)). She dropped out of Mission: Impossible III (2006) due to scheduling conflicts. Her next film role was in The Island (2005) alongside Ewan McGregor which earned weak reviews from U.S. critics. After this, she appeared in Woody Allen\'s Match Point (2005) and was nominated again for a Golden Globe Award.\n\nSince then, she has appeared as part of an ensemble cast in the romantic comedy He\'s Just Not That Into You (2009), the action superhero film Iron Man 2 (2010), the comedy-drama We Bought a Zoo (2011) and started as the original scream queen, Janet Leigh, in Hitchcock (2012). She then played her Iron Man 2 character, Black Widow, in the blockbuster action films Avengers Assemble (2012), Captain America: The Winter Soldier (2014), and Avengers: Age of Ultron (2015), and also headlined the science-fiction thriller Lucy (2014), a box office success.\n\nScarlett and Canadian actor Ryan Reynolds were engaged in May 2008 and married in September of that year. In 2010, the couple announced their separation, and subsequently divorced in 2011. In 2013, she became engaged to French journalist Romain Dauriac, and the couple, who have a daughter, married in 2014.', 'http://ia.media-imdb.com/images/M/MV5BMTM3OTUwMDYwNl5BMl5BanBnXkFtZTcwNTUyNzc3Nw@@._V1_UY317_CR23,0,214,317_AL_.jpg', '1984-11-22');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Leonard ', 'Di Caprio', 'Few actors in the world have had a career quite as diverse as Leonardo DiCaprio\'s. DiCaprio has gone from relatively humble beginnings, as a supporting cast member of the sitcom Growing Pains (1985) and low budget horror movies, such as Critters 3 (1991), to a major teenage heartthrob in the 1990s, as the hunky lead actor in movies such as Romeo + Juliet (1996) and Titanic (1997), to then become a leading man in Hollywood blockbusters, made by internationally renowned directors such as Martin Scorsese and Christopher Nolan.\n\nLeonardo Wilhelm DiCaprio was born November 11, 1974 in Los Angeles, California, the only child of Irmelin DiCaprio (née Indenbirken) and former comic book artist George DiCaprio. His father is of Italian and German descent, and his mother, who is German-born, is of German and Russian ancestry. His middle name, \"Wilhelm\", was his maternal grandfather\'s first name. Leonardo\'s father had achieved minor status as an artist and distributor of cult comic book titles, and was even depicted in several issues of American Splendor, the cult semiautobiographical comic book series by the late \'Harvey Pekar\', a friend of George\'s. Leonardo\'s performance skills became obvious to his parents early on, and after signing him up with a talent agent who wanted Leonardo to perform under the stage name \"Lenny Williams\", DiCaprio began appearing on a number of television commercials and educational programs.\n\nDiCaprio began attracting the attention of producers, who cast him in bit part roles in a number of television series, such as Roseanne (1988) and The New Lassie (1989), but it wasn\'t until 1991 that DiCaprio made his film debut in Critters 3 (1991), a low-budget horror movie. While Critters 3 (1991) did little to help showcase DiCaprio\'s acting abilities, it did help him develop his show-reel, and attract the attention of the people behind the hit sitcom Growing Pains (1985), in which Leonardo was cast in the \"Cousin Oliver\" role of a young homeless boy who moves in with the Seavers. While DiCaprio\'s stint on Growing Pains (1985) was very short, as the sitcom was axed the year after he joined, it helped bring DiCaprio into the public\'s attention and, after the show ended, DiCaprio began auditioning for roles in which he would get the chance to prove his acting chops.\n\nLeonardo took up a diverse range of roles in the early 1990s, including a mentally challenged youth in What\'s Eating Gilbert Grape (1993), a young gunslinger in Γρήγορη και Θανάσιμη (1995) and a drug addict in one of his most challenging roles to date, \"Jim Carroll\", in The Basketball Diaries (1995), a role which the late River Phoenix originally expressed interest in. While these diverse roles helped establish Leonardo\'s reputation as an actor, it wasn\'t until his role as \"Romeo\" in Baz Luhrmann\'s Romeo + Juliet (1996) that Leonardo became a household name, a true movie star. The following year, DiCaprio starred in another movie about doomed lovers, Titanic (1997), which went on to beat all box office records held before then, as, at the time, Titanic (1997) became the highest grossing movie of all time, and cemented DiCaprio\'s reputation as a teen heartthrob. Following his work on Titanic (1997), DiCaprio kept a low profile for a number of years, with roles in The Man in the Iron Mask (1998) and the low-budget The Beach (2000) being some of his few notable roles during this period.\n\nIn 2002, he burst back into screens throughout the world with leading roles in Catch Me If You Can (2002) and Gangs of New York (2002), his first of many collaborations with director Martin Scorsese. With a current salary of $20 million a movie, DiCaprio is now one of the biggest movie stars in the world. However, he has not limited his professional career to just acting in movies, as DiCaprio is a committed environmentalist, who is actively involved in many environmental causes, and his commitment to this issue led to his involvement in The 11th Hour, a documentary movie about the state of the natural environment. As someone who has gone from bit parts in television commercials to one of the most respected actors in the world, DiCaprio has had one of the most diverse careers in cinema. DiCaprio continued to defy conventions about the types of roles he would accept, and with his career now seeing him leading all-star casts in action thrillers such as The Departed (2006), Shutter Island (2010) and Christopher Nolan\'s Inception (2010), DiCaprio continues to wow audiences by refusing to conform to any cliché about actors.\n\nIn 2012, he played a mustache-twirling villain in Django Unchained (2012), and then tragic literary character Jay Gatsby in Ο υπέροχος Γκάτσμπυ (2013).\n\nDiCaprio is passionate about environmental and humanitarian causes, having donated $1,000,000 to earthquake relief efforts in 2010, the same year he contributed $1,000,000 to the Wildlife Conservation Society.', 'http://ia.media-imdb.com/images/M/MV5BMjI0MTg3MzI0M15BMl5BanBnXkFtZTcwMzQyODU2Mw@@._V1_UY317_CR10,0,214,317_AL_.jpg', '1974-11-11');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Catherine Elise', 'Blanchett', 'Cate Blanchett was born on May 14, 1969 in Melbourne, Victoria, Australia, to June (Gamble), an Australian teacher and property developer, and Robert DeWitt Blanchett, Jr., an American advertising executive, originally from Texas. She has an older brother and a younger sister. When she was ten years old, her 40-year-old father died of a sudden heart attack. Her mother never remarried, and her grandmother moved in to help her mother. Cate graduated from Australia\'s National Institute of Dramatic Art in 1992 and, in a little over a year, had won both critical and popular acclaim. On graduating from NIDA, she joined the Sydney Theatre Company\'s production of Caryl Churchill\'s \"Top Girls\", then played Felice Bauer, the bride, in Tim Daly\'s \"Kafka Dances\", winning the 1993 Newcomer Award from the Sydney Theatre Critics Circle for her performance. From there, Blanchett moved to the role of Carol in David Mamet\'s searing polemic \"Oleanna\", also for the Sydney Theatre Company, and won the Rosemont Best Actress Award, her second award that year. She then co-starred in the ABC Television\'s prime time drama Heartland (1994), again winning critical acclaim. In 1995, she was nominated for Best Female Performance for her role as Ophelia in the Belvoir Street Theatre Company\'s production of \"Hamlet\". Other theatre credits include Helen in the Sydney Theatre Company\'s \"Sweet Phoebe\", Miranda in \"The Tempest\" and Rose in \"The Blind Giant is Dancing\", both for the Belvoir Street Theatre Company. In other television roles, Blanchett starred as Bianca in ABC\'s Bordertown (1995), as Janie Morris in G.P. (1989) and in ABC\'s popular series Police Rescue (1994). She made her feature film debut in Ο δρόμος του παραδείσου (1997). She also married writer Andrew Upton in 1997. She had met him a year earlier on a movie set, and they didn\'t like each other at first. He thought she was aloof, and she thought he was arrogant, but then they connected over a poker game at a party, and she went home with him that night. Three weeks later he proposed marriage and they quickly married before she went off to England to play her breakthrough role in films: the title character in Elizabeth (1998) for which she won numerous awards for her performance, including the Golden Globe for Best Actress in a Drama. Cate was also nominated for an Academy Award for the role but lost out to Gwyneth Paltrow. 2001 was a particularly busy year, with starring roles in Bandits (2001), The Shipping News (2001), Charlotte Gray (2001) and playing Elf Queen Galadriel in the \"Lord Of The Rings\" trilogy. She also gave birth to her first child, son Dashiell, in 2001. In 2004, she gave birth to her second son Roman. Also, in 2004, she played actress Katharine Hepburn in Martin Scorsese\'s film \"Aviator\" (2004), for which she received an Academy Award as Best Supporting Actress. Two years later, she received an Academy Award nomination as Best Supporting Actress for playing a teacher having an affair with an underage student in \"Notes on a Scandal\" (2006). In 2007, she returned to the role that made her a star in \"Elizabeth: The Golden Age\" (2007). It earned her an Oscar nomination as Best Actress. She was nominated for another Oscar that same year as Best Supporting Actress for playing Bob Dylan in \"I\'m Not There\" (2007). In 2008, she gave birth to her third child, son Ignatius. She and her husband became artistic directors of the Sydney Theatre Company, choosing to spend more time in Australia raising their three sons. She also purchased a multi-million dollar home in Sydney, Australia and named it Bulwarra and made extensive renovations to it. Because of her life in Australia, her film work became sporadic, until Woody Allen cast her in the title role in Blue Jasmine (2013), which won her the Academy Award as Best Actress. She ended her job as artistic director of the Sydney Theatre Company, while her husband continued there for two more years before he too resigned. In 2015, she adopted her daughter Edith in her father\'s homeland of America. That same year, she and her husband sold their multi-million dollar home in Australia at a profit and moved to America. Reasons varied from her wanting to work more in America to wanting to familiarize herself with her late father\'s American heritage. She played the title role of Carol (2015), a 1950s American housewife in a lesbian affair with a younger woman. She won rave reviews for the role, and may again be an Oscar contender.', 'http://ia.media-imdb.com/images/M/MV5BMTc1MDI0MDg1NV5BMl5BanBnXkFtZTgwMDM3OTAzMTE@._V1_UY317_CR3,0,214,317_AL_.jpg', '1969-05-14');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Caryn Elaine', 'Johnson', 'Whoopi Goldberg was born Caryn Elaine Johnson in the Chelsea section of Manhattan on November 13, 1955. Her mother, Emma (Harris), was a teacher and a nurse, and her father, Robert James Johnson, Jr., was a clergyman. Whoopi\'s recent ancestors were from Georgia, Florida, and Virginia. She worked in a funeral parlor and as a bricklayer while taking small parts on Broadway. She moved to California and worked with improv groups, including Spontaneous Combustion, and developed her skills as a stand-up comedienne. She came to prominence doing an HBO special and a one-woman show as Moms Mabley. She has been known in her prosperous career as a unique and socially conscious talent with articulately liberal views. Among her boyfriends were Ted Danson and Frank Langella. She was married three times and was once addicted to drugs.\n\nGoldberg first came to prominence with her starring role in The Color Purple (1985). She received much critical acclaim, and an Oscar nomination for her role and became a major star as a result. Subsequent efforts in the late 1980s were, at best, marginal hits. These movies mostly were off-beat to formulaic comedies like Burglar (1987), The Telephone (1988) and Jumpin\' Jack Flash (1986). She made her mark as a household name and a mainstay in Hollywood for her Oscar-winning role in the box office smash Ghost (1990). Whoopi Goldberg was at her most famous in the early 1990s, making regular appearances on Star Trek: The Next Generation (1987). She admitted to being a huge fan of the original Star Trek (1966) series and jumped at the opportunity to star in \"Star Trek: The Next Generation\".\n\nGoldberg received another smash hit role in Sister Act (1992). Her fish-out-of-water with some flash seemed to resonate with audiences and it was a box office smash. Whoopi starred in some highly publicized and moderately successful comedies of this time, including Made in America (1993) and Soapdish (1991). Goldberg followed up to her success with Sister Act 2: Back in the Habit (1993), which was well-received but did not seem to match up to the first.\n\nAs the late 1990s approached, Goldberg seemed to alternate between lead roles in straight comedies such as Eddie (1996) and The Associate (1996), and took supporting parts in more independent minded movies, such as The Deep End of the Ocean (1999) and How Stella Got Her Groove Back (1998). Goldberg never forgot where she came from, hosting many tributes to other legendary entertainment figures. Her most recent movies include Rat Race (2001) and the quietly received Kingdom Come (2001). Goldberg contributes her voice to many cartoons, including The Pagemaster (1994) and Captain Planet and the Planeteers (1990), as Gaia, the voice of the earth. Alternating between big-budget movies, independent movies, tributes, documentaries, and even television movies (including Theodore Rex (1995)).\n\nWhoopi Goldberg is accredited as a truly unique and visible talent in Hollywood. Perhaps she will always be remembered as well for Comic Relief, playing an integral part in almost every benefit concert they had. Currently, Whoopi Goldberg is the center square in Hollywood Squares (1998) and frequently hosts the Academy Awards. She also is an author, with the book \"Book\".', 'http://ia.media-imdb.com/images/M/MV5BMjE4ODgzNjQwOV5BMl5BanBnXkFtZTYwNzczNzc0._V1_UX214_CR0,0,214,317_AL_.jpg', '1955-11-13');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('George Cooper', 'Stevens', 'George Stevens, a filmmaker known as a meticulous craftsman with a brilliant eye for composition and a sensitive touch with actors, is one of the great American filmmakers, ranking with John Ford, William Wyler and Howard Hawks as a creator of classic Hollywood cinema, bringing to the screen mytho-poetic worlds that were also mass entertainment. One of the most honored and respected directors in Hollywood history, Stevens enjoyed a great degree of independence from studios, producing most of his own films after coming into his own as a director in the late 1930s. Though his work ranged across all genres, including comedies, musicals and dramas, whatever he did carried the hallmark of his personal vision, which is predicated upon humanism.', 'http://ia.media-imdb.com/images/M/MV5BMTk1MjIyNTIyM15BMl5BanBnXkFtZTcwMDI3Njg3Mw@@._V1_UY317_CR1,0,214,317_AL_.jpg', '1904-12-18');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Gary', 'Cooper', 'Born to Alice Cooper and Charles Cooper (not in film business). Gary attended school at Dunstable school England, Helena Montana and Iowa College, Grinnell, Iowa. His first stage experience was during high school and college. Afterwards, he worked as an extra for one year before getting a part in a two reeler by Hans Tissler (an independent producer). Eileen Sedgwick was his first leading lady. He then appeared in The Winning of Barbara Worth (1926) for United Artists before moving to Paramount. While there he appeared in a small part in Wings (1927), It (1927), and other films.', 'http://ia.media-imdb.com/images/M/MV5BMTUyMjI1MDEyN15BMl5BanBnXkFtZTYwNzkwNjI2._V1_UY317_CR2,0,214,317_AL_.jpg', '1901-05-07');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Maximilian', 'Schell', 'Maximilian Schell was the most successful German-speaking actor in English-language films since Emil Jannings, the winner of the first Best Actor Academy Award. Like Jannings, Schell won the Oscar, but unlike him, he was a dedicated anti-Nazi. Indeed, with the exception of Maurice Chevalier and Marcello Mastroianni, Schell was undoubtedly the most successful non-anglophone foreign actor in the history of American cinema.\n\nSchell was born in Vienna, Austria on December 8, 1930, but raised in in Zurich, Switzerland. (Austria became part of Germany after the anschluss of 1938), then was occupied by the allies from 1945 until 1955, when it again joined the family of nations.) He learned his craft on the stage beginning in 1952, and made his reputation with appearances in German-language films and television. He is a fine Shakespearian actor, and had a huge success with \"Richard III\" (he has also appeared in as the eponymous prince in a German-language version of \"Hamlet\").\n\nSchell made his Hollywood debut in 1958 in the World War II film The Young Lions (1958) quite by accident, as the producers had wanted to hire his sister Maria Schell, but lines of communication got crossed, and he was the one hired. He impressed American producers as his turn as the friend of German soldier Marlon Brando, and subsequently assayed the role of the German defense attorney in the television drama Judgement at Nuremberg (1961) on \"Playhouse 90\" in 1959. He was also cast in the big screen remake, for which he won the 1961 Academy Award for Best Actor, beating out co-star Spencer Tracy for the Oscar. He also won a Golden Globe and the New York Film Critics Circle Award for the role. Schell ultimately won two more Oscar nominations for acting, in 1976 for Best Actor for The Man in the Glass Booth (1975) and in 1978 as Best Supporting Actor for Julia (1977) (which also brought him the New York Film Critics Circle Award for Best Supporting Actor). He has twice been nominated for an Emmy for his TV work, and won the 1993 Golden Globe for best performance by an actor in a supporting role in a series, mini-series or made-for-TV movie for Stalin (1992).\n\nSchell has also has directed films, and his 1974 film The Pedestrian (1973) (\"The Pedestrian\"), which Schell wrote, produced, directed, and starred in, was nominated for the Best Foreign Language Film Oscar and won the Golden Globe in the same category. His documentary about Marlene Dietrich, Marlene (1984), was widely hailed as a masterpiece of the non-fiction genre and garnered its producers a Best Documentary Oscar nomination in 1985. In 2002, Schell released My Sister Maria (2002) (My Sister Maria), a documentary about the career of and his relationship with Maria Schell. Since the 1990s, Schell has appeared in many German language made-for-TV films, such as the 2003 film Alles Glück dieser Erde (2003) (All the Luck in the World) and in the mini-series The Return of the Dancing Master (2004), which was based on Henning Mankell\'s novel. He has also continued to appear on stage, appearing in dual roles in the 2000 Broadway production of the stage version of \"Judgment at Nuremberg\", and most recently in Robert Altman\'s London production of Arthur Miller\'s play \"Resurrection Blues\" in 2006. He died on 31st of January 2014, aged 83, in Innsbruck, Austria.', 'http://ia.media-imdb.com/images/M/MV5BMTk1MzYyNjkyMF5BMl5BanBnXkFtZTYwNzY2MjI2._V1_UY317_CR13,0,214,317_AL_.jpg', '1930-12-08');
INSERT INTO `cinema`.`Artist` (`artist_name`, `artist_surname`, `artist_biography`, `artist_picurl`, `artist_dob`) VALUES ('Glenda', 'Jackson', 'Few in modern British history have come as far or achieved as much from humble beginnings as Glenda Jackson has. From acclaimed actress to respected MP (Member of Parliament), she is known for her high intelligence and meticulous approach to her work. She was born to a working-class household in Birkenhead, where her father was a bricklayer and her mother was a cleaning lady. When she was very young, her father was recruited into the Navy, where he worked aboard a minesweeper. She graduated from school at 16 and worked for a while in a pharmacy. However, she found this boring and dead-end and wanted better for herself. Her life changed forever when she was accepted into the prestigious Royal Acadamy of Dramatic Art (RADA) at the age of 18. Her work impressed all who observed it. In addition, she married Roy Hodges at 22.\n\nHer first work came on the stage, where she won a role in an adaptation of \"Separate Tables\", and made a positive impression on critics and audiences alike. This led to film roles, modest at first, but she approached them with great determination. She first came to the public\'s notice when she won a supporting role in the controversial film Marat/Sade (1967), and is acknowledged to have stolen the show. She quickly became a member of Britian\'s A-List. Her first starring role came in the offbeat drama Negatives (1968), in which she out-shone the oddball material. The following year, controversial director Ken Russell gave her a starring role in his adaptation of the 1920s romance Women in Love (1969), in which she co-starred with Oliver Reed. The beautifully photographed film was a major success, and Jackson\'s performance won her an Academy Award for Best Actress. In the process, she became an international celebrity, known world-wide, yet she didn\'t place as much value on the status and fame as most do. She did, however, become a major admirer of Russell (who had great admiration for her in return) and acted in more of his films. She starred in the controversial The Music Lovers (1970), even though it required her to do a nude scene, something that made her very uncomfortable. The film was not a success, but she agreed to do a cameo appearance in his next film, The Boy Friend (1971). Although her role as an obnoxious actress was very small, she once again performed with great aplomb.\n\n1971 turned out to be a key year for her. She took a risk by appearing in Sunday Bloody Sunday (1971), as a divorced businesswoman in a dead-end affair with a shallow bisexual artist, but the film turned out to be another major success. Also, she accepted the starring role in the British Broadcasting Corporation\'s much anticipated biography of Queen Elizabeth I, and her performance in the finished film, Elizabeth R (1971), was praised not only by critics and fans, but is cited by historians as the most accurate portrayal of the beloved former queen ever seen. The same year, she successfully played the role of Queen Elizabeth I again in the historical drama Mary, Queen of Scots (1971). That same year, she appeared in the popular comedy series The Morecambe & Wise Show (1968) in a skit as Queen Cleopatra, which is considered on of the funniest TV skits in British television, and also proof that she could do comedy just as well as costume melodrama. One who saw and raved about her performance was director Melvin Frank, who proceeded to cast her in the romantic comedy A Touch of Class (1973), co-starring George Segal. The two stars had a chemistry which brought out the best in each other, and the film was not only a major hit in both the United States and Great Britian, but won her a second Academy Award. She continued to impress by refusing obvious commercial roles and seeking out serious artistic work. She gave strong performances in The Romantic Englishwoman (1975) and The Incredible Sarah (1976), in which she portrayed the legendary actress Sarah Bernhardt. However, some of her films didn\'t register with the public, like The Triple Echo (1972), The Maids (1975), and Nasty Habits (1977). In addition, her marriage fell apart in 1976. But her career remained at the top and in 1978 she was named Commander of the Order of the British Empire. That year, she made a comeback in the comedy House Calls (1978), co-starring Walter Matthau. The success of this film which led to a popular television spin-off in the United States the following year. In 1979, she and Segal re-teamed in Lost and Found (1979), but they were unable to overcome the routine script. She again co-starred with Oliver Reed in The Class of Miss MacMichael (1979), but the film was another disappointment.\n\nDuring the 1980s, she appeared in Hopscotch (1980) also co-starring Walter Matthau, and HealtH (1980) with Lauren Bacall, with disappointing results, although Jackson herself was never blamed. Her performance in the TV biography Sakharov (1984), in which she played Yelena Bonner, devoted wife of imprisoned Russian nuclear scientist Andrei Sakharov opposite Jason Robards, won rave reviews. However, the next film Turtle Diary (1985), was only a modest success, and the ensemble comedy Beyond Therapy (1987) was a critical and box office disaster and Jackson herself got some of the worst reviews of her career.\n\nAs the 1980s ended, Jackson continued to act, but became more focused on public affairs. She grew up in a household that was staunchly supportive of the Labour Party. She had disliked the policies of Conservative Prime Minister Margaret Thatcher, even though she admired some of her personal attributes, and strongly disapproved of Thatcher\'s successor, John Major. She was unhappy with the direction of British government policies, and in 1992 ran for Parliament. Although running in an area (Hampstead and Highgate) which was not heavily supportive of her party, she won by a slim margin and immediately became its most famous newly elective member. However, those who expected that she would rest on her laurels and fame were mistaken. She immediately took an interest in transportation issues, and in 1997 was appointed Junior Transportation Minister by Prime Minister Tony Blair. However, she was critical of some of Blair\'s policies and is considered an intra-party opponent of Blair\'s moderate faction. She is considered a traditional Labour Party activist, but is not affiliated with the faction known as The Looney Left. In 2000, she ran for Mayor of London, but lost the Labour nomination to fellow MP Frank Dobson, an ally of Blair\'s, who then lost the election to an independent candidate, Ken Livingstone. In 2005, she ran again and won the nomination, but lost to Livingstone, winning 38% of the vote. When Blair announced he would not seek reelection as Prime Minister in 2006, Jackson\'s name was mentioned as a possible successor, although she didn\'t encourage this speculation.', 'http://ia.media-imdb.com/images/M/MV5BNzI3OTYwMzg1Nl5BMl5BanBnXkFtZTcwNzIyMTM3NA@@._V1_UY317_CR91,0,214,317_AL_.jpg', '1936-05-09');

INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (1, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (2, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (3, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (4, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (5, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (6, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (7, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (8, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (9, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (10, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (11, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (12, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (13, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (14, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (15, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (16, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (17, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (18, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (19, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (20, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (21, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (22, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (23, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (24, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (25, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (26, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (27, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (28, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (29, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (30, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (31, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (32, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (33, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (34, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (35, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (38, 'Actor');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (1, 'Director');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (2, 'Director');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (3, 'Director');
INSERT INTO `cinema`.`artist_specialization` (`as_artist_ID`, `as_specialization`) VALUES (4, 'Director');																														   
																														   
INSERT INTO `cinema`.`Artist_Awards` (`aaw_title`, `aaw_summary`) VALUES ('Oscar Best Motion', 'Best Motion Picture of the Year.');
INSERT INTO `cinema`.`Artist_Awards` (`aaw_title`, `aaw_summary`) VALUES ('Oscar Best Performance Male', 'Best Performance by an Actor in a Leading Role of the year.');
INSERT INTO `cinema`.`Artist_Awards` (`aaw_title`, `aaw_summary`) VALUES ('Oscar Best Performance Female', 'Best Performance by an Actress in a Leading Role of the year.');
INSERT INTO `cinema`.`Artist_Awards` (`aaw_title`, `aaw_summary`) VALUES ('Oscar Best Perfomance Supporting Male', 'Best Performance by an Actor in a Supporting Role of the year.');
INSERT INTO `cinema`.`Artist_Awards` (`aaw_title`, `aaw_summary`) VALUES ('Oscar Best Perfomance Supporting Female', 'Best Performance by an Actress in a Supporting Role of the year.');
INSERT INTO `cinema`.`Artist_Awards` (`aaw_title`, `aaw_summary`) VALUES ('Oscar Best Direction', 'Best Direction Oscar of the year.');
INSERT INTO `cinema`.`Artist_Awards` (`aaw_title`, `aaw_summary`) VALUES ('Oscar Best Writting', 'Best Writing/Original Screenplay of the year.');
INSERT INTO `cinema`.`Artist_Awards` (`aaw_title`, `aaw_summary`) VALUES ('Golden Globe Best Motion Picture - Drama', 'Golden globe award, for the Drama of the year.');
INSERT INTO `cinema`.`Artist_Awards` (`aaw_title`, `aaw_summary`) VALUES ('Golden Globe Best Motion Picture - Comedy/Musical', 'Golden globe award, for the best Comedy or Musical of the year.');
INSERT INTO `cinema`.`Artist_Awards` (`aaw_title`, `aaw_summary`) VALUES ('Golden Globe Best Perfomance of an Actor', 'Golden globe award, for the best perfomance of the year by an actor.');
INSERT INTO `cinema`.`Artist_Awards` (`aaw_title`, `aaw_summary`) VALUES ('Golden Globe Best Perfomance of an Actress', 'Golden globe award, for the best perfomance of the year by an actoress.');
INSERT INTO `cinema`.`Artist_Awards` (`aaw_title`, `aaw_summary`) VALUES ('Golden Globe Best Director', 'Golden globe award, for the best director of the year.');
INSERT INTO `cinema`.`Artist_Awards` (`aaw_title`, `aaw_summary`) VALUES ('SAG-OutStanding Performance-Female', 'Outstanding Performance by a Female Actor in a Leading Role.');
INSERT INTO `cinema`.`Artist_Awards` (`aaw_title`, `aaw_summary`) VALUES ('SAG-OutStanding Performance-Male', 'Outstanding Performance by a Male Actor in a Leading Role.');
INSERT INTO `cinema`.`Artist_Awards` (`aaw_title`, `aaw_summary`) VALUES ('SAG-OutStanding Performance-FemaleSupport', 'Outstanding Performance by a Female Actor in a Supporting Role.');
INSERT INTO `cinema`.`Artist_Awards` (`aaw_title`, `aaw_summary`) VALUES ('SAG-OutStanding Performance-MaleSupport', 'Outstanding Performance by a Male Actor in a Supporting Role.');
INSERT INTO `cinema`.`Artist_Awards` (`aaw_title`, `aaw_summary`) VALUES ('Critic\'s Choise Best Actor', 'Critic\'s Choise for the Best Actor in a film for the year.');
INSERT INTO `cinema`.`Artist_Awards` (`aaw_title`, `aaw_summary`) VALUES ('Critic\'s Choise Best Actress', 'Critic\'s Choise for the Best Actress in a film for the year.');

INSERT INTO `cinema`.`Artist_Nominated` (`an_aaw_title`, `an_artist_ID`, `an_date`, `an_condition`) VALUES ('Oscar Best Performance Male', 32, '2014-03-02', 'Nominated');
INSERT INTO `cinema`.`Artist_Nominated` (`an_aaw_title`, `an_artist_ID`, `an_date`, `an_condition`) VALUES ('Oscar Best Performance Female', 33, '2014-03-02', 'won');
INSERT INTO `cinema`.`Artist_Nominated` (`an_aaw_title`, `an_artist_ID`, `an_date`, `an_condition`) VALUES ('Oscar Best Perfomance Supporting Male', 3, '1991-03-25', 'Nominated');
INSERT INTO `cinema`.`Artist_Nominated` (`an_aaw_title`, `an_artist_ID`, `an_date`, `an_condition`) VALUES ('Oscar Best Perfomance Supporting Female', 34, '1991-03-25', 'won');
INSERT INTO `cinema`.`Artist_Nominated` (`an_aaw_title`, `an_artist_ID`, `an_date`, `an_condition`) VALUES ('Oscar Best Direction', 35, '1952-03-20', 'won');
INSERT INTO `cinema`.`Artist_Nominated` (`an_aaw_title`, `an_artist_ID`, `an_date`, `an_condition`) VALUES ('Golden Globe Best Perfomance of an Actor', 23, '1994-02-18', 'won');
INSERT INTO `cinema`.`Artist_Nominated` (`an_aaw_title`, `an_artist_ID`, `an_date`, `an_condition`) VALUES ('Golden Globe Best Perfomance of an Actress', 31, '2005-05-17', 'Nominated');
INSERT INTO `cinema`.`Artist_Nominated` (`an_aaw_title`, `an_artist_ID`, `an_date`, `an_condition`) VALUES ('Oscar Best Performance Male', 36, '1953-03-19', 'Won');
INSERT INTO `cinema`.`Artist_Nominated` (`an_aaw_title`, `an_artist_ID`, `an_date`, `an_condition`) VALUES ('Oscar Best Performance Male', 37, '1962-04-09', 'Won');
INSERT INTO `cinema`.`Artist_Nominated` (`an_aaw_title`, `an_artist_ID`, `an_date`, `an_condition`) VALUES ('Oscar Best Performance Male', 1, '1971-04-15', 'Nominated');
INSERT INTO `cinema`.`Artist_Nominated` (`an_aaw_title`, `an_artist_ID`, `an_date`, `an_condition`) VALUES ('Oscar Best Performance Female', 38, '1971-04-15', 'won');
INSERT INTO `cinema`.`Artist_Nominated` (`an_aaw_title`, `an_artist_ID`, `an_date`, `an_condition`) VALUES ('Oscar Best Performance Female', 24, '2009-02-22', 'Nominated');

INSERT INTO `cinema`.`Casting` (`casting_artist_ID`, `casting_movie_ID`) VALUES (1, 11);
INSERT INTO `cinema`.`Casting` (`casting_artist_ID`, `casting_movie_ID`) VALUES (2, 12);
INSERT INTO `cinema`.`Casting` (`casting_artist_ID`, `casting_movie_ID`) VALUES (3, 13);
INSERT INTO `cinema`.`Casting` (`casting_artist_ID`, `casting_movie_ID`) VALUES (4, 12);
INSERT INTO `cinema`.`Casting` (`casting_artist_ID`, `casting_movie_ID`) VALUES (5, 14);
INSERT INTO `cinema`.`Casting` (`casting_artist_ID`, `casting_movie_ID`) VALUES (27, 16);
INSERT INTO `cinema`.`Casting` (`casting_artist_ID`, `casting_movie_ID`) VALUES (30, 17);
INSERT INTO `cinema`.`Casting` (`casting_artist_ID`, `casting_movie_ID`) VALUES (30, 18);
INSERT INTO `cinema`.`Casting` (`casting_artist_ID`, `casting_movie_ID`) VALUES (9, 19);
INSERT INTO `cinema`.`Casting` (`casting_artist_ID`, `casting_movie_ID`) VALUES (24, 20);
INSERT INTO `cinema`.`Casting` (`casting_artist_ID`, `casting_movie_ID`) VALUES (24, 21);
INSERT INTO `cinema`.`Casting` (`casting_artist_ID`, `casting_movie_ID`) VALUES (24, 22);
INSERT INTO `cinema`.`Casting` (`casting_artist_ID`, `casting_movie_ID`) VALUES (13, 23);
INSERT INTO `cinema`.`Casting` (`casting_artist_ID`, `casting_movie_ID`) VALUES (15, 24);

INSERT INTO `cinema`.`Directed` (`dir_artist_ID`, `dir_movie_ID`) VALUES (1, 1);
INSERT INTO `cinema`.`Directed` (`dir_artist_ID`, `dir_movie_ID`) VALUES (1, 2);
INSERT INTO `cinema`.`Directed` (`dir_artist_ID`, `dir_movie_ID`) VALUES (1, 3);
INSERT INTO `cinema`.`Directed` (`dir_artist_ID`, `dir_movie_ID`) VALUES (1, 4);
INSERT INTO `cinema`.`Directed` (`dir_artist_ID`, `dir_movie_ID`) VALUES (2, 5);
INSERT INTO `cinema`.`Directed` (`dir_artist_ID`, `dir_movie_ID`) VALUES (3, 6);
INSERT INTO `cinema`.`Directed` (`dir_artist_ID`, `dir_movie_ID`) VALUES (3, 7);
INSERT INTO `cinema`.`Directed` (`dir_artist_ID`, `dir_movie_ID`) VALUES (4, 8);
INSERT INTO `cinema`.`Directed` (`dir_artist_ID`, `dir_movie_ID`) VALUES (4, 9);

INSERT INTO `cinema`.`Customer` (`customer_name`, `customer_surname`, `customer_date`, `customer_cardID`, `customer_sex`, `customer_status`, `customer_favoriteGenre`, `customer_email`, `customer_phone`, `customer_dob`) VALUES													
													
('Petros', 'Aggelhs', '2010-12-18', '1', 'Male', 'Student', 'Drama', 'agg@ceid.gr', 6971653950, '1982-05-14')						,							
('Iwannhs', 'Aggelopoulos', '2010-12-19', '2', 'Male', 'Student', 'Action', 'agge@ceid.gr', 6971653951, '1995-07-08')						,							
('Gewrgia', 'Antwnakh', '2010-12-25', '3', 'Female', 'Married', 'Sci-Fi', 'ant@ceid.gr', 6971653952, '1984-12-14')						,							
('Gewrgios', 'Zervas', '2011-01-01', '4', 'Male', 'Single', 'Documentary', 'zer@ceid.gr', 6971653953, '1992-01-02')						,							
('Areth', 'Kartza', '2011-01-06', '5', 'Female', 'Married', 'Thriller', 'kar@ceid.gr', 6971653954,'1950-12-12')						,							
('Fwths', 'Kanakhs', '2011-01-08', '5', 'Male', 'Married', 'Thriller', 'kan@ceid.gr', 6971653955,'1987-10-16')						,							
('Grhgorhs', 'Kolovos', '2011-01-09', '3', 'Male', 'Married', 'Comedy', 'kol@ceid.gr', 6971653956,'1999-12-12')						,							
('Dhmhtra', 'Anagnwstou', '2011-03-24', '6', 'Female', 'Senior', 'Action', 'ana@ceid.gr', 6971653957,'1981-04-15')						,							
('Nikos', 'Nikolaou', '2012-08-17', '7', 'Male', 'Senior', 'Drama', 'niko@ceid.gr', 6971653958,'1986-05-18')						,							
('Panagiwta', 'Koutoula', '2014-07-09', '8', 'Female', 'Student', 'Action', 'kout@ceid.gr', 6971653959,'1993-12-12')						,							
('Eirhnh'	,'Aggelopoulou'	,'	2010-01-02	','9','Female'	,'Student',	'Drama',		'erag@ceid.gr',	6971653970	,'1985-01-01	'),
('Elpida'	,'Seferh'	,'	2010-02-03	','10','Female'	,'Married',	'Action',		'lefe@ceid.gr',	6971653971	,'1984-02-02	'),
('Eratw'	,'Samara'	,'	2010-03-04	','11','Female'	,'Student',	'Adventure',		'ersam@ceid.gr',	6971653972	,'1983-03-03	'),
('Adam'	,'Aggelopoulou'	,'	2010-04-24	','12','Male'	,'Single',	'Adventure',		'adamag@ceid.gr',	6971653973	,'1982-02-08	'),
('Adamantios'	,'Xrhstou'	,'	2010-05-28	','10','Male'	,'Married',	'Drama',		'adamxr@ceid.gr',	6971653974	,'1981-01-01	'),
('Athina'	,'Giwrgou'	,'	2010-09-29	','13','Female'	,'Student',	'Thriller',		'atge@ceid.gr',	6971653975	,'1980-10-10	'),
('Aggelos'	,'Giannhs'	,'	2010-06-24	','14','Male'	,'Married',	'Adventure',		'agnhkal@ceid.gr',	6971653976	,'1979-11-11	'),
('Agnh'	,'Kaliroou'	,'	2010-07-01	','14','Female'	,'Married',	'Thriller',		'antupas@ceid.gr',	6971653977	,'1965-10-17	'),
('Antupas'	,'Pantelhs'	,'	2010-08-15	','15','Male'	,'Single',	'Action',		'arseir@ceid.gr',	6971653978	,'1962-09-18	'),
('Aristeidhs'	,'Seirinakhs'	,'	2010-10-10	','16','Male'	,'Single',	'Thriller',		'arksa@ceid,gr',	6971653979	,'1959-01-19	'),
('Aristomenhs'	,'Ksanthoulhs'	,'	2010-11-12	','17','Male'	,'Student',	'Adventure',		'anesar@ceid.gr',	6971653980	,'1999-12-12	'),
('Anesths'	,'Sarrhs'	,'	2010-12-27	','18','Male'	,'Student',	'Adventure',		'asarrhs@ceid.gr',	6971653981	,'1997-06-06	'),
('Anna'	,'Samartzh'	,'	2010-01-24	','19','Female'	,'Single',	'Thriller',		'ansam@ceid.gr',	6971653982	,'1990-01-29	'),
('Ariadnh'	,'Stamatoukou'	,'	2010-01-08	','20','Female'	,'Single',	'Adventure',		'arstam@ceid.gr',	6971653983	,'1985-12-19	'),
('Aristokleia'	,'Triantafullou'	,'	2010-02-24	','21','Female'	,'Married',	'Drama',		'aristo@ceid.gr',	6971653984	,'1980-07-18	'),
('Silas'	,'Serafeim'	,'	2012-05-19	','21','Male'	,'Married',	'Thriller',		'siser@ceid.gr',	6971653985	,'1974-04-24	'),
('Sofia'	,'Lagkanh'	,'	2015-08-08	','22','Female'	,'Single',	'Adventure',		'soflagk@ceid.gr',	6971653986	,'1973-08-13	'),
('Sofoklhs'	,'Dogkanos'	,'	2014-05-03	','23','Male'	,'Student',	'Thriller',		'sodo@ceid.gr',	6971653987	,'1970-09-09	'),
('Simwn'	,'Papapetrou'	,'	2013-01-03	','24','Male'	,'Single',	'Action',		'simpap@ceid.gr',	6971653988	,'1978-10-12	'),
('Stamaths'	,'Lagkanhs'	,'	2012-05-05	','25','Male'	,'Married',	'Thriller',		'stamlagk@ceid.gr',	6971653989	,'1989-12-19	'),
('Savas'	,'Dimitriou'	,'	2013-12-15	','26','Male'	,'Student',	'Thriller',		'savdimi@ceid.gr',	6971653990	,'1985-12-15	'),
('Stauros'	,'Goytos'	,'	2013-12-19	','27','Male'	,'Single',	'Adventure',		'stgoutos@ceid.gr',	6971653991	,'1993-01-05	'),
('Spapfw'	,'Skoumprh'	,'	2013-05-04	','25','Female'	,'Married',	'Adventure',		'sapsk@ceid.gr',	6971653992	,'1991-06-15	'),
('Magda'	,'Mpointa'	,'	2014-08-19	','28','Female'	,'Student',	'Adventure',		'madmp@ceid.gr',	6971653993	,'1993-05-01	'),
('Maria'	,'Andriopoulou'	,'	2014-09-17	','29','Female'	,'Single',	'Action',		'mariaand@ceid.gr',	6971653994	,'1994-11-19	'),
('Matithildh'	,'Maggira'	,'	2014-03-03	','30','Female'	,'Married',	'Thriller',		'matmagk@ceid.gr',	6971653995	,'1997-12-18	'),
('Maroudhs'	,'Pasxalakhs'	,'	2015-05-09	','31','Male'	,'Student',	'Action',		'marpas@ceid.gr',	6971653996	,'1953-04-05	'),
('Methodios'	,'Papandreou'	,'	2015-09-18	','30','Male'	,'Married',	'Adventure',		'pap@ceid.gr',	6971653997	,'1940-05-08	'),
('Mamas'	,'Ageros'	,'	2015-09-29	','32','Male'	,'Student',	'Drama',		'ageros@ceid.gr',	6971653998	,'1914-04-12	'),
('Matthias'	,'Papaxrhstou'	,'	2010-08-09	','33','Male'	,'Single',	'Adventure',		'papax@ceid.gr',	6971653999	,'1955-05-18	'),
('Parasxos'	,'Staurakas'	,'	2010-10-10	','34','Male'	,'Married',	'Thriller',		'staurakas@ceid.gr',	6971654000	,'1959-07-09	'),
('Parthena'	,'Koumpouria'	,'	2010-11-12	','34','Female'	,'Married',	'Drama',		'parkoump@ceid.gr',	6971654001	,'1948-05-18	'),
('Pasxalhs'	,'Terzhs'	,'	2010-12-27	','35','Male'	,'Senior',	'Adventure',		'paster@ceid.gr',	6971654002	,'1967-06-17	'),
('Sakhs'	,'Rouvas'	,'	2010-01-24	','36','Male'	,'Single',	'Adventure',		'rouvas@ceid.gr',	6971654003	,'1975-12-15	'),
('Elena'	,'Paparizou'	,'	2010-01-08	','37','Female'	,'Student',	'Action',		'papariz@ceid.gr',	6971654004	,'1978-06-18	'),
('Dhmhtra'	,'Galanh'	,'	2013-01-03	','38','Female'	,'Student',	'Drama',		'galanhd@ceid.gr',	6971654005	,'1979-11-12	');

INSERT INTO `cinema`.`CustomerHistory` (`customerhistory_customer_tabID`, `customerhistory_history`) VALUES (1, '6');
INSERT INTO `cinema`.`CustomerHistory` (`customerhistory_customer_tabID`, `customerhistory_history`) VALUES (2, '12');
INSERT INTO `cinema`.`CustomerHistory` (`customerhistory_customer_tabID`, `customerhistory_history`) VALUES (3, '21');
INSERT INTO `cinema`.`CustomerHistory` (`customerhistory_customer_tabID`, `customerhistory_history`) VALUES (4, '11');
INSERT INTO `cinema`.`CustomerHistory` (`customerhistory_customer_tabID`, `customerhistory_history`) VALUES (4, '14');
INSERT INTO `cinema`.`CustomerHistory` (`customerhistory_customer_tabID`, `customerhistory_history`) VALUES (4, '1');
INSERT INTO `cinema`.`CustomerHistory` (`customerhistory_customer_tabID`, `customerhistory_history`) VALUES (4, '12');
INSERT INTO `cinema`.`CustomerHistory` (`customerhistory_customer_tabID`, `customerhistory_history`) VALUES (5, '16');
INSERT INTO `cinema`.`CustomerHistory` (`customerhistory_customer_tabID`, `customerhistory_history`) VALUES (6, '13');
INSERT INTO `cinema`.`CustomerHistory` (`customerhistory_customer_tabID`, `customerhistory_history`) VALUES (6, '12');
INSERT INTO `cinema`.`CustomerHistory` (`customerhistory_customer_tabID`, `customerhistory_history`) VALUES (5, '21');
INSERT INTO `cinema`.`CustomerHistory` (`customerhistory_customer_tabID`, `customerhistory_history`) VALUES (4, '3');
INSERT INTO `cinema`.`CustomerHistory` (`customerhistory_customer_tabID`, `customerhistory_history`) VALUES (9, '5');
INSERT INTO `cinema`.`CustomerHistory` (`customerhistory_customer_tabID`, `customerhistory_history`) VALUES (2, '17');
INSERT INTO `cinema`.`CustomerHistory` (`customerhistory_customer_tabID`, `customerhistory_history`) VALUES (8, '24');
INSERT INTO `cinema`.`CustomerHistory` (`customerhistory_customer_tabID`, `customerhistory_history`) VALUES (10, '21');

INSERT INTO `cinema`.`Card` (`card_customer_tabID`, `card_ID`, `card_points`) VALUES				
(	1	,'	1	',0),
(	2	,'	2	',0),
(	3	,'	3	',0),
(	4	,'	4	',0),
(	5	,'	5	',0),
(	6	,'	5	',0),
(	7	,'	3	',0),
(	8	,'	6	',0),
(	9	,'	7	',0),
(	10	,'	8	',0),
(	11	,'	9	',0),
(	12	,'	10	',0),
(	13	,'	11	',0),
(	14	,'	12	',0),
(	15	,'	10	',0),
(	16	,'	13	',0),
(	17	,'	14	',0),
(	18	,'	14	',0),
(	19	,'	15	',0),
(	20	,'	16	',0),
(	21	,'	17	',0),
(	22	,'	18	',0),
(	23	,'	19	',0),
(	24	,'	20	',0),
(	25	,'	21	',0),
(	26	,'	21	',0),
(	27	,'	22	',0),
(	28	,'	23	',0),
(	29	,'	24	',0),
(	30	,'	25	',0),
(	31	,'	26	',0),
(	32	,'	27	',0),
(	33	,'	25	',0),
(	34	,'	28	',0),
(	35	,'	29	',0),
(	36	,'	30	',0),
(	37	,'	31	',0),
(	38	,'	30	',0),
(	39	,'	32	',0),
(	40	,'	33	',0),
(	41	,'	34	',0),
(	42	,'	34	',0),
(	43	,'	35	',0),
(	44	,'	36	',0),
(	45	,'	37	',0),
(	46	,'	38	',0);


INSERT INTO `cinema`.`Rated` (`rated_movie_ID`, `rated_customer_tabID`, `rated_customerRatio`) VALUES (1, 16, 3.5);
INSERT INTO `cinema`.`Rated` (`rated_movie_ID`, `rated_customer_tabID`, `rated_customerRatio`) VALUES (1, 19, 2.6);
INSERT INTO `cinema`.`Rated` (`rated_movie_ID`, `rated_customer_tabID`, `rated_customerRatio`) VALUES (20, 3, 4.5);
INSERT INTO `cinema`.`Rated` (`rated_movie_ID`, `rated_customer_tabID`, `rated_customerRatio`) VALUES (11, 4, 4.8);
INSERT INTO `cinema`.`Rated` (`rated_movie_ID`, `rated_customer_tabID`, `rated_customerRatio`) VALUES (1, 1, 4.8);
INSERT INTO `cinema`.`Rated` (`rated_movie_ID`, `rated_customer_tabID`, `rated_customerRatio`) VALUES (1, 14, 4.5);
INSERT INTO `cinema`.`Rated` (`rated_movie_ID`, `rated_customer_tabID`, `rated_customerRatio`) VALUES (12, 4, 4.9);
INSERT INTO `cinema`.`Rated` (`rated_movie_ID`, `rated_customer_tabID`, `rated_customerRatio`) VALUES (4, 26, 5.0); -- 
INSERT INTO `cinema`.`Rated` (`rated_movie_ID`, `rated_customer_tabID`, `rated_customerRatio`) VALUES (20, 6, 3.2);
INSERT INTO `cinema`.`Rated` (`rated_movie_ID`, `rated_customer_tabID`, `rated_customerRatio`) VALUES (12, 6, 3.1);
INSERT INTO `cinema`.`Rated` (`rated_movie_ID`, `rated_customer_tabID`, `rated_customerRatio`) VALUES (3, 4, 2.5);
INSERT INTO `cinema`.`Rated` (`rated_movie_ID`, `rated_customer_tabID`, `rated_customerRatio`) VALUES (5, 9, 1.9);
INSERT INTO `cinema`.`Rated` (`rated_movie_ID`, `rated_customer_tabID`, `rated_customerRatio`) VALUES (17, 2, 2.8);
INSERT INTO `cinema`.`Rated` (`rated_movie_ID`, `rated_customer_tabID`, `rated_customerRatio`) VALUES (24, 8, 3.7);
INSERT INTO `cinema`.`Rated` (`rated_movie_ID`, `rated_customer_tabID`, `rated_customerRatio`) VALUES (1, 2, 3.9);
INSERT INTO `cinema`.`Rated` (`rated_movie_ID`, `rated_customer_tabID`, `rated_customerRatio`) VALUES (1, 3, 3.9);
INSERT INTO `cinema`.`Rated` (`rated_movie_ID`, `rated_customer_tabID`, `rated_customerRatio`) VALUES (1, 30, 4.5);
INSERT INTO `cinema`.`Rated` (`rated_movie_ID`, `rated_customer_tabID`, `rated_customerRatio`) VALUES (1, 31, 1.2);
INSERT INTO `cinema`.`Rated` (`rated_movie_ID`, `rated_customer_tabID`, `rated_customerRatio`) VALUES (1, 32, 5);
INSERT INTO `cinema`.`Rated` (`rated_movie_ID`, `rated_customer_tabID`, `rated_customerRatio`) VALUES (1, 34, 2.0);
INSERT INTO `cinema`.`Rated` (`rated_movie_ID`, `rated_customer_tabID`, `rated_customerRatio`) VALUES (1, 33, 3.0);
INSERT INTO `cinema`.`Rated` (`rated_movie_ID`, `rated_customer_tabID`, `rated_customerRatio`) VALUES (1, 27, 4.4);
INSERT INTO `cinema`.`Rated` (`rated_movie_ID`, `rated_customer_tabID`, `rated_customerRatio`) VALUES (1, 28, 4.5);

INSERT INTO `cinema`.`Stage` (`st_name`, `st_floor`, `st_3Dsupport`, `st_aircondition_status`, `st_capacity`, `st_availability`) VALUES ('Anemoesa', 1, 'No', 'Yes', '132', 'Available');
INSERT INTO `cinema`.`Stage` (`st_name`, `st_floor`, `st_3Dsupport`, `st_aircondition_status`, `st_capacity`, `st_availability`) VALUES ('Agalipa', 2, 'Yes', 'Yes', '132', 'Available');
INSERT INTO `cinema`.`Stage` (`st_name`, `st_floor`, `st_3Dsupport`, `st_aircondition_status`, `st_capacity`, `st_availability`) VALUES ('Nauagio', 1, 'No', 'No', '132', 'Available');
INSERT INTO `cinema`.`Stage` (`st_name`, `st_floor`, `st_3Dsupport`, `st_aircondition_status`, `st_capacity`, `st_availability`) VALUES ('Atsitsa', 1, 'No', 'No', '132', 'Available');
INSERT INTO `cinema`.`Stage` (`st_name`, `st_floor`, `st_3Dsupport`, `st_aircondition_status`, `st_capacity`, `st_availability`) VALUES ('Fwkiada', 2, 'Yes', 'Yes', '132', 'Available');

INSERT INTO	Seats VALUES			
('Anemoesa', 	'A01', 	'High'	,'Right'	,'No')	,
('Anemoesa', 	'A02', 	'High'	,'Right'	,'No')	,
('Anemoesa', 	'A03', 	'High'	,'Right'	,'Yes')	,
('Anemoesa', 	'A04', 	'High'	,'Center'	,'Yes')	,
('Anemoesa', 	'A05', 	'High'	,'Center'	,'No')	,
('Anemoesa', 	'A06', 	'High'	,'Center'	,'No')	,
('Anemoesa', 	'A07', 	'High'	,'Center'	,'No')	,
('Anemoesa', 	'A08', 	'High'	,'Center'	,'No')	,
('Anemoesa', 	'A09', 	'High'	,'Center'	,'Yes')	,
('Anemoesa', 	'A10', 	'High'	,'Left'	,'Yes')	,
('Anemoesa', 	'A11', 	'High'	,'Left'	,'No')	,
('Anemoesa', 	'A12', 	'High'	,'Left'	,'No')	,
('Anemoesa', 	'B01', 	'High'	,'Right'	,'No')	,
('Anemoesa', 	'B02', 	'High'	,'Right'	,'No')	,
('Anemoesa', 	'B03', 	'High'	,'Right'	,'Yes')	,
('Anemoesa', 	'B04', 	'High'	,'Center'	,'Yes')	,
('Anemoesa', 	'B05', 	'High'	,'Center'	,'No')	,
('Anemoesa', 	'B06', 	'High'	,'Center'	,'No')	,
('Anemoesa', 	'B07', 	'High'	,'Center'	,'No')	,
('Anemoesa', 	'B08', 	'High'	,'Center'	,'No')	,
('Anemoesa', 	'B09', 	'High'	,'Center'	,'Yes')	,
('Anemoesa', 	'B10', 	'High'	,'Left'	,'Yes')	,
('Anemoesa', 	'B11', 	'High'	,'Left'	,'No')	,
('Anemoesa', 	'B12', 	'High'	,'Left'	,'No')	,
('Anemoesa', 	'C01', 	'High'	,'Right'	,'No')	,
('Anemoesa', 	'C02', 	'High'	,'Right'	,'No')	,
('Anemoesa', 	'C03', 	'High'	,'Right'	,'Yes')	,
('Anemoesa', 	'C04', 	'High'	,'Center'	,'Yes')	,
('Anemoesa', 	'C05', 	'High'	,'Center'	,'No')	,
('Anemoesa', 	'C06', 	'High'	,'Center'	,'No')	,
('Anemoesa', 	'C07', 	'High'	,'Center'	,'No')	,
('Anemoesa', 	'C08', 	'High'	,'Center'	,'No')	,
('Anemoesa', 	'C09', 	'High'	,'Center'	,'Yes')	,
('Anemoesa', 	'C10', 	'High'	,'Left'	,'Yes')	,
('Anemoesa', 	'C11', 	'High'	,'Left'	,'No')	,
('Anemoesa', 	'C12', 	'High'	,'Left'	,'No')	,
('Anemoesa', 	'D01', 	'Core'	,'Right'	,'No')	,
('Anemoesa', 	'D02', 	'Core'	,'Right'	,'No')	,
('Anemoesa', 	'D03', 	'Core'	,'Right'	,'Yes')	,
('Anemoesa', 	'D04', 	'Core'	,'Center'	,'Yes')	,
('Anemoesa', 	'D05', 	'Core'	,'Center'	,'No')	,
('Anemoesa', 	'D06', 	'Core'	,'Center'	,'No')	,
('Anemoesa', 	'D07', 	'Core'	,'Center'	,'No')	,
('Anemoesa', 	'D08', 	'Core'	,'Center'	,'No')	,
('Anemoesa', 	'D09', 	'Core'	,'Center'	,'Yes')	,
('Anemoesa', 	'D10', 	'Core'	,'Left'	,'Yes')	,
('Anemoesa', 	'D11', 	'Core'	,'Left'	,'No')	,
('Anemoesa', 	'D12', 	'Core'	,'Left'	,'No')	,
('Anemoesa', 	'E01', 	'Core'	,'Right'	,'No')	,
('Anemoesa', 	'E02', 	'Core'	,'Right'	,'No')	,
('Anemoesa', 	'E03', 	'Core'	,'Right'	,'Yes')	,
('Anemoesa', 	'E04', 	'Core'	,'Center'	,'Yes')	,
('Anemoesa', 	'E05', 	'Core'	,'Center'	,'No')	,
('Anemoesa', 	'E06', 	'Core'	,'Center'	,'No')	,
('Anemoesa', 	'E07', 	'Core'	,'Center'	,'No')	,
('Anemoesa', 	'E08', 	'Core'	,'Center'	,'No')	,
('Anemoesa', 	'E09', 	'Core'	,'Center'	,'Yes')	,
('Anemoesa', 	'E10', 	'Core'	,'Left'	,'Yes')	,
('Anemoesa', 	'E11', 	'Core'	,'Left'	,'No')	,
('Anemoesa', 	'E12', 	'Core'	,'Left'	,'No')	,
('Anemoesa', 	'F01', 	'Core'	,'Right'	,'No')	,
('Anemoesa', 	'F02', 	'Core'	,'Right'	,'No')	,
('Anemoesa', 	'F03', 	'Core'	,'Right'	,'Yes')	,
('Anemoesa', 	'F04', 	'Core'	,'Center'	,'Yes')	,
('Anemoesa', 	'F05', 	'Core'	,'Center'	,'No')	,
('Anemoesa', 	'F06', 	'Core'	,'Center'	,'No')	,
('Anemoesa', 	'F07', 	'Core'	,'Center'	,'No')	,
('Anemoesa', 	'F08', 	'Core'	,'Center'	,'No')	,
('Anemoesa', 	'F09', 	'Core'	,'Center'	,'Yes')	,
('Anemoesa', 	'F10', 	'Core'	,'Left'	,'Yes')	,
('Anemoesa', 	'F11', 	'Core'	,'Left'	,'No')	,
('Anemoesa', 	'F12', 	'Core'	,'Left'	,'No')	,
('Anemoesa', 	'G01', 	'Core'	,'Right'	,'No')	,
('Anemoesa', 	'G02', 	'Core'	,'Right'	,'No')	,
('Anemoesa', 	'G03', 	'Core'	,'Right'	,'Yes')	,
('Anemoesa', 	'G04', 	'Core'	,'Center'	,'Yes')	,
('Anemoesa', 	'G05', 	'Core'	,'Center'	,'No')	,
('Anemoesa', 	'G06', 	'Core'	,'Center'	,'No')	,
('Anemoesa', 	'G07', 	'Core'	,'Center'	,'No')	,
('Anemoesa', 	'G08', 	'Core'	,'Center'	,'No')	,
('Anemoesa', 	'G09', 	'Core'	,'Center'	,'Yes')	,
('Anemoesa', 	'G10', 	'Core'	,'Left'	,'Yes')	,
('Anemoesa', 	'G11', 	'Core'	,'Left'	,'No')	,
('Anemoesa', 	'G12', 	'Core'	,'Left'	,'No')	,
('Anemoesa', 	'H01', 	'Core'	,'Right'	,'No')	,
('Anemoesa', 	'H02', 	'Core'	,'Right'	,'No')	,
('Anemoesa', 	'H03', 	'Core'	,'Right'	,'Yes')	,
('Anemoesa', 	'H04', 	'Core'	,'Center'	,'Yes')	,
('Anemoesa', 	'H05', 	'Core'	,'Center'	,'No')	,
('Anemoesa', 	'H06', 	'Core'	,'Center'	,'No')	,
('Anemoesa', 	'H07', 	'Core'	,'Center'	,'No')	,
('Anemoesa', 	'H08', 	'Core'	,'Center'	,'No')	,
('Anemoesa', 	'H09', 	'Core'	,'Center'	,'Yes')	,
('Anemoesa', 	'H10', 	'Core'	,'Left'	,'Yes')	,
('Anemoesa', 	'H11', 	'Core'	,'Left'	,'No')	,
('Anemoesa', 	'H12', 	'Core'	,'Left'	,'No')	,
('Anemoesa', 	'I01', 	'Low'	,'Right'	,'No')	,
('Anemoesa', 	'I02', 	'Low'	,'Right'	,'No')	,
('Anemoesa', 	'I03', 	'Low'	,'Right'	,'Yes')	,
('Anemoesa', 	'I04', 	'Low'	,'Center'	,'Yes')	,
('Anemoesa', 	'I05', 	'Low'	,'Center'	,'No')	,
('Anemoesa', 	'I06', 	'Low'	,'Center'	,'No')	,
('Anemoesa', 	'I07', 	'Low'	,'Center'	,'No')	,
('Anemoesa', 	'I08', 	'Low'	,'Center'	,'No')	,
('Anemoesa', 	'I09', 	'Low'	,'Center'	,'Yes')	,
('Anemoesa', 	'I10', 	'Low'	,'Left'	,'Yes')	,
('Anemoesa', 	'I11', 	'Low'	,'Left'	,'No')	,
('Anemoesa', 	'I12', 	'Low'	,'Left'	,'No')	,
('Anemoesa', 	'J01', 	'Low'	,'Right'	,'No')	,
('Anemoesa', 	'J02', 	'Low'	,'Right'	,'No')	,
('Anemoesa', 	'J03', 	'Low'	,'Right'	,'Yes')	,
('Anemoesa', 	'J04', 	'Low'	,'Center'	,'Yes')	,
('Anemoesa', 	'J05', 	'Low'	,'Center'	,'No')	,
('Anemoesa', 	'J06', 	'Low'	,'Center'	,'No')	,
('Anemoesa', 	'J07', 	'Low'	,'Center'	,'No')	,
('Anemoesa', 	'J08', 	'Low'	,'Center'	,'No')	,
('Anemoesa', 	'J09', 	'Low'	,'Center'	,'Yes')	,
('Anemoesa', 	'J10', 	'Low'	,'Left'	,'Yes')	,
('Anemoesa', 	'J11', 	'Low'	,'Left'	,'No')	,
('Anemoesa', 	'J12', 	'Low'	,'Left'	,'No')	,
('Anemoesa', 	'K01', 	'Low'	,'Right'	,'No')	,
('Anemoesa', 	'K02', 	'Low'	,'Right'	,'No')	,
('Anemoesa', 	'K03', 	'Low'	,'Right'	,'Yes')	,
('Anemoesa', 	'K04', 	'Low'	,'Center'	,'Yes')	,
('Anemoesa', 	'K05', 	'Low'	,'Center'	,'No')	,
('Anemoesa', 	'K06', 	'Low'	,'Center'	,'No')	,
('Anemoesa', 	'K07', 	'Low'	,'Center'	,'No')	,
('Anemoesa', 	'K08', 	'Low'	,'Center'	,'No')	,
('Anemoesa', 	'K09', 	'Low'	,'Center'	,'Yes')	,
('Anemoesa', 	'K10', 	'Low'	,'Left'	,'Yes')	,
('Anemoesa', 	'K11', 	'Low'	,'Left'	,'No')	,
('Anemoesa', 	'K12', 	'Low'	,'Left'	,'No')	,
('Agalipa', 	'A01', 	'High'	,'Right'	,'No')	,
('Agalipa', 	'A02', 	'High'	,'Right'	,'No')	,
('Agalipa', 	'A03', 	'High'	,'Right'	,'Yes')	,
('Agalipa', 	'A04', 	'High'	,'Center'	,'Yes')	,
('Agalipa', 	'A05', 	'High'	,'Center'	,'No')	,
('Agalipa', 	'A06', 	'High'	,'Center'	,'No')	,
('Agalipa', 	'A07', 	'High'	,'Center'	,'No')	,
('Agalipa', 	'A08', 	'High'	,'Center'	,'No')	,
('Agalipa', 	'A09', 	'High'	,'Center'	,'Yes')	,
('Agalipa', 	'A10', 	'High'	,'Left'	,'Yes')	,
('Agalipa', 	'A11', 	'High'	,'Left'	,'No')	,
('Agalipa', 	'A12', 	'High'	,'Left'	,'No')	,
('Agalipa', 	'B01', 	'High'	,'Right'	,'No')	,
('Agalipa', 	'B02', 	'High'	,'Right'	,'No')	,
('Agalipa', 	'B03', 	'High'	,'Right'	,'Yes')	,
('Agalipa', 	'B04', 	'High'	,'Center'	,'Yes')	,
('Agalipa', 	'B05', 	'High'	,'Center'	,'No')	,
('Agalipa', 	'B06', 	'High'	,'Center'	,'No')	,
('Agalipa', 	'B07', 	'High'	,'Center'	,'No')	,
('Agalipa', 	'B08', 	'High'	,'Center'	,'No')	,
('Agalipa', 	'B09', 	'High'	,'Center'	,'Yes')	,
('Agalipa', 	'B10', 	'High'	,'Left'	,'Yes')	,
('Agalipa', 	'B11', 	'High'	,'Left'	,'No')	,
('Agalipa', 	'B12', 	'High'	,'Left'	,'No')	,
('Agalipa', 	'C01', 	'High'	,'Right'	,'No')	,
('Agalipa', 	'C02', 	'High'	,'Right'	,'No')	,
('Agalipa', 	'C03', 	'High'	,'Right'	,'Yes')	,
('Agalipa', 	'C04', 	'High'	,'Center'	,'Yes')	,
('Agalipa', 	'C05', 	'High'	,'Center'	,'No')	,
('Agalipa', 	'C06', 	'High'	,'Center'	,'No')	,
('Agalipa', 	'C07', 	'High'	,'Center'	,'No')	,
('Agalipa', 	'C08', 	'High'	,'Center'	,'No')	,
('Agalipa', 	'C09', 	'High'	,'Center'	,'Yes')	,
('Agalipa', 	'C10', 	'High'	,'Left'	,'Yes')	,
('Agalipa', 	'C11', 	'High'	,'Left'	,'No')	,
('Agalipa', 	'C12', 	'High'	,'Left'	,'No')	,
('Agalipa', 	'D01', 	'Core'	,'Right'	,'No')	,
('Agalipa', 	'D02', 	'Core'	,'Right'	,'No')	,
('Agalipa', 	'D03', 	'Core'	,'Right'	,'Yes')	,
('Agalipa', 	'D04', 	'Core'	,'Center'	,'Yes')	,
('Agalipa', 	'D05', 	'Core'	,'Center'	,'No')	,
('Agalipa', 	'D06', 	'Core'	,'Center'	,'No')	,
('Agalipa', 	'D07', 	'Core'	,'Center'	,'No')	,
('Agalipa', 	'D08', 	'Core'	,'Center'	,'No')	,
('Agalipa', 	'D09', 	'Core'	,'Center'	,'Yes')	,
('Agalipa', 	'D10', 	'Core'	,'Left'	,'Yes')	,
('Agalipa', 	'D11', 	'Core'	,'Left'	,'No')	,
('Agalipa', 	'D12', 	'Core'	,'Left'	,'No')	,
('Agalipa', 	'E01', 	'Core'	,'Right'	,'No')	,
('Agalipa', 	'E02', 	'Core'	,'Right'	,'No')	,
('Agalipa', 	'E03', 	'Core'	,'Right'	,'Yes')	,
('Agalipa', 	'E04', 	'Core'	,'Center'	,'Yes')	,
('Agalipa', 	'E05', 	'Core'	,'Center'	,'No')	,
('Agalipa', 	'E06', 	'Core'	,'Center'	,'No')	,
('Agalipa', 	'E07', 	'Core'	,'Center'	,'No')	,
('Agalipa', 	'E08', 	'Core'	,'Center'	,'No')	,
('Agalipa', 	'E09', 	'Core'	,'Center'	,'Yes')	,
('Agalipa', 	'E10', 	'Core'	,'Left'	,'Yes')	,
('Agalipa', 	'E11', 	'Core'	,'Left'	,'No')	,
('Agalipa', 	'E12', 	'Core'	,'Left'	,'No')	,
('Agalipa', 	'F01', 	'Core'	,'Right'	,'No')	,
('Agalipa', 	'F02', 	'Core'	,'Right'	,'No')	,
('Agalipa', 	'F03', 	'Core'	,'Right'	,'Yes')	,
('Agalipa', 	'F04', 	'Core'	,'Center'	,'Yes')	,
('Agalipa', 	'F05', 	'Core'	,'Center'	,'No')	,
('Agalipa', 	'F06', 	'Core'	,'Center'	,'No')	,
('Agalipa', 	'F07', 	'Core'	,'Center'	,'No')	,
('Agalipa', 	'F08', 	'Core'	,'Center'	,'No')	,
('Agalipa', 	'F09', 	'Core'	,'Center'	,'Yes')	,
('Agalipa', 	'F10', 	'Core'	,'Left'	,'Yes')	,
('Agalipa', 	'F11', 	'Core'	,'Left'	,'No')	,
('Agalipa', 	'F12', 	'Core'	,'Left'	,'No')	,
('Agalipa', 	'G01', 	'Core'	,'Right'	,'No')	,
('Agalipa', 	'G02', 	'Core'	,'Right'	,'No')	,
('Agalipa', 	'G03', 	'Core'	,'Right'	,'Yes')	,
('Agalipa', 	'G04', 	'Core'	,'Center'	,'Yes')	,
('Agalipa', 	'G05', 	'Core'	,'Center'	,'No')	,
('Agalipa', 	'G06', 	'Core'	,'Center'	,'No')	,
('Agalipa', 	'G07', 	'Core'	,'Center'	,'No')	,
('Agalipa', 	'G08', 	'Core'	,'Center'	,'No')	,
('Agalipa', 	'G09', 	'Core'	,'Center'	,'Yes')	,
('Agalipa', 	'G10', 	'Core'	,'Left'	,'Yes')	,
('Agalipa', 	'G11', 	'Core'	,'Left'	,'No')	,
('Agalipa', 	'G12', 	'Core'	,'Left'	,'No')	,
('Agalipa', 	'H01', 	'Core'	,'Right'	,'No')	,
('Agalipa', 	'H02', 	'Core'	,'Right'	,'No')	,
('Agalipa', 	'H03', 	'Core'	,'Right'	,'Yes')	,
('Agalipa', 	'H04', 	'Core'	,'Center'	,'Yes')	,
('Agalipa', 	'H05', 	'Core'	,'Center'	,'No')	,
('Agalipa', 	'H06', 	'Core'	,'Center'	,'No')	,
('Agalipa', 	'H07', 	'Core'	,'Center'	,'No')	,
('Agalipa', 	'H08', 	'Core'	,'Center'	,'No')	,
('Agalipa', 	'H09', 	'Core'	,'Center'	,'Yes')	,
('Agalipa', 	'H10', 	'Core'	,'Left'	,'Yes')	,
('Agalipa', 	'H11', 	'Core'	,'Left'	,'No')	,
('Agalipa', 	'H12', 	'Core'	,'Left'	,'No')	,
('Agalipa', 	'I01', 	'Low'	,'Right'	,'No')	,
('Agalipa', 	'I02', 	'Low'	,'Right'	,'No')	,
('Agalipa', 	'I03', 	'Low'	,'Right'	,'Yes')	,
('Agalipa', 	'I04', 	'Low'	,'Center'	,'Yes')	,
('Agalipa', 	'I05', 	'Low'	,'Center'	,'No')	,
('Agalipa', 	'I06', 	'Low'	,'Center'	,'No')	,
('Agalipa', 	'I07', 	'Low'	,'Center'	,'No')	,
('Agalipa', 	'I08', 	'Low'	,'Center'	,'No')	,
('Agalipa', 	'I09', 	'Low'	,'Center'	,'Yes')	,
('Agalipa', 	'I10', 	'Low'	,'Left'	,'Yes')	,
('Agalipa', 	'I11', 	'Low'	,'Left'	,'No')	,
('Agalipa', 	'I12', 	'Low'	,'Left'	,'No')	,
('Agalipa', 	'J01', 	'Low'	,'Right'	,'No')	,
('Agalipa', 	'J02', 	'Low'	,'Right'	,'No')	,
('Agalipa', 	'J03', 	'Low'	,'Right'	,'Yes')	,
('Agalipa', 	'J04', 	'Low'	,'Center'	,'Yes')	,
('Agalipa', 	'J05', 	'Low'	,'Center'	,'No')	,
('Agalipa', 	'J06', 	'Low'	,'Center'	,'No')	,
('Agalipa', 	'J07', 	'Low'	,'Center'	,'No')	,
('Agalipa', 	'J08', 	'Low'	,'Center'	,'No')	,
('Agalipa', 	'J09', 	'Low'	,'Center'	,'Yes')	,
('Agalipa', 	'J10', 	'Low'	,'Left'	,'Yes')	,
('Agalipa', 	'J11', 	'Low'	,'Left'	,'No')	,
('Agalipa', 	'J12', 	'Low'	,'Left'	,'No')	,
('Agalipa', 	'K01', 	'Low'	,'Right'	,'No')	,
('Agalipa', 	'K02', 	'Low'	,'Right'	,'No')	,
('Agalipa', 	'K03', 	'Low'	,'Right'	,'Yes')	,
('Agalipa', 	'K04', 	'Low'	,'Center'	,'Yes')	,
('Agalipa', 	'K05', 	'Low'	,'Center'	,'No')	,
('Agalipa', 	'K06', 	'Low'	,'Center'	,'No')	,
('Agalipa', 	'K07', 	'Low'	,'Center'	,'No')	,
('Agalipa', 	'K08', 	'Low'	,'Center'	,'No')	,
('Agalipa', 	'K09', 	'Low'	,'Center'	,'Yes')	,
('Agalipa', 	'K10', 	'Low'	,'Left'	,'Yes')	,
('Agalipa', 	'K11', 	'Low'	,'Left'	,'No')	,
('Agalipa', 	'K12', 	'Low'	,'Left'	,'No')	,
('Nauagio', 	'A01', 	'High'	,'Right'	,'No')	,
('Nauagio', 	'A02', 	'High'	,'Right'	,'No')	,
('Nauagio', 	'A03', 	'High'	,'Right'	,'Yes')	,
('Nauagio', 	'A04', 	'High'	,'Center'	,'Yes')	,
('Nauagio', 	'A05', 	'High'	,'Center'	,'No')	,
('Nauagio', 	'A06', 	'High'	,'Center'	,'No')	,
('Nauagio', 	'A07', 	'High'	,'Center'	,'No')	,
('Nauagio', 	'A08', 	'High'	,'Center'	,'No')	,
('Nauagio', 	'A09', 	'High'	,'Center'	,'Yes')	,
('Nauagio', 	'A10', 	'High'	,'Left'	,'Yes')	,
('Nauagio', 	'A11', 	'High'	,'Left'	,'No')	,
('Nauagio', 	'A12', 	'High'	,'Left'	,'No')	,
('Nauagio', 	'B01', 	'High'	,'Right'	,'No')	,
('Nauagio', 	'B02', 	'High'	,'Right'	,'No')	,
('Nauagio', 	'B03', 	'High'	,'Right'	,'Yes')	,
('Nauagio', 	'B04', 	'High'	,'Center'	,'Yes')	,
('Nauagio', 	'B05', 	'High'	,'Center'	,'No')	,
('Nauagio', 	'B06', 	'High'	,'Center'	,'No')	,
('Nauagio', 	'B07', 	'High'	,'Center'	,'No')	,
('Nauagio', 	'B08', 	'High'	,'Center'	,'No')	,
('Nauagio', 	'B09', 	'High'	,'Center'	,'Yes')	,
('Nauagio', 	'B10', 	'High'	,'Left'	,'Yes')	,
('Nauagio', 	'B11', 	'High'	,'Left'	,'No')	,
('Nauagio', 	'B12', 	'High'	,'Left'	,'No')	,
('Nauagio', 	'C01', 	'High'	,'Right'	,'No')	,
('Nauagio', 	'C02', 	'High'	,'Right'	,'No')	,
('Nauagio', 	'C03', 	'High'	,'Right'	,'Yes')	,
('Nauagio', 	'C04', 	'High'	,'Center'	,'Yes')	,
('Nauagio', 	'C05', 	'High'	,'Center'	,'No')	,
('Nauagio', 	'C06', 	'High'	,'Center'	,'No')	,
('Nauagio', 	'C07', 	'High'	,'Center'	,'No')	,
('Nauagio', 	'C08', 	'High'	,'Center'	,'No')	,
('Nauagio', 	'C09', 	'High'	,'Center'	,'Yes')	,
('Nauagio', 	'C10', 	'High'	,'Left'	,'Yes')	,
('Nauagio', 	'C11', 	'High'	,'Left'	,'No')	,
('Nauagio', 	'C12', 	'High'	,'Left'	,'No')	,
('Nauagio', 	'D01', 	'Core'	,'Right'	,'No')	,
('Nauagio', 	'D02', 	'Core'	,'Right'	,'No')	,
('Nauagio', 	'D03', 	'Core'	,'Right'	,'Yes')	,
('Nauagio', 	'D04', 	'Core'	,'Center'	,'Yes')	,
('Nauagio', 	'D05', 	'Core'	,'Center'	,'No')	,
('Nauagio', 	'D06', 	'Core'	,'Center'	,'No')	,
('Nauagio', 	'D07', 	'Core'	,'Center'	,'No')	,
('Nauagio', 	'D08', 	'Core'	,'Center'	,'No')	,
('Nauagio', 	'D09', 	'Core'	,'Center'	,'Yes')	,
('Nauagio', 	'D10', 	'Core'	,'Left'	,'Yes')	,
('Nauagio', 	'D11', 	'Core'	,'Left'	,'No')	,
('Nauagio', 	'D12', 	'Core'	,'Left'	,'No')	,
('Nauagio', 	'E01', 	'Core'	,'Right'	,'No')	,
('Nauagio', 	'E02', 	'Core'	,'Right'	,'No')	,
('Nauagio', 	'E03', 	'Core'	,'Right'	,'Yes')	,
('Nauagio', 	'E04', 	'Core'	,'Center'	,'Yes')	,
('Nauagio', 	'E05', 	'Core'	,'Center'	,'No')	,
('Nauagio', 	'E06', 	'Core'	,'Center'	,'No')	,
('Nauagio', 	'E07', 	'Core'	,'Center'	,'No')	,
('Nauagio', 	'E08', 	'Core'	,'Center'	,'No')	,
('Nauagio', 	'E09', 	'Core'	,'Center'	,'Yes')	,
('Nauagio', 	'E10', 	'Core'	,'Left'	,'Yes')	,
('Nauagio', 	'E11', 	'Core'	,'Left'	,'No')	,
('Nauagio', 	'E12', 	'Core'	,'Left'	,'No')	,
('Nauagio', 	'F01', 	'Core'	,'Right'	,'No')	,
('Nauagio', 	'F02', 	'Core'	,'Right'	,'No')	,
('Nauagio', 	'F03', 	'Core'	,'Right'	,'Yes')	,
('Nauagio', 	'F04', 	'Core'	,'Center'	,'Yes')	,
('Nauagio', 	'F05', 	'Core'	,'Center'	,'No')	,
('Nauagio', 	'F06', 	'Core'	,'Center'	,'No')	,
('Nauagio', 	'F07', 	'Core'	,'Center'	,'No')	,
('Nauagio', 	'F08', 	'Core'	,'Center'	,'No')	,
('Nauagio', 	'F09', 	'Core'	,'Center'	,'Yes')	,
('Nauagio', 	'F10', 	'Core'	,'Left'	,'Yes')	,
('Nauagio', 	'F11', 	'Core'	,'Left'	,'No')	,
('Nauagio', 	'F12', 	'Core'	,'Left'	,'No')	,
('Nauagio', 	'G01', 	'Core'	,'Right'	,'No')	,
('Nauagio', 	'G02', 	'Core'	,'Right'	,'No')	,
('Nauagio', 	'G03', 	'Core'	,'Right'	,'Yes')	,
('Nauagio', 	'G04', 	'Core'	,'Center'	,'Yes')	,
('Nauagio', 	'G05', 	'Core'	,'Center'	,'No')	,
('Nauagio', 	'G06', 	'Core'	,'Center'	,'No')	,
('Nauagio', 	'G07', 	'Core'	,'Center'	,'No')	,
('Nauagio', 	'G08', 	'Core'	,'Center'	,'No')	,
('Nauagio', 	'G09', 	'Core'	,'Center'	,'Yes')	,
('Nauagio', 	'G10', 	'Core'	,'Left'	,'Yes')	,
('Nauagio', 	'G11', 	'Core'	,'Left'	,'No')	,
('Nauagio', 	'G12', 	'Core'	,'Left'	,'No')	,
('Nauagio', 	'H01', 	'Core'	,'Right'	,'No')	,
('Nauagio', 	'H02', 	'Core'	,'Right'	,'No')	,
('Nauagio', 	'H03', 	'Core'	,'Right'	,'Yes')	,
('Nauagio', 	'H04', 	'Core'	,'Center'	,'Yes')	,
('Nauagio', 	'H05', 	'Core'	,'Center'	,'No')	,
('Nauagio', 	'H06', 	'Core'	,'Center'	,'No')	,
('Nauagio', 	'H07', 	'Core'	,'Center'	,'No')	,
('Nauagio', 	'H08', 	'Core'	,'Center'	,'No')	,
('Nauagio', 	'H09', 	'Core'	,'Center'	,'Yes')	,
('Nauagio', 	'H10', 	'Core'	,'Left'	,'Yes')	,
('Nauagio', 	'H11', 	'Core'	,'Left'	,'No')	,
('Nauagio', 	'H12', 	'Core'	,'Left'	,'No')	,
('Nauagio', 	'I01', 	'Low'	,'Right'	,'No')	,
('Nauagio', 	'I02', 	'Low'	,'Right'	,'No')	,
('Nauagio', 	'I03', 	'Low'	,'Right'	,'Yes')	,
('Nauagio', 	'I04', 	'Low'	,'Center'	,'Yes')	,
('Nauagio', 	'I05', 	'Low'	,'Center'	,'No')	,
('Nauagio', 	'I06', 	'Low'	,'Center'	,'No')	,
('Nauagio', 	'I07', 	'Low'	,'Center'	,'No')	,
('Nauagio', 	'I08', 	'Low'	,'Center'	,'No')	,
('Nauagio', 	'I09', 	'Low'	,'Center'	,'Yes')	,
('Nauagio', 	'I10', 	'Low'	,'Left'	,'Yes')	,
('Nauagio', 	'I11', 	'Low'	,'Left'	,'No')	,
('Nauagio', 	'I12', 	'Low'	,'Left'	,'No')	,
('Nauagio', 	'J01', 	'Low'	,'Right'	,'No')	,
('Nauagio', 	'J02', 	'Low'	,'Right'	,'No')	,
('Nauagio', 	'J03', 	'Low'	,'Right'	,'Yes')	,
('Nauagio', 	'J04', 	'Low'	,'Center'	,'Yes')	,
('Nauagio', 	'J05', 	'Low'	,'Center'	,'No')	,
('Nauagio', 	'J06', 	'Low'	,'Center'	,'No')	,
('Nauagio', 	'J07', 	'Low'	,'Center'	,'No')	,
('Nauagio', 	'J08', 	'Low'	,'Center'	,'No')	,
('Nauagio', 	'J09', 	'Low'	,'Center'	,'Yes')	,
('Nauagio', 	'J10', 	'Low'	,'Left'	,'Yes')	,
('Nauagio', 	'J11', 	'Low'	,'Left'	,'No')	,
('Nauagio', 	'J12', 	'Low'	,'Left'	,'No')	,
('Nauagio', 	'K01', 	'Low'	,'Right'	,'No')	,
('Nauagio', 	'K02', 	'Low'	,'Right'	,'No')	,
('Nauagio', 	'K03', 	'Low'	,'Right'	,'Yes')	,
('Nauagio', 	'K04', 	'Low'	,'Center'	,'Yes')	,
('Nauagio', 	'K05', 	'Low'	,'Center'	,'No')	,
('Nauagio', 	'K06', 	'Low'	,'Center'	,'No')	,
('Nauagio', 	'K07', 	'Low'	,'Center'	,'No')	,
('Nauagio', 	'K08', 	'Low'	,'Center'	,'No')	,
('Nauagio', 	'K09', 	'Low'	,'Center'	,'Yes')	,
('Nauagio', 	'K10', 	'Low'	,'Left'	,'Yes')	,
('Nauagio', 	'K11', 	'Low'	,'Left'	,'No')	,
('Nauagio', 	'K12', 	'Low'	,'Left'	,'No')	,
('Atsitsa', 	'A01', 	'High'	,'Right'	,'No')	,
('Atsitsa', 	'A02', 	'High'	,'Right'	,'No')	,
('Atsitsa', 	'A03', 	'High'	,'Right'	,'Yes')	,
('Atsitsa', 	'A04', 	'High'	,'Center'	,'Yes')	,
('Atsitsa', 	'A05', 	'High'	,'Center'	,'No')	,
('Atsitsa', 	'A06', 	'High'	,'Center'	,'No')	,
('Atsitsa', 	'A07', 	'High'	,'Center'	,'No')	,
('Atsitsa', 	'A08', 	'High'	,'Center'	,'No')	,
('Atsitsa', 	'A09', 	'High'	,'Center'	,'Yes')	,
('Atsitsa', 	'A10', 	'High'	,'Left'	,'Yes')	,
('Atsitsa', 	'A11', 	'High'	,'Left'	,'No')	,
('Atsitsa', 	'A12', 	'High'	,'Left'	,'No')	,
('Atsitsa', 	'B01', 	'High'	,'Right'	,'No')	,
('Atsitsa', 	'B02', 	'High'	,'Right'	,'No')	,
('Atsitsa', 	'B03', 	'High'	,'Right'	,'Yes')	,
('Atsitsa', 	'B04', 	'High'	,'Center'	,'Yes')	,
('Atsitsa', 	'B05', 	'High'	,'Center'	,'No')	,
('Atsitsa', 	'B06', 	'High'	,'Center'	,'No')	,
('Atsitsa', 	'B07', 	'High'	,'Center'	,'No')	,
('Atsitsa', 	'B08', 	'High'	,'Center'	,'No')	,
('Atsitsa', 	'B09', 	'High'	,'Center'	,'Yes')	,
('Atsitsa', 	'B10', 	'High'	,'Left'	,'Yes')	,
('Atsitsa', 	'B11', 	'High'	,'Left'	,'No')	,
('Atsitsa', 	'B12', 	'High'	,'Left'	,'No')	,
('Atsitsa', 	'C01', 	'High'	,'Right'	,'No')	,
('Atsitsa', 	'C02', 	'High'	,'Right'	,'No')	,
('Atsitsa', 	'C03', 	'High'	,'Right'	,'Yes')	,
('Atsitsa', 	'C04', 	'High'	,'Center'	,'Yes')	,
('Atsitsa', 	'C05', 	'High'	,'Center'	,'No')	,
('Atsitsa', 	'C06', 	'High'	,'Center'	,'No')	,
('Atsitsa', 	'C07', 	'High'	,'Center'	,'No')	,
('Atsitsa', 	'C08', 	'High'	,'Center'	,'No')	,
('Atsitsa', 	'C09', 	'High'	,'Center'	,'Yes')	,
('Atsitsa', 	'C10', 	'High'	,'Left'	,'Yes')	,
('Atsitsa', 	'C11', 	'High'	,'Left'	,'No')	,
('Atsitsa', 	'C12', 	'High'	,'Left'	,'No')	,
('Atsitsa', 	'D01', 	'Core'	,'Right'	,'No')	,
('Atsitsa', 	'D02', 	'Core'	,'Right'	,'No')	,
('Atsitsa', 	'D03', 	'Core'	,'Right'	,'Yes')	,
('Atsitsa', 	'D04', 	'Core'	,'Center'	,'Yes')	,
('Atsitsa', 	'D05', 	'Core'	,'Center'	,'No')	,
('Atsitsa', 	'D06', 	'Core'	,'Center'	,'No')	,
('Atsitsa', 	'D07', 	'Core'	,'Center'	,'No')	,
('Atsitsa', 	'D08', 	'Core'	,'Center'	,'No')	,
('Atsitsa', 	'D09', 	'Core'	,'Center'	,'Yes')	,
('Atsitsa', 	'D10', 	'Core'	,'Left'	,'Yes')	,
('Atsitsa', 	'D11', 	'Core'	,'Left'	,'No')	,
('Atsitsa', 	'D12', 	'Core'	,'Left'	,'No')	,
('Atsitsa', 	'E01', 	'Core'	,'Right'	,'No')	,
('Atsitsa', 	'E02', 	'Core'	,'Right'	,'No')	,
('Atsitsa', 	'E03', 	'Core'	,'Right'	,'Yes')	,
('Atsitsa', 	'E04', 	'Core'	,'Center'	,'Yes')	,
('Atsitsa', 	'E05', 	'Core'	,'Center'	,'No')	,
('Atsitsa', 	'E06', 	'Core'	,'Center'	,'No')	,
('Atsitsa', 	'E07', 	'Core'	,'Center'	,'No')	,
('Atsitsa', 	'E08', 	'Core'	,'Center'	,'No')	,
('Atsitsa', 	'E09', 	'Core'	,'Center'	,'Yes')	,
('Atsitsa', 	'E10', 	'Core'	,'Left'	,'Yes')	,
('Atsitsa', 	'E11', 	'Core'	,'Left'	,'No')	,
('Atsitsa', 	'E12', 	'Core'	,'Left'	,'No')	,
('Atsitsa', 	'F01', 	'Core'	,'Right'	,'No')	,
('Atsitsa', 	'F02', 	'Core'	,'Right'	,'No')	,
('Atsitsa', 	'F03', 	'Core'	,'Right'	,'Yes')	,
('Atsitsa', 	'F04', 	'Core'	,'Center'	,'Yes')	,
('Atsitsa', 	'F05', 	'Core'	,'Center'	,'No')	,
('Atsitsa', 	'F06', 	'Core'	,'Center'	,'No')	,
('Atsitsa', 	'F07', 	'Core'	,'Center'	,'No')	,
('Atsitsa', 	'F08', 	'Core'	,'Center'	,'No')	,
('Atsitsa', 	'F09', 	'Core'	,'Center'	,'Yes')	,
('Atsitsa', 	'F10', 	'Core'	,'Left'	,'Yes')	,
('Atsitsa', 	'F11', 	'Core'	,'Left'	,'No')	,
('Atsitsa', 	'F12', 	'Core'	,'Left'	,'No')	,
('Atsitsa', 	'G01', 	'Core'	,'Right'	,'No')	,
('Atsitsa', 	'G02', 	'Core'	,'Right'	,'No')	,
('Atsitsa', 	'G03', 	'Core'	,'Right'	,'Yes')	,
('Atsitsa', 	'G04', 	'Core'	,'Center'	,'Yes')	,
('Atsitsa', 	'G05', 	'Core'	,'Center'	,'No')	,
('Atsitsa', 	'G06', 	'Core'	,'Center'	,'No')	,
('Atsitsa', 	'G07', 	'Core'	,'Center'	,'No')	,
('Atsitsa', 	'G08', 	'Core'	,'Center'	,'No')	,
('Atsitsa', 	'G09', 	'Core'	,'Center'	,'Yes')	,
('Atsitsa', 	'G10', 	'Core'	,'Left'	,'Yes')	,
('Atsitsa', 	'G11', 	'Core'	,'Left'	,'No')	,
('Atsitsa', 	'G12', 	'Core'	,'Left'	,'No')	,
('Atsitsa', 	'H01', 	'Core'	,'Right'	,'No')	,
('Atsitsa', 	'H02', 	'Core'	,'Right'	,'No')	,
('Atsitsa', 	'H03', 	'Core'	,'Right'	,'Yes')	,
('Atsitsa', 	'H04', 	'Core'	,'Center'	,'Yes')	,
('Atsitsa', 	'H05', 	'Core'	,'Center'	,'No')	,
('Atsitsa', 	'H06', 	'Core'	,'Center'	,'No')	,
('Atsitsa', 	'H07', 	'Core'	,'Center'	,'No')	,
('Atsitsa', 	'H08', 	'Core'	,'Center'	,'No')	,
('Atsitsa', 	'H09', 	'Core'	,'Center'	,'Yes')	,
('Atsitsa', 	'H10', 	'Core'	,'Left'	,'Yes')	,
('Atsitsa', 	'H11', 	'Core'	,'Left'	,'No')	,
('Atsitsa', 	'H12', 	'Core'	,'Left'	,'No')	,
('Atsitsa', 	'I01', 	'Low'	,'Right'	,'No')	,
('Atsitsa', 	'I02', 	'Low'	,'Right'	,'No')	,
('Atsitsa', 	'I03', 	'Low'	,'Right'	,'Yes')	,
('Atsitsa', 	'I04', 	'Low'	,'Center'	,'Yes')	,
('Atsitsa', 	'I05', 	'Low'	,'Center'	,'No')	,
('Atsitsa', 	'I06', 	'Low'	,'Center'	,'No')	,
('Atsitsa', 	'I07', 	'Low'	,'Center'	,'No')	,
('Atsitsa', 	'I08', 	'Low'	,'Center'	,'No')	,
('Atsitsa', 	'I09', 	'Low'	,'Center'	,'Yes')	,
('Atsitsa', 	'I10', 	'Low'	,'Left'	,'Yes')	,
('Atsitsa', 	'I11', 	'Low'	,'Left'	,'No')	,
('Atsitsa', 	'I12', 	'Low'	,'Left'	,'No')	,
('Atsitsa', 	'J01', 	'Low'	,'Right'	,'No')	,
('Atsitsa', 	'J02', 	'Low'	,'Right'	,'No')	,
('Atsitsa', 	'J03', 	'Low'	,'Right'	,'Yes')	,
('Atsitsa', 	'J04', 	'Low'	,'Center'	,'Yes')	,
('Atsitsa', 	'J05', 	'Low'	,'Center'	,'No')	,
('Atsitsa', 	'J06', 	'Low'	,'Center'	,'No')	,
('Atsitsa', 	'J07', 	'Low'	,'Center'	,'No')	,
('Atsitsa', 	'J08', 	'Low'	,'Center'	,'No')	,
('Atsitsa', 	'J09', 	'Low'	,'Center'	,'Yes')	,
('Atsitsa', 	'J10', 	'Low'	,'Left'	,'Yes')	,
('Atsitsa', 	'J11', 	'Low'	,'Left'	,'No')	,
('Atsitsa', 	'J12', 	'Low'	,'Left'	,'No')	,
('Atsitsa', 	'K01', 	'Low'	,'Right'	,'No')	,
('Atsitsa', 	'K02', 	'Low'	,'Right'	,'No')	,
('Atsitsa', 	'K03', 	'Low'	,'Right'	,'Yes')	,
('Atsitsa', 	'K04', 	'Low'	,'Center'	,'Yes')	,
('Atsitsa', 	'K05', 	'Low'	,'Center'	,'No')	,
('Atsitsa', 	'K06', 	'Low'	,'Center'	,'No')	,
('Atsitsa', 	'K07', 	'Low'	,'Center'	,'No')	,
('Atsitsa', 	'K08', 	'Low'	,'Center'	,'No')	,
('Atsitsa', 	'K09', 	'Low'	,'Center'	,'Yes')	,
('Atsitsa', 	'K10', 	'Low'	,'Left'	,'Yes')	,
('Atsitsa', 	'K11', 	'Low'	,'Left'	,'No')	,
('Atsitsa', 	'K12', 	'Low'	,'Left'	,'No')	,
('Fwkiada', 	'A01', 	'High'	,'Right'	,'No')	,
('Fwkiada', 	'A02', 	'High'	,'Right'	,'No')	,
('Fwkiada', 	'A03', 	'High'	,'Right'	,'Yes')	,
('Fwkiada', 	'A04', 	'High'	,'Center'	,'Yes')	,
('Fwkiada', 	'A05', 	'High'	,'Center'	,'No')	,
('Fwkiada', 	'A06', 	'High'	,'Center'	,'No')	,
('Fwkiada', 	'A07', 	'High'	,'Center'	,'No')	,
('Fwkiada', 	'A08', 	'High'	,'Center'	,'No')	,
('Fwkiada', 	'A09', 	'High'	,'Center'	,'Yes')	,
('Fwkiada', 	'A10', 	'High'	,'Left'	,'Yes')	,
('Fwkiada', 	'A11', 	'High'	,'Left'	,'No')	,
('Fwkiada', 	'A12', 	'High'	,'Left'	,'No')	,
('Fwkiada', 	'B01', 	'High'	,'Right'	,'No')	,
('Fwkiada', 	'B02', 	'High'	,'Right'	,'No')	,
('Fwkiada', 	'B03', 	'High'	,'Right'	,'Yes')	,
('Fwkiada', 	'B04', 	'High'	,'Center'	,'Yes')	,
('Fwkiada', 	'B05', 	'High'	,'Center'	,'No')	,
('Fwkiada', 	'B06', 	'High'	,'Center'	,'No')	,
('Fwkiada', 	'B07', 	'High'	,'Center'	,'No')	,
('Fwkiada', 	'B08', 	'High'	,'Center'	,'No')	,
('Fwkiada', 	'B09', 	'High'	,'Center'	,'Yes')	,
('Fwkiada', 	'B10', 	'High'	,'Left'	,'Yes')	,
('Fwkiada', 	'B11', 	'High'	,'Left'	,'No')	,
('Fwkiada', 	'B12', 	'High'	,'Left'	,'No')	,
('Fwkiada', 	'C01', 	'High'	,'Right'	,'No')	,
('Fwkiada', 	'C02', 	'High'	,'Right'	,'No')	,
('Fwkiada', 	'C03', 	'High'	,'Right'	,'Yes')	,
('Fwkiada', 	'C04', 	'High'	,'Center'	,'Yes')	,
('Fwkiada', 	'C05', 	'High'	,'Center'	,'No')	,
('Fwkiada', 	'C06', 	'High'	,'Center'	,'No')	,
('Fwkiada', 	'C07', 	'High'	,'Center'	,'No')	,
('Fwkiada', 	'C08', 	'High'	,'Center'	,'No')	,
('Fwkiada', 	'C09', 	'High'	,'Center'	,'Yes')	,
('Fwkiada', 	'C10', 	'High'	,'Left'	,'Yes')	,
('Fwkiada', 	'C11', 	'High'	,'Left'	,'No')	,
('Fwkiada', 	'C12', 	'High'	,'Left'	,'No')	,
('Fwkiada', 	'D01', 	'Core'	,'Right'	,'No')	,
('Fwkiada', 	'D02', 	'Core'	,'Right'	,'No')	,
('Fwkiada', 	'D03', 	'Core'	,'Right'	,'Yes')	,
('Fwkiada', 	'D04', 	'Core'	,'Center'	,'Yes')	,
('Fwkiada', 	'D05', 	'Core'	,'Center'	,'No')	,
('Fwkiada', 	'D06', 	'Core'	,'Center'	,'No')	,
('Fwkiada', 	'D07', 	'Core'	,'Center'	,'No')	,
('Fwkiada', 	'D08', 	'Core'	,'Center'	,'No')	,
('Fwkiada', 	'D09', 	'Core'	,'Center'	,'Yes')	,
('Fwkiada', 	'D10', 	'Core'	,'Left'	,'Yes')	,
('Fwkiada', 	'D11', 	'Core'	,'Left'	,'No')	,
('Fwkiada', 	'D12', 	'Core'	,'Left'	,'No')	,
('Fwkiada', 	'E01', 	'Core'	,'Right'	,'No')	,
('Fwkiada', 	'E02', 	'Core'	,'Right'	,'No')	,
('Fwkiada', 	'E03', 	'Core'	,'Right'	,'Yes')	,
('Fwkiada', 	'E04', 	'Core'	,'Center'	,'Yes')	,
('Fwkiada', 	'E05', 	'Core'	,'Center'	,'No')	,
('Fwkiada', 	'E06', 	'Core'	,'Center'	,'No')	,
('Fwkiada', 	'E07', 	'Core'	,'Center'	,'No')	,
('Fwkiada', 	'E08', 	'Core'	,'Center'	,'No')	,
('Fwkiada', 	'E09', 	'Core'	,'Center'	,'Yes')	,
('Fwkiada', 	'E10', 	'Core'	,'Left'	,'Yes')	,
('Fwkiada', 	'E11', 	'Core'	,'Left'	,'No')	,
('Fwkiada', 	'E12', 	'Core'	,'Left'	,'No')	,
('Fwkiada', 	'F01', 	'Core'	,'Right'	,'No')	,
('Fwkiada', 	'F02', 	'Core'	,'Right'	,'No')	,
('Fwkiada', 	'F03', 	'Core'	,'Right'	,'Yes')	,
('Fwkiada', 	'F04', 	'Core'	,'Center'	,'Yes')	,
('Fwkiada', 	'F05', 	'Core'	,'Center'	,'No')	,
('Fwkiada', 	'F06', 	'Core'	,'Center'	,'No')	,
('Fwkiada', 	'F07', 	'Core'	,'Center'	,'No')	,
('Fwkiada', 	'F08', 	'Core'	,'Center'	,'No')	,
('Fwkiada', 	'F09', 	'Core'	,'Center'	,'Yes')	,
('Fwkiada', 	'F10', 	'Core'	,'Left'	,'Yes')	,
('Fwkiada', 	'F11', 	'Core'	,'Left'	,'No')	,
('Fwkiada', 	'F12', 	'Core'	,'Left'	,'No')	,
('Fwkiada', 	'G01', 	'Core'	,'Right'	,'No')	,
('Fwkiada', 	'G02', 	'Core'	,'Right'	,'No')	,
('Fwkiada', 	'G03', 	'Core'	,'Right'	,'Yes')	,
('Fwkiada', 	'G04', 	'Core'	,'Center'	,'Yes')	,
('Fwkiada', 	'G05', 	'Core'	,'Center'	,'No')	,
('Fwkiada', 	'G06', 	'Core'	,'Center'	,'No')	,
('Fwkiada', 	'G07', 	'Core'	,'Center'	,'No')	,
('Fwkiada', 	'G08', 	'Core'	,'Center'	,'No')	,
('Fwkiada', 	'G09', 	'Core'	,'Center'	,'Yes')	,
('Fwkiada', 	'G10', 	'Core'	,'Left'	,'Yes')	,
('Fwkiada', 	'G11', 	'Core'	,'Left'	,'No')	,
('Fwkiada', 	'G12', 	'Core'	,'Left'	,'No')	,
('Fwkiada', 	'H01', 	'Core'	,'Right'	,'No')	,
('Fwkiada', 	'H02', 	'Core'	,'Right'	,'No')	,
('Fwkiada', 	'H03', 	'Core'	,'Right'	,'Yes')	,
('Fwkiada', 	'H04', 	'Core'	,'Center'	,'Yes')	,
('Fwkiada', 	'H05', 	'Core'	,'Center'	,'No')	,
('Fwkiada', 	'H06', 	'Core'	,'Center'	,'No')	,
('Fwkiada', 	'H07', 	'Core'	,'Center'	,'No')	,
('Fwkiada', 	'H08', 	'Core'	,'Center'	,'No')	,
('Fwkiada', 	'H09', 	'Core'	,'Center'	,'Yes')	,
('Fwkiada', 	'H10', 	'Core'	,'Left'	,'Yes')	,
('Fwkiada', 	'H11', 	'Core'	,'Left'	,'No')	,
('Fwkiada', 	'H12', 	'Core'	,'Left'	,'No')	,
('Fwkiada', 	'I01', 	'Low'	,'Right'	,'No')	,
('Fwkiada', 	'I02', 	'Low'	,'Right'	,'No')	,
('Fwkiada', 	'I03', 	'Low'	,'Right'	,'Yes')	,
('Fwkiada', 	'I04', 	'Low'	,'Center'	,'Yes')	,
('Fwkiada', 	'I05', 	'Low'	,'Center'	,'No')	,
('Fwkiada', 	'I06', 	'Low'	,'Center'	,'No')	,
('Fwkiada', 	'I07', 	'Low'	,'Center'	,'No')	,
('Fwkiada', 	'I08', 	'Low'	,'Center'	,'No')	,
('Fwkiada', 	'I09', 	'Low'	,'Center'	,'Yes')	,
('Fwkiada', 	'I10', 	'Low'	,'Left'	,'Yes')	,
('Fwkiada', 	'I11', 	'Low'	,'Left'	,'No')	,
('Fwkiada', 	'I12', 	'Low'	,'Left'	,'No')	,
('Fwkiada', 	'J01', 	'Low'	,'Right'	,'No')	,
('Fwkiada', 	'J02', 	'Low'	,'Right'	,'No')	,
('Fwkiada', 	'J03', 	'Low'	,'Right'	,'Yes')	,
('Fwkiada', 	'J04', 	'Low'	,'Center'	,'Yes')	,
('Fwkiada', 	'J05', 	'Low'	,'Center'	,'No')	,
('Fwkiada', 	'J06', 	'Low'	,'Center'	,'No')	,
('Fwkiada', 	'J07', 	'Low'	,'Center'	,'No')	,
('Fwkiada', 	'J08', 	'Low'	,'Center'	,'No')	,
('Fwkiada', 	'J09', 	'Low'	,'Center'	,'Yes')	,
('Fwkiada', 	'J10', 	'Low'	,'Left'	,'Yes')	,
('Fwkiada', 	'J11', 	'Low'	,'Left'	,'No')	,
('Fwkiada', 	'J12', 	'Low'	,'Left'	,'No')	,
('Fwkiada', 	'K01', 	'Low'	,'Right'	,'No')	,
('Fwkiada', 	'K02', 	'Low'	,'Right'	,'No')	,
('Fwkiada', 	'K03', 	'Low'	,'Right'	,'Yes')	,
('Fwkiada', 	'K04', 	'Low'	,'Center'	,'Yes')	,
('Fwkiada', 	'K05', 	'Low'	,'Center'	,'No')	,
('Fwkiada', 	'K06', 	'Low'	,'Center'	,'No')	,
('Fwkiada', 	'K07', 	'Low'	,'Center'	,'No')	,
('Fwkiada', 	'K08', 	'Low'	,'Center'	,'No')	,
('Fwkiada', 	'K09', 	'Low'	,'Center'	,'Yes')	,
('Fwkiada', 	'K10', 	'Low'	,'Left'	,'Yes')	,
('Fwkiada', 	'K11', 	'Low'	,'Left'	,'No')	,
('Fwkiada', 	'K12', 	'Low'	,'Left'	,'No')	;


INSERT INTO `cinema`.`Staff` (`staff_name`, `staff_surname`, `staff_phone`, `staff_adress`, `staff_bankacc`, `staff_bio`, `staff_exp`, `staff_recdt`)  VALUES								
('Petros'	,'Trepeklhs'	,6939710730	,'Pantanasshs 2'	,'GR1234123412341234123412031'	,'I was born and raised in Patra. I like drama movies'	,'I had worked in 3 cinemas before.'	,'2010-10-10'	),
('Panagiwta'	,'Koutoula'	,6939710731	,'Ermou 12'	,'GR1234123412341234123412012'	,'I was born and raised in Trikala. I like thriller movies'	,'I had worked only as a clenear before.'	,'2010-10-11'	),
('Maria'	,'Voulgarh'	,6939710732	,'Zaimh 8'	,'GR1234123412341234123412032'	,'I was born and raised in Thessalonikh. I like comedy movies.'	,'I had worked only in a bar before.'	,'2010-10-12'	),
('Pelagia'	,'Ashmenou'	,6939710733	,'Filopoihmenos 45'	,'GR1234123412341234123412033'	,'I was born and raised in Athens. I like horror movies.'	,'I had worked in 2 cinemas before.'	,'2011-01-09'	),
('Savas'	,'Mpoukouras'	,6939710734	,'Karaiskakh 82'	,'GR1234123412341234123412034'	,'I was born and raised in Trikala. I dont like movies. Why I work here?'	,'I had worked in a playground before.'	,'2011-01-20'	),
('Triantafulos'	,'Triantafullou'	,6939710735	,'Poukevil 19-21'	,'GR1234123412341234123412035'	,'I was born and raised in Kavala. I like SciFi movies.'	,'I havent worked.Its my first job'	,'2011-01-23'	),
('Spyros'	,'Vathus'	,6939710736	,'Aratou 7'	,'GR1234123412341234123412036'	,'I was born and raised in Purgos. I like adventure movies.'	,'I worked to hard before.'	,'2014-05-01'	),
('Anastasia'	,'Mendrinou'	,6939710737	,'Kolokotronh 85'	,'GR1234123412341234123412037'	,'I was born and raised in Chalkis. I like documentaries.'	,'I had done 4 jobs before.'	,'2014-07-27'	),
('Elpida'	,'Manta'	,6939710738	,'Gerokostopoulou 21'	,'GR1234123434231234123412038'	,'I was born and raised in Chania. I like action movies'	,'I had done 9 jobs before.'	,'2014-09-28'	),
('Sofoklhs'	,'Mouzelhs'	,6939710739	,'Panepisthmiou 123'	,'GR1234123412377934123412039'	,'I was born and raised in Kalamata. I like family movies.'	,'I had done 2 jobs before.'	,'2015-04-22'	),
('Anastasia'	,'Giannikou'	,6939710740	,'Othonos Amalias 143'	,'GR1234123432434123423412021'	,'I was born and raised in Korinthos. I like all movies.'	,'I worked in a hospital before.'	,'2010-04-14'	),
('Dimitris'	,'Makrhs'	,6939710741	,'Papaflesa 12'	,'GR1234123412341273446212111'	,'I was born and raised in Sparth. I like super heroe movies.'	,'I worked in airline trafic in the past.'	,'2014-04-08'	),
('Zhshs'	,'Makrhs'	,6939710741	,'Agiou Georgiou 55'	,'GR1234123412341234126452111'	,'I was born and raised in Spata. I like super action movies.'	,'I worked in airline trafic in the past.'	,'2012-11-13'	),
('Kwstas'	,'Psaltakhs'	,6939710741	,'Evoias 13'	,'GR1234123412341235423412111'	,'I was born and raised in Sparth. I like super adventure movies.'	,'I worked in airline trafic in the past.'	,'2013-12-11'	),
('Stamaths'	,'Georgiou'	,6939710741	,'Papaflesa 28'	,'GR1234123412341234143412111'	,'I was born and raised in Oksulithos. I like super scifi movies.'	,'I worked in a supermarket in the past'	,'2011-12-13'	),
('Alekshs'	,'Dhmhtriou'	,6939710741	,'Papaflesa 29'	,'GR1234123412521234123412111'	,'I was born and raised in Xalkoutsi. I like super horror movies.'	,'I worked as chef in the past.'	,'2015-08-28'	),
('Dhmos'	,'Gkavogianhs'	,6939710741	,'Aratou 12'	,'GR1234123122341234123412111'	,'I was born and raised in Dhlesi. I like super drama movies.'	,'I worked as an excecutioner in the past.'	,'2015-01-01'	),
('Katerina'	,'Stratikh'	,6939710741	,'Kanakarh 90'	,'GR1234123412341234123412111'	,'I was born and raised in Vathia. I like comedy movies.'	,'I worked as an artist in the past.'	,'2010-08-09'	),
('Xara'	,'Triantou'	,6939710741	,'Papadhmhtriou 12'	,'GR1234123452441234123412111'	,'I was born and raised in Kumh. I like action movies.'	,'I worked as a pilot in the past.'	,'2015-10-10'	),
('Loukia'	,'Mouzelh'	,6939710741	,'Mougalou 8'	,'GR1234123412341232343412611'	,'I was born and raised in Aliveri. I like comedy movies.'	,'I worked in control panels(you know..ctrl-alt-del) in the past.'	,'2012-04-05'	);
/*
INSERT INTO `cinema`.`Salary`(`salary_staff_ID` ,`salary_month`, `salary_year`, `salary_money`) VALUES					
(	1	,'January',	'2015',	'800,00'	),
(	2	,'January',	'2015',	'600,00'	),
(	3	,'January',	'2015',	'800,00'	),
(	4	,'January',	'2015',	'784.00'	),
(	5	,'January',	'2015',	'800,00'	),
(	6	,'January',	'2015',	'800,00'	),
(	7	,'January',	'2015',	'800,00'	),
(	8	,'January',	'2015',	'784.00'	),
(	9	,'January',	'2015',	'800,00'	),
(	10	,'January',	'2015',	'800,00'	),
(	11	,'January',	'2015',	'784.00'	),
(	12	,'January',	'2015',	'800,00'	),
(	13	,'January',	'2015',	'800,00'	),
(	14	,'January',	'2015',	'784.00'	),
(	15	,'January',	'2015',	'800,00'	),
(	16	,'January',	'2015',	'800,00'	),
(	17	,'January',	'2015',	'800,00'	),
(	18	,'January',	'2015',	'784.00'	),
(	19	,'January',	'2015',	'800,00'	),
(	20	,'January',	'2015',	'800,00'	),
(	1	,'February',	'2015',	'800,00'	),
(	2	,'February',	'2015',	'600,00'	),
(	3	,'February',	'2015',	'800,00'	),
(	4	,'February',	'2015',	'784.00'	),
(	5	,'February',	'2015',	'800,00'	),
(	6	,'February',	'2015',	'800,00'	),
(	7	,'February',	'2015',	'800,00'	),
(	8	,'February',	'2015',	'784.00'	),
(	9	,'February',	'2015',	'800,00'	),
(	10	,'February',	'2015',	'800,00'	),
(	11	,'February',	'2015',	'784.00'	),
(	12	,'February',	'2015',	'800,00'	),
(	13	,'February',	'2015',	'800,00'	),
(	14	,'February',	'2015',	'784.00'	),
(	15	,'February',	'2015',	'800,00'	),
(	16	,'February',	'2015',	'800,00'	),
(	17	,'February',	'2015',	'800,00'	),
(	18	,'February',	'2015',	'784.00'	),
(	19	,'February',	'2015',	'800,00'	),
(	20	,'February',	'2015',	'800,00'	),
(	1	,'March',	'2015',	'800,00'	),
(	2	,'March',	'2015',	'600,00'	),
(	3	,'March',	'2015',	'800,00'	),
(	4	,'March',	'2015',	'784.00'	),
(	5	,'March',	'2015',	'800,00'	),
(	6	,'March',	'2015',	'800,00'	),
(	7	,'March',	'2015',	'800,00'	),
(	8	,'March',	'2015',	'784.00'	),
(	9	,'March',	'2015',	'800,00'	),
(	10	,'March',	'2015',	'800,00'	),
(	11	,'March',	'2015',	'784.00'	);
*/
INSERT INTO `cinema`.`SuperVisor` (`supervisor_staff_ID` , `supervisor_days` , `supervisor_shift` ,`supervisor_notes`, `supervisor_date`) VALUES						
(	1	, 'Monday'	,'Morning'	,'Nothing to mention.'	,'2016-02-16'	),
(	2	, 'Monday'	,'Afternoon'	,'Nothing to mention.'	,'2016-02-16'	),
(	1	,'Tuesday'	,'Morning'	,'Noted lack of communication among the cleaners.'	,'2016-02-17'	),
(	2	,'Tuesday'	,'Afternoon'	,'One of the ticket sellers was smoking during work-time in front of the customers.'	,'2016-02-17'	);
						
INSERT INTO `cinema`.`StageOrders` (`stageorder_staff_ID` , `stageorder_days` , `stageorder_shift` , `stageorder_date` , `stageorder_shift_time`) VALUES						
(	1	, 'Monday'	,'Morning'	,'2016-02-16', '04:00:00'	),	
(	2	, 'Monday'	,'Morning'	,'2016-02-16', '04:00:00'	),	
(	6	, 'Monday'	,'Morning'	,'2016-02-16', '04:00:00'	),	
(	8	, 'Monday'	,'Morning'	,'2016-02-16', '04:00:00'	),	
(	13	, 'Monday'	,'Afternoon'	,'2016-02-16', '14:00:00'		),	
(	14	, 'Monday'	,'Afternoon'	,'2016-02-16', '14:00:00'		),	
(	16	, 'Monday'	,'Afternoon'	,'2016-02-16', '14:00:00'		),	
(	18	, 'Monday'	,'Afternoon'	,'2016-02-16', '14:00:00'		),	
(	3	,'Tuesday'	,'Morning'	,'2016-02-17', '04:00:00'	),	
(	4	,'Tuesday'	,'Morning'	,'2016-02-17', '04:00:00'	),	
(	6	,'Tuesday'	,'Morning'	,'2016-02-17', '04:00:00'	),	
(	8	,'Tuesday'	,'Morning'	,'2016-02-17', '04:00:00'	),	
(	13	,'Tuesday'	,'Afternoon'	,'2016-02-17', '14:00:00'		),	
(	14	,'Tuesday'	,'Afternoon'	,'2016-02-17', '14:00:00'		),	
(	16	,'Tuesday'	,'Afternoon'	,'2016-02-17', '14:00:00'		),	
(	18	,'Tuesday'	,'Afternoon'	,'2016-02-17', '14:00:00'		);	
						
INSERT INTO `cinema`.`TicketSeller` (`ticketseller_staff_ID` , `ticketseller_days` , `ticketseller_shift` ,`ticketseller_ticketssold` , `ticketseller_date` , `ticketseller_shift_time`) VALUES						
(	2	, 'Monday'	,'Morning'	,'0'	,'2016-02-16' , '04:00:00'),
(	7	, 'Monday'	,'Morning'	,'0'	,'2016-02-16' , '04:00:00'	),
(	10	, 'Monday'	,'Morning'	,'0'	,'2016-02-16' , '04:00:00'	),
(	12	, 'Monday'	,'Afternoon'	,'0'	,'2016-02-16', '14:00:00'		),
(	17	, 'Monday'	,'Afternoon'	,'0'	,'2016-02-16', '14:00:00'		),
(	20	, 'Monday'	,'Afternoon'	,'0'	,'2016-02-16', '14:00:00'		),
(	2	,'Tuesday'	,'Morning'	,'0'	,'2016-02-17' , '04:00:00'	),
(	7	,'Tuesday'	,'Morning'	,'0'	,'2016-02-17' , '04:00:00'	),
(	10	,'Tuesday'	,'Morning'	,'0'	,'2016-02-17' , '04:00:00'	),
(	12	,'Tuesday'	,'Afternoon'	,'0'	,'2016-02-17', '14:00:00'		),
(	17	,'Tuesday'	,'Afternoon'	,'0'	,'2016-02-17', '14:00:00'		),
(	20	,'Tuesday'	,'Afternoon'	,'0'	,'2016-02-17', '14:00:00'		);
						
INSERT INTO `cinema`.`Cleaner` (`cleaner_staff_ID` , `cleaner_days` , `cleaner_shift` ,`cleaner_date` , `cleaner_shift_time`) VALUES						
(	5	, 'Monday'	,'Morning'	,'2016-02-16' , '04:00:00'),	
(	9	, 'Monday'	,'Morning'	,'2016-02-16' , '04:00:00'	),	
(	15	, 'Monday'	,'Afternoon'	,'2016-02-16' , '14:00:00'	),	
(	19	, 'Monday'	,'Afternoon'	,'2016-02-16' , '14:00:00'	),	
(	5	,'Tuesday'	,'Morning'	,'2016-02-17' , '04:00:00'	),	
(	9	,'Tuesday'	,'Morning'	,'2016-02-17' , '04:00:00'	),	
(	15	,'Tuesday'	,'Afternoon'	,'2016-02-17' , '14:00:00'	),	
(	19	,'Tuesday'	,'Afternoon'	,'2016-02-17' , '14:00:00'	);

INSERT INTO TimeTable (timetable_movie_ID, timetable_date, timetable_starttime, timetable_endtime, 
timetable_movietype, timetable_stage)	Values								
(	15	, '2016-02-11',	'19:30:00'	,'21:30:00'	,	'2D'	,	'Anemoesa'	),
(	5	, '2016-02-12',	'20:30:00'	,'22:30:00'	,	'2D'	,	'Atsitsa'	),
(	18	, '2016-02-13',	'21:15:00'	,'23:15:00'	,	'2D'	,	'Nauagio'	),
(	14	, '2016-02-14',	'21:45:00'	,'23:45:00'	,	'3D'	,	'Fwkiada'	),
(	21	, '2016-02-15',	'21:20:00'	,'23:20:00'	,	'3D'	,	'Agalipa'	),
(	1	, '2016-02-16',	'20:30:00'	,'22:30:00'	,	'2D'	,	'Anemoesa'	),
(	2	, '2016-02-16',	'23:30:00'	,'01:30:00'	,	'2D'	,	'Anemoesa'	),
(	20	, '2016-02-17',	'22:00:00'	,'24:00:00'	,	'2D'	,	'Nauagio'	),
(	8	, '2016-02-18',	'23:30:00'	,'00:30:00'	,	'3D'	,	'Agalipa'	),
(	4	, '2016-02-19',	'19:30:00'	,'21:30:00'	,	'2D'	,	'Atsitsa'	),
(	18	, '2016-02-20',	'21:15:00'	,'23:15:00'	,	'3D'	,	'Fwkiada'	),
(	7	, '2016-02-21',	'21:45:00'	,'23:45:00'	,	'3D'	,	'Agalipa'	),
(	19	, '2016-02-22',	'19:30:00'	,'21:30:00'	,	'3D'	,	'Fwkiada'	),
(	20	, '2016-02-22',	'23:00:00'	,'01:30:00'	,	'3D'	,	'Agalipa'	),
(	13	, '2016-02-23',	'18:00:00'	,'22:00:00'	,	'2D'	,	'Anemoesa'	),
(	4	, '2016-02-24',	'19:30:00'	,'21:30:00'	,	'2D'	,	'Atsitsa'	);

INSERT INTO `cinema`.`Tickets` (`ticket_customer_tabID`,	
`ticket_movie_ID`, `ticket_seat_number`, `ticket_starttime` ,`ticket_date` ) VALUES					
(	6	,15	,	'A01', 	'19:30:00'		,'2016-02-11')	,
(	7	,15	,	'A02', 	'19:30:00'		,'2016-02-11')	,
(	8	,15	,	'A03', 	'19:30:00'		,'2016-02-11')	,
(	9	,15	,	'A04', 	'19:30:00'		,'2016-02-11')	,
(	10	,15	,	'A05', 	'19:30:00'		,'2016-02-11')	,
(	11	,15	,	'A06', 	'19:30:00'		,'2016-02-11')	,
(	12	,15	,	'A07', 	'19:30:00'		,'2016-02-11')	,
(	13	,15	,	'A08', 	'19:30:00'		,'2016-02-11')	,
(	14	,15	,	'A09', 	'19:30:00'		,'2016-02-11')	,
(	15	,15	,	'A10', 	'19:30:00'		,'2016-02-11')	,
(	16	,15	,	'A11', 	'19:30:00'		,'2016-02-11')	,
(	17	,15	,	'A12', 	'19:30:00'		,'2016-02-11')	,
(	18	,15	,	'B01', 	'19:30:00'		,'2016-02-11')	,
(	19	,15	,	'B02', 	'19:30:00'		,'2016-02-11')	,
(	20	,15	,	'B03', 	'19:30:00'		,'2016-02-11')	,
(	21	,15	,	'B04', 	'19:30:00'		,'2016-02-11')	,
(	22	,15	,	'B05', 	'19:30:00'		,'2016-02-11')	,
(	23	,15	,	'B06', 	'19:30:00'		,'2016-02-11')	,
(	24	,15	,	'B07', 	'19:30:00'		,'2016-02-11')	,
(	25	,15	,	'B08', 	'19:30:00'		,'2016-02-11')	,
(	26	,15	,	'B09', 	'19:30:00'		,'2016-02-11')	,
(	27	,15	,	'B10', 	'19:30:00'		,'2016-02-11')	,
(	28	,15	,	'B11', 	'19:30:00'		,'2016-02-11')	,
(	29	,15	,	'B12', 	'19:30:00'		,'2016-02-11')	,
(	30	,15	,	'C01', 	'19:30:00'		,'2016-02-11')	,
(	31	,15	,	'C02', 	'19:30:00'		,'2016-02-11')	,
(	32	,15	,	'C03', 	'19:30:00'		,'2016-02-11')	,
(	33	,15	,	'C04', 	'19:30:00'		,'2016-02-11')	,
(	34	,15	,	'C05', 	'19:30:00'		,'2016-02-11')	,
(	35	,15	,	'C06', 	'19:30:00'		,'2016-02-11')	,
(	36	,15	,	'C07', 	'19:30:00'		,'2016-02-11')	,
(	37	,15	,	'C08', 	'19:30:00'		,'2016-02-11')	,
(	38	,15	,	'C09', 	'19:30:00'		,'2016-02-11')	,
(	39	,15	,	'C10', 	'19:30:00'		,'2016-02-11')	,
(	40	,15	,	'C11', 	'19:30:00'		,'2016-02-11')	,
(	41	,15	,	'C12', 	'19:30:00'		,'2016-02-11')	,
(	42	,15	,	'D01', 	'19:30:00'		,'2016-02-11')	,
(	43	,15	,	'D02', 	'19:30:00'		,'2016-02-11')	,
(	44	,15	,	'D03', 	'19:30:00'		,'2016-02-11')	,
(	45	,15	,	'D04', 	'19:30:00'		,'2016-02-11')	,
(	46	,15	,	'D05', 	'19:30:00'		,'2016-02-11')	,
(	3	,5	,	'A08', 	'20:30:00'		,'2016-02-12')	,
(	4	,5	,	'A09', 	'20:30:00'		,'2016-02-12')	,
(	5	,5	,	'A10', 	'20:30:00'		,'2016-02-12')	,
(	6	,5	,	'A11', 	'20:30:00'		,'2016-02-12')	,
(	7	,5	,	'A12', 	'20:30:00'		,'2016-02-12')	,
(	8	,5	,	'B01', 	'20:30:00'		,'2016-02-12')	,
(	24	,5	,	'B02', 	'20:30:00'		,'2016-02-12')	,
(	25	,5	,	'B03', 	'20:30:00'		,'2016-02-12')	,
(	26	,5	,	'B04', 	'20:30:00'		,'2016-02-12')	,
(	27	,5	,	'B05', 	'20:30:00'		,'2016-02-12')	,
(	28	,5	,	'B06', 	'20:30:00'		,'2016-02-12')	,
(	29	,5	,	'B07', 	'20:30:00'		,'2016-02-12')	,
(	30	,5	,	'B08', 	'20:30:00'		,'2016-02-12')	,
(	31	,5	,	'B09', 	'20:30:00'		,'2016-02-12')	,
(	32	,5	,	'B10', 	'20:30:00'		,'2016-02-12')	,
(	33	,5	,	'B11', 	'20:30:00'		,'2016-02-12')	,
(	34	,5	,	'B12', 	'20:30:00'		,'2016-02-12')	,
(	35	,5	,	'C01', 	'20:30:00'		,'2016-02-12')	,
(	36	,5	,	'C02', 	'20:30:00'		,'2016-02-12')	,
(	37	,5	,	'C03', 	'20:30:00'		,'2016-02-12')	,
(	1	,18	,	'A04', 	'21:15:00'		,'2016-02-13')	,
(	2	,18	,	'A05', 	'21:15:00'		,'2016-02-13')	,
(	3	,18	,	'A06', 	'21:15:00'		,'2016-02-13')	,
(	4	,18	,	'A07', 	'21:15:00'		,'2016-02-13')	,
(	5	,18	,	'A08', 	'21:15:00'		,'2016-02-13')	,
(	6	,18	,	'A09', 	'21:15:00'		,'2016-02-13')	,
(	7	,18	,	'A10', 	'21:15:00'		,'2016-02-13')	,
(	8	,18	,	'A11', 	'21:15:00'		,'2016-02-13')	,
(	9	,18	,	'A12', 	'21:15:00'		,'2016-02-13')	,
(	10	,18	,	'B01', 	'21:15:00'		,'2016-02-13')	,
(	11	,18	,	'B02', 	'21:15:00'		,'2016-02-13')	,
(	12	,18	,	'B03', 	'21:15:00'		,'2016-02-13')	,
(	13	,18	,	'B04', 	'21:15:00'		,'2016-02-13')	,
(	14	,18	,	'B05', 	'21:15:00'		,'2016-02-13')	,
(	15	,18	,	'B06', 	'21:15:00'		,'2016-02-13')	,
(	16	,18	,	'B07', 	'21:15:00'		,'2016-02-13')	,
(	17	,18	,	'B08', 	'21:15:00'		,'2016-02-13')	,
(	18	,18	,	'B09', 	'21:15:00'		,'2016-02-13')	,
(	19	,18	,	'B10', 	'21:15:00'		,'2016-02-13')	,
(	20	,18	,	'B11', 	'21:15:00'		,'2016-02-13')	,
(	21	,18	,	'B12', 	'21:15:00'		,'2016-02-13')	,
(	22	,18	,	'C01', 	'21:15:00'		,'2016-02-13')	,
(	23	,18	,	'C02', 	'21:15:00'		,'2016-02-13')	,
(	24	,18	,	'C03', 	'21:15:00'		,'2016-02-13')	,
(	25	,18	,	'C04', 	'21:15:00'		,'2016-02-13')	,
(	26	,18	,	'C05', 	'21:15:00'		,'2016-02-13')	,
(	27	,18	,	'C06', 	'21:15:00'		,'2016-02-13')	,
(	28	,18	,	'C07', 	'21:15:00'		,'2016-02-13')	,
(	29	,18	,	'C08', 	'21:15:00'		,'2016-02-13')	,
(	30	,18	,	'C09', 	'21:15:00'		,'2016-02-13')	,
(	31	,18	,	'C10', 	'21:15:00'		,'2016-02-13')	,
(	11	,14	,	'A04', 	'21:45:00'		,'2016-02-14')	,
(	12	,14	,	'A05', 	'21:45:00'		,'2016-02-14')	,
(	13	,14	,	'A06', 	'21:45:00'		,'2016-02-14')	,
(	14	,14	,	'A07', 	'21:45:00'		,'2016-02-14')	,
(	15	,14	,	'A08', 	'21:45:00'		,'2016-02-14')	,
(	16	,14	,	'A09', 	'21:45:00'		,'2016-02-14')	,
(	17	,14	,	'A10', 	'21:45:00'		,'2016-02-14')	,
(	18	,14	,	'A11', 	'21:45:00'		,'2016-02-14')	,
(	19	,14	,	'A12', 	'21:45:00'		,'2016-02-14')	,
(	20	,14	,	'B01', 	'21:45:00'		,'2016-02-14')	,
(	21	,14	,	'B02', 	'21:45:00'		,'2016-02-14')	,
(	22	,14	,	'B03', 	'21:45:00'		,'2016-02-14')	,
(	23	,14	,	'B04', 	'21:45:00'		,'2016-02-14')	,
(	24	,14	,	'B05', 	'21:45:00'		,'2016-02-14')	,
(	25	,14	,	'B06', 	'21:45:00'		,'2016-02-14')	,
(	26	,14	,	'B07', 	'21:45:00'		,'2016-02-14')	,
(	27	,14	,	'B08', 	'21:45:00'		,'2016-02-14')	,
(	28	,14	,	'B09', 	'21:45:00'		,'2016-02-14')	,
(	29	,14	,	'B10', 	'21:45:00'		,'2016-02-14')	,
(	30	,14	,	'B11', 	'21:45:00'		,'2016-02-14')	,
(	31	,14	,	'B12', 	'21:45:00'		,'2016-02-14')	,
(	32	,14	,	'C01', 	'21:45:00'		,'2016-02-14')	,
(	33	,14	,	'C02', 	'21:45:00'		,'2016-02-14')	,
(	34	,14	,	'C03', 	'21:45:00'		,'2016-02-14')	,
(	35	,14	,	'C04', 	'21:45:00'		,'2016-02-14')	,
(	36	,14	,	'C05', 	'21:45:00'		,'2016-02-14')	,
(	37	,14	,	'C06', 	'21:45:00'		,'2016-02-14')	,
(	38	,14	,	'C07', 	'21:45:00'		,'2016-02-14')	,
(	39	,14	,	'C08', 	'21:45:00'		,'2016-02-14')	,
(	40	,14	,	'C09', 	'21:45:00'		,'2016-02-14')	,
(	41	,14	,	'C10', 	'21:45:00'		,'2016-02-14')	,
(	42	,14	,	'C11', 	'21:45:00'		,'2016-02-14')	,
(	43	,14	,	'C12', 	'21:45:00'		,'2016-02-14')	,
(	23	,21	,	'B08', 	'21:20:00'		,'2016-02-15')	,
(	24	,21	,	'B09', 	'21:20:00'		,'2016-02-15')	,
(	25	,21	,	'B10', 	'21:20:00'		,'2016-02-15')	,
(	26	,21	,	'B11', 	'21:20:00'		,'2016-02-15')	,
(	27	,21	,	'B12', 	'21:20:00'		,'2016-02-15')	,
(	28	,21	,	'C01', 	'21:20:00'		,'2016-02-15')	,
(	29	,21	,	'C02', 	'21:20:00'		,'2016-02-15')	,
(	30	,21	,	'C03', 	'21:20:00'		,'2016-02-15')	,
(	31	,21	,	'C04', 	'21:20:00'		,'2016-02-15')	,
(	32	,21	,	'C05', 	'21:20:00'		,'2016-02-15')	,
(	33	,21	,	'C06', 	'21:20:00'		,'2016-02-15')	,
(	34	,21	,	'C07', 	'21:20:00'		,'2016-02-15')	,
(	35	,21	,	'C08', 	'21:20:00'		,'2016-02-15')	,
(	36	,21	,	'C09', 	'21:20:00'		,'2016-02-15')	,
(	37	,21	,	'C10', 	'21:20:00'		,'2016-02-15')	,
(	38	,21	,	'C11', 	'21:20:00'		,'2016-02-15')	,
(	39	,21	,	'C12', 	'21:20:00'		,'2016-02-15')	,
(	1	,1	,	'A01', 	'20:30:00'		,'2016-02-16')	,
(	2	,1	,	'A02', 	'20:30:00'		,'2016-02-16')	,
(	3	,1	,	'A03', 	'20:30:00'		,'2016-02-16')	,
(	4	,1	,	'A04', 	'20:30:00'		,'2016-02-16')	,
(	5	,1	,	'A05', 	'20:30:00'		,'2016-02-16')	,
(	6	,1	,	'A06', 	'20:30:00'		,'2016-02-16')	,
(	7	,1	,	'A07', 	'20:30:00'		,'2016-02-16')	,
(	8	,1	,	'A08', 	'20:30:00'		,'2016-02-16')	,
(	9	,1	,	'A09', 	'20:30:00'		,'2016-02-16')	,
(	10	,1	,	'A10', 	'20:30:00'		,'2016-02-16')	,
(	11	,1	,	'A11', 	'20:30:00'		,'2016-02-16')	,
(	12	,1	,	'A12', 	'20:30:00'		,'2016-02-16')	,
(	13	,1	,	'B01', 	'20:30:00'		,'2016-02-16')	,
(	14	,1	,	'B02', 	'20:30:00'		,'2016-02-16')	,
(	15	,1	,	'B03', 	'20:30:00'		,'2016-02-16')	,
(	16	,1	,	'B04', 	'20:30:00'		,'2016-02-16')	,
(	17	,1	,	'B05', 	'20:30:00'		,'2016-02-16')	,
(	18	,1	,	'B06', 	'20:30:00'		,'2016-02-16')	,
(	19	,1	,	'B07', 	'20:30:00'		,'2016-02-16')	,
(	20	,1	,	'B08', 	'20:30:00'		,'2016-02-16')	,
(	21	,1	,	'B09', 	'20:30:00'		,'2016-02-16')	,
(	22	,1	,	'B10', 	'20:30:00'		,'2016-02-16')	,
(	23	,1	,	'B11', 	'20:30:00'		,'2016-02-16')	,
(	24	,1	,	'B12', 	'20:30:00'		,'2016-02-16')	,
(	25	,1	,	'C01', 	'20:30:00'		,'2016-02-16')	,
(	26	,1	,	'C02', 	'20:30:00'		,'2016-02-16')	,
(	27	,1	,	'C03', 	'20:30:00'		,'2016-02-16')	,
(	28	,1	,	'C04', 	'20:30:00'		,'2016-02-16')	,
(	29	,1	,	'C05', 	'20:30:00'		,'2016-02-16')	,
(	30	,1	,	'C06', 	'20:30:00'		,'2016-02-16')	,
(	1	,2	,	'A01', 	'23:30:00'		,'2016-02-16')	,
(	2	,2	,	'A02', 	'23:30:00'		,'2016-02-16')	,
(	3	,2	,	'A03', 	'23:30:00'		,'2016-02-16')	,
(	4	,2	,	'A04', 	'23:30:00'		,'2016-02-16')	,
(	5	,2	,	'A05', 	'23:30:00'		,'2016-02-16')	,
(	6	,2	,	'A06', 	'23:30:00'		,'2016-02-16')	,
(	7	,2	,	'A07', 	'23:30:00'		,'2016-02-16')	,
(	8	,2	,	'A08', 	'23:30:00'		,'2016-02-16')	,
(	9	,2	,	'A09', 	'23:30:00'		,'2016-02-16')	,
(	10	,2	,	'A10', 	'23:30:00'		,'2016-02-16')	,
(	11	,2	,	'A11', 	'23:30:00'		,'2016-02-16')	,
(	12	,2	,	'A12', 	'23:30:00'		,'2016-02-16')	,
(	13	,2	,	'B01', 	'23:30:00'		,'2016-02-16')	,
(	14	,2	,	'B02', 	'23:30:00'		,'2016-02-16')	,
(	15	,2	,	'B03', 	'23:30:00'		,'2016-02-16')	,
(	16	,2	,	'B04', 	'23:30:00'		,'2016-02-16')	,
(	17	,2	,	'B05', 	'23:30:00'		,'2016-02-16')	,
(	18	,2	,	'B06', 	'23:30:00'		,'2016-02-16')	,
(	19	,2	,	'B07', 	'23:30:00'		,'2016-02-16')	,
(	20	,2	,	'B08', 	'23:30:00'		,'2016-02-16')	,
(	21	,2	,	'B09', 	'23:30:00'		,'2016-02-16')	,
(	22	,2	,	'B10', 	'23:30:00'		,'2016-02-16')	,
(	23	,2	,	'B11', 	'23:30:00'		,'2016-02-16')	,
(	24	,2	,	'B12', 	'23:30:00'		,'2016-02-16')	,
(	25	,2	,	'C01', 	'23:30:00'		,'2016-02-16')	,
(	26	,2	,	'C02', 	'23:30:00'		,'2016-02-16')	,
(	27	,2	,	'C03', 	'23:30:00'		,'2016-02-16')	,
(	28	,2	,	'C04', 	'23:30:00'		,'2016-02-16')	,
(	29	,2	,	'C05', 	'23:30:00'		,'2016-02-16')	,
(	30	,2	,	'C06', 	'23:30:00'		,'2016-02-16')	,
(	1	,20	,	'A01', 	'22:00:00'		,'2016-02-17')	,
(	2	,20	,	'A02', 	'22:00:00'		,'2016-02-17')	,
(	3	,20	,	'A03', 	'22:00:00'		,'2016-02-17')	,
(	4	,20	,	'A04', 	'22:00:00'		,'2016-02-17')	,
(	5	,20	,	'A05', 	'22:00:00'		,'2016-02-17')	,
(	6	,20	,	'A06', 	'22:00:00'		,'2016-02-17')	,
(	7	,20	,	'A07', 	'22:00:00'		,'2016-02-17')	,
(	8	,20	,	'A08', 	'22:00:00'		,'2016-02-17')	,
(	9	,20	,	'A09', 	'22:00:00'		,'2016-02-17')	,
(	10	,20	,	'A10', 	'22:00:00'		,'2016-02-17')	,
(	11	,20	,	'A11', 	'22:00:00'		,'2016-02-17')	,
(	12	,20	,	'A12', 	'22:00:00'		,'2016-02-17')	,
(	13	,20	,	'B01', 	'22:00:00'		,'2016-02-17')	,
(	14	,20	,	'B02', 	'22:00:00'		,'2016-02-17')	,
(	15	,20	,	'B03', 	'22:00:00'		,'2016-02-17')	,
(	16	,20	,	'B04', 	'22:00:00'		,'2016-02-17')	,
(	17	,20	,	'B05', 	'22:00:00'		,'2016-02-17')	,
(	18	,20	,	'B06', 	'22:00:00'		,'2016-02-17')	,
(	19	,20	,	'B07', 	'22:00:00'		,'2016-02-17')	,
(	20	,20	,	'B08', 	'22:00:00'		,'2016-02-17')	,
(	21	,20	,	'B09', 	'22:00:00'		,'2016-02-17')	,
(	22	,20	,	'B10', 	'22:00:00'		,'2016-02-17')	,
(	23	,20	,	'B11', 	'22:00:00'		,'2016-02-17')	,
(	24	,20	,	'B12', 	'22:00:00'		,'2016-02-17')	,
(	25	,20	,	'C01', 	'22:00:00'		,'2016-02-17')	,
(	26	,20	,	'C02', 	'22:00:00'		,'2016-02-17')	,
(	27	,20	,	'C03', 	'22:00:00'		,'2016-02-17')	,
(	28	,20	,	'C04', 	'22:00:00'		,'2016-02-17')	,
(	29	,20	,	'C05', 	'22:00:00'		,'2016-02-17')	,
(	30	,20	,	'C06', 	'22:00:00'		,'2016-02-17')	,
(	1	,8	,	'A01', 	'23:30:00'		,'2016-02-18')	,
(	5	,8	,	'A02', 	'23:30:00'		,'2016-02-18')	,
(	8	,8	,	'A03', 	'23:30:00'		,'2016-02-18')	,
(	9	,8	,	'A04', 	'23:30:00'		,'2016-02-18')	,
(	10	,8	,	'A05', 	'23:30:00'		,'2016-02-18')	,
(	15	,8	,	'A06', 	'23:30:00'		,'2016-02-18')	,
(	18	,8	,	'A07', 	'23:30:00'		,'2016-02-18')	,
(	19	,8	,	'A08', 	'23:30:00'		,'2016-02-18')	,
(	20	,8	,	'A09', 	'23:30:00'		,'2016-02-18')	,
(	24	,8	,	'A10', 	'23:30:00'		,'2016-02-18')	,
(	28	,8	,	'A11', 	'23:30:00'		,'2016-02-18')	,
(	29	,8	,	'A12', 	'23:30:00'		,'2016-02-18')	,
(	1	,4	,	'A01', 	'19:30:00'		,'2016-02-19')	,
(	2	,4	,	'A02', 	'19:30:00'		,'2016-02-19')	,
(	3	,4	,	'A03', 	'19:30:00'		,'2016-02-19')	,
(	4	,4	,	'A04', 	'19:30:00'		,'2016-02-19')	,
(	5	,4	,	'A05', 	'19:30:00'		,'2016-02-19')	,
(	6	,4	,	'A06', 	'19:30:00'		,'2016-02-19')	,
(	7	,4	,	'A07', 	'19:30:00'		,'2016-02-19')	,
(	8	,4	,	'A08', 	'19:30:00'		,'2016-02-19')	,
(	9	,4	,	'A09', 	'19:30:00'		,'2016-02-19')	,
(	10	,4	,	'A10', 	'19:30:00'		,'2016-02-19')	,
(	11	,4	,	'A11', 	'19:30:00'		,'2016-02-19')	,
(	12	,4	,	'A12', 	'19:30:00'		,'2016-02-19')	,
(	13	,4	,	'B01', 	'19:30:00'		,'2016-02-19')	,
(	14	,4	,	'B02', 	'19:30:00'		,'2016-02-19')	,
(	15	,4	,	'B03', 	'19:30:00'		,'2016-02-19')	,
(	16	,4	,	'B04', 	'19:30:00'		,'2016-02-19')	,
(	17	,4	,	'B05', 	'19:30:00'		,'2016-02-19')	,
(	18	,4	,	'B06', 	'19:30:00'		,'2016-02-19')	,
(	19	,4	,	'B07', 	'19:30:00'		,'2016-02-19')	,
(	20	,4	,	'B08', 	'19:30:00'		,'2016-02-19')	,
(	21	,4	,	'B09', 	'19:30:00'		,'2016-02-19')	,
(	22	,4	,	'B10', 	'19:30:00'		,'2016-02-19')	,
(	23	,4	,	'B11', 	'19:30:00'		,'2016-02-19')	,
(	24	,4	,	'B12', 	'19:30:00'		,'2016-02-19')	,
(	25	,4	,	'C01', 	'19:30:00'		,'2016-02-19')	,
(	26	,4	,	'C02', 	'19:30:00'		,'2016-02-19')	,
(	27	,4	,	'C03', 	'19:30:00'		,'2016-02-19')	,
(	28	,4	,	'C04', 	'19:30:00'		,'2016-02-19')	,
(	29	,4	,	'C05', 	'19:30:00'		,'2016-02-19')	,
(	30	,4	,	'C06', 	'19:30:00'		,'2016-02-19')	,
(	31	,4	,	'C07', 	'19:30:00'		,'2016-02-19')	,
(	32	,4	,	'C08', 	'19:30:00'		,'2016-02-19')	,
(	33	,4	,	'C09', 	'19:30:00'		,'2016-02-19')	,
(	34	,4	,	'C10', 	'19:30:00'		,'2016-02-19')	,
(	35	,4	,	'C11', 	'19:30:00'		,'2016-02-19')	,
(	36	,4	,	'C12', 	'19:30:00'		,'2016-02-19')	,
(	37	,4	,	'D01', 	'19:30:00'		,'2016-02-19')	,
(	38	,4	,	'D02', 	'19:30:00'		,'2016-02-19')	,
(	39	,4	,	'D03', 	'19:30:00'		,'2016-02-19')	,
(	40	,4	,	'D04', 	'19:30:00'		,'2016-02-19')	,
(	41	,4	,	'D05', 	'19:30:00'		,'2016-02-19')	,
(	42	,4	,	'D06', 	'19:30:00'		,'2016-02-19')	,
(	43	,4	,	'D07', 	'19:30:00'		,'2016-02-19')	,
(	44	,4	,	'D08', 	'19:30:00'		,'2016-02-19')	,
(	45	,4	,	'D09', 	'19:30:00'		,'2016-02-19')	,
(	46	,4	,	'D10', 	'19:30:00'		,'2016-02-19')	,
(	1	,18	,	'A11', 	'21:15:00'		,'2016-02-20')	,
(	2	,18	,	'A12', 	'21:15:00'		,'2016-02-20')	,
(	3	,18	,	'B01', 	'21:15:00'		,'2016-02-20')	,
(	4	,18	,	'B02', 	'21:15:00'		,'2016-02-20')	,
(	5	,18	,	'B03', 	'21:15:00'		,'2016-02-20')	,
(	6	,18	,	'B04', 	'21:15:00'		,'2016-02-20')	,
(	7	,18	,	'B05', 	'21:15:00'		,'2016-02-20')	,
(	8	,18	,	'B06', 	'21:15:00'		,'2016-02-20')	,
(	9	,18	,	'B07', 	'21:15:00'		,'2016-02-20')	,
(	10	,18	,	'B08', 	'21:15:00'		,'2016-02-20')	,
(	11	,18	,	'B09', 	'21:15:00'		,'2016-02-20')	,
(	12	,18	,	'B10', 	'21:15:00'		,'2016-02-20')	,
(	13	,18	,	'B11', 	'21:15:00'		,'2016-02-20')	,
(	14	,18	,	'B12', 	'21:15:00'		,'2016-02-20')	,
(	15	,18	,	'C01', 	'21:15:00'		,'2016-02-20')	,
(	16	,18	,	'C02', 	'21:15:00'		,'2016-02-20')	,
(	17	,18	,	'C03', 	'21:15:00'		,'2016-02-20')	,
(	18	,18	,	'C04', 	'21:15:00'		,'2016-02-20')	,
(	5	,7	,	'A01', 	'21:45:00'		,'2016-02-21')	,
(	6	,7	,	'A02', 	'21:45:00'		,'2016-02-21')	,
(	7	,7	,	'A03', 	'21:45:00'		,'2016-02-21')	,
(	8	,7	,	'A04', 	'21:45:00'		,'2016-02-21')	,
(	9	,7	,	'A05', 	'21:45:00'		,'2016-02-21')	,
(	10	,7	,	'A06', 	'21:45:00'		,'2016-02-21')	,
(	11	,7	,	'A07', 	'21:45:00'		,'2016-02-21')	,
(	12	,7	,	'A08', 	'21:45:00'		,'2016-02-21')	,
(	13	,7	,	'A09', 	'21:45:00'		,'2016-02-21')	,
(	14	,7	,	'A10', 	'21:45:00'		,'2016-02-21')	,
(	15	,7	,	'A11', 	'21:45:00'		,'2016-02-21')	,
(	16	,7	,	'A12', 	'21:45:00'		,'2016-02-21')	,
(	17	,7	,	'B01', 	'21:45:00'		,'2016-02-21')	,
(	18	,7	,	'B02', 	'21:45:00'		,'2016-02-21')	,
(	19	,7	,	'B03', 	'21:45:00'		,'2016-02-21')	,
(	20	,7	,	'B04', 	'21:45:00'		,'2016-02-21')	,
(	21	,7	,	'B05', 	'21:45:00'		,'2016-02-21')	,
(	22	,7	,	'B06', 	'21:45:00'		,'2016-02-21')	,
(	23	,7	,	'B07', 	'21:45:00'		,'2016-02-21')	,
(	24	,7	,	'B08', 	'21:45:00'		,'2016-02-21')	,
(	25	,7	,	'B09', 	'21:45:00'		,'2016-02-21')	,
(	26	,7	,	'B10', 	'21:45:00'		,'2016-02-21')	,
(	27	,7	,	'B11', 	'21:45:00'		,'2016-02-21')	,
(	28	,7	,	'B12', 	'21:45:00'		,'2016-02-21')	,
(	29	,7	,	'C01', 	'21:45:00'		,'2016-02-21')	,
(	30	,7	,	'C02', 	'21:45:00'		,'2016-02-21')	,
(	31	,7	,	'C03', 	'21:45:00'		,'2016-02-21')	,
(	32	,7	,	'C04', 	'21:45:00'		,'2016-02-21')	,
(	33	,7	,	'C05', 	'21:45:00'		,'2016-02-21')	,
(	34	,7	,	'C06', 	'21:45:00'		,'2016-02-21')	,
(	35	,7	,	'C07', 	'21:45:00'		,'2016-02-21')	,
(	36	,7	,	'C08', 	'21:45:00'		,'2016-02-21')	,
(	37	,7	,	'C09', 	'21:45:00'		,'2016-02-21')	,
(	38	,7	,	'C10', 	'21:45:00'		,'2016-02-21')	,
(	39	,7	,	'C11', 	'21:45:00'		,'2016-02-21')	,
(	40	,7	,	'C12', 	'21:45:00'		,'2016-02-21')	,
(	29	,19	,	'B03', 	'19:30:00'		,'2016-02-22')	,
(	1	,19	,	'B04', 	'19:30:00'		,'2016-02-22')	,
(	2	,19	,	'B05', 	'19:30:00'		,'2016-02-22')	,
(	3	,19	,	'B06', 	'19:30:00'		,'2016-02-22')	,
(	4	,19	,	'B07', 	'19:30:00'		,'2016-02-22')	,
(	5	,19	,	'B08', 	'19:30:00'		,'2016-02-22')	,
(	6	,19	,	'B09', 	'19:30:00'		,'2016-02-22')	,
(	7	,19	,	'B10', 	'19:30:00'		,'2016-02-22')	,
(	8	,19	,	'B11', 	'19:30:00'		,'2016-02-22')	,
(	9	,19	,	'B12', 	'19:30:00'		,'2016-02-22')	,
(	10	,19	,	'B03', 	'19:30:00'		,'2016-02-22')	,
(	11	,19	,	'B04', 	'19:30:00'		,'2016-02-22')	,
(	12	,19	,	'B05', 	'19:30:00'		,'2016-02-22')	,
(	29	,20	,	'C07', 	'23:00:00'		,'2016-02-22')	,
(	30	,20	,	'C08', 	'23:00:00'		,'2016-02-22')	,
(	31	,20	,	'C09', 	'23:00:00'		,'2016-02-22')	,
(	32	,20	,	'C10', 	'23:00:00'		,'2016-02-22')	,
(	33	,20	,	'C11', 	'23:00:00'		,'2016-02-22')	,
(	34	,20	,	'C12', 	'23:00:00'		,'2016-02-22')	,
(	35	,20	,	'D01', 	'23:00:00'		,'2016-02-22')	,
(	36	,20	,	'D02', 	'23:00:00'		,'2016-02-22')	,
(	37	,20	,	'D03', 	'23:00:00'		,'2016-02-22')	,
(	29	,13	,	'E04', 	'18:00:00'		,'2016-02-23')	,
(	30	,13	,	'E05', 	'18:00:00'		,'2016-02-23')	,
(	31	,13	,	'E06', 	'18:00:00'		,'2016-02-23')	,
(	32	,13	,	'E07', 	'18:00:00'		,'2016-02-23')	,
(	33	,13	,	'E08', 	'18:00:00'		,'2016-02-23')	,
(	34	,13	,	'E09', 	'18:00:00'		,'2016-02-23')	,
(	35	,13	,	'E10', 	'18:00:00'		,'2016-02-23')	,
(	36	,13	,	'E11', 	'18:00:00'		,'2016-02-23')	,
(	37	,13	,	'E12', 	'18:00:00'		,'2016-02-23')	,
(	38	,13	,	'F01', 	'18:00:00'		,'2016-02-23')	,
(	39	,13	,	'F02', 	'18:00:00'		,'2016-02-23')	,
(	40	,13	,	'F03', 	'18:00:00'		,'2016-02-23')	,
(	44	,4	,	'D08', 	'19:30:00'		,'2016-02-24')	,
(	45	,4	,	'D09', 	'19:30:00'		,'2016-02-24')	,
(	46	,4	,	'D10', 	'19:30:00'		,'2016-02-24')	;
COMMIT;