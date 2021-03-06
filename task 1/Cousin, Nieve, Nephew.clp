(defrule isNephew
	(Selected 12)

	(Nephew ?nephewName ?name)
	
	=>
	(printout t ?nephewName " is " ?name "'s nephew")
	(assert (CompareHeight ?nephewName ?name))
)

(defrule isNephew2
	(Person (name ?name))
	(Person (name ?nephewName&:(neq ?nephewName ?name))(gender m)(parents ?parent1 ?parent2))

	(or
		(Sibling ?name ?parent1)
		(Sibling ?name ?parent2)
	)
	=>
	(assert (Nephew ?nephewName ?name))
)

(defrule isNiece2
	(Selected 13)
	(Niece ?nieceName ?name)
	=>
	(printout t ?nieceName " is " ?name "'s niece")
	(assert (CompareHeight ?nieceName ?name))
)

(defrule isNiece
	(Person (name ?name))
	(Person (name ?nieceName&:(neq ?nieceName ?name))
			(gender f)
			(parents ?parent1 ?parent2)
	)
	(or
		(Sibling ?name ?parent1)
		(Sibling ?name ?parent2)
	)
	=>
	(assert (Niece ?nieceName ?name))
)


(defrule isCousin2
	(Selected 11)
	
	(Cousin ?cousin1Name ?cousin2Name)
	=>
	(printout t ?cousin1Name " is " ?cousin2Name "'s cousin")
	(assert (CompareHeight ?cousin1Name ?cousin2Name))
)

(defrule isCousin	
	(Person (name ?cousin1Name)(parents ?cousin1Parent1Name ?cousin1Parent2Name))
	(Person (name ?cousin2Name&:(neq ?cousin1Name ?cousin2Name))(parents ?cousin2Parent1Name ?cousin2Parent2Name))

	(not (Sibling ?cousin1Name ?cousin2Name))
	(not (Sibling ?cousin2Name ?cousin1Name))
	(or
		(Uncle ?cousin1Parent1Name ?cousin2Name)
		(Aunt ?cousin1Parent1Name ?cousin2Name)
		(Uncle ?cousin1Parent2Name ?cousin2Name)
		(Aunt ?cousin1Parent2Name ?cousin2Name)
		
		(Uncle ?cousin2Parent1Name ?cousin1Name)
		(Aunt ?cousin2Parent1Name ?cousin1Name)
		(Uncle ?cousin2Parent2Name ?cousin1Name)
		(Aunt ?cousin2Parent2Name ?cousin1Name)
	)
	=>
	(assert (Cousin ?cousin1Name ?cousin2Name))
)