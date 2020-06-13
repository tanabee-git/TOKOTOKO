SELECT bp1.product_id, b1.data_reported AS latest, b1.bug_id
FROM Bugs b1 INNER JOIN BugsProducts bp1 USING(bug_id)
WHERE NOT EXISTS
	(SELECT * FROM Bugs b2 INNER JOIN BugsProducts bp2 USING(bug_id)
	WHERE bp1.product_id = bp2.product_id
	AND b1.data_reported > b2.data_reported);
