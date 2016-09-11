functor
import
	Application(exit:Exit)
	System
define
	% 3a) Note answering without local is accepted, local is only used to contain everything in this single file
	local X Y Z in
		Y = 300
		Z = 30
		X = Y * Z
	end

	% 3b)
	local X Y in
		X = "This is a string"
		thread {System.showInfo Y} end
		Y = X
	end
	% showInfo can print Y because it sleeps until Y is assigned.
	% This behaviour is useful because it allows us avoid implementing it ourselves. It can be very difficult in more complex situations.
	% The statement Y = X "unifies" the variables, in this case, Y will become a binding to the string that X is bound to.

	% 4a)
	fun {Max Number1 Number2}
		if Number1 > Number2 then
			Number1
		else
			Number2
		end
	end

	% 4b)
	proc {PrintGreater Number1 Number2}
		{System.showInfo {Max Number1 Number2}}
	end
	% {PrintGreater 1337 9330} should print 9330

	% 5) Note that # is not strictly required, it's only for pretty-printing
	proc {Circle R}
		Pi = 355.0/113.0
		A = Pi * R * R
		D = 2.0 * R
		C = Pi * D
	in
		{System.showInfo "Area: "#A}
		{System.showInfo "Diameter: "#D}
		{System.showInfo "Circumference: "#C}
	end

	% 6) (NOT A TASK) Just to make sure the code works in the example
	fun {IncUntil Start Stop} A in
		{System.showInfo "Pusing Start: "#Start}
		if Start < Stop then
			A = {IncUntil Start+1 Stop}
		else
			A = Stop
		end
		{System.showInfo "Popping Start: "#Start}
		A
	end

	{System.showInfo {IncUntil 10 15}}

	% 6)
	fun {Factorial N}
		if N == 0 then
			1
		else
			N*{Factorial N-1}
		end
	end
	{System.showInfo "Factorial: "#{Factorial 5}}

	% 7a)
	fun {Length List}
		case List of Head|Tail then
			1+{Length Tail}
		[] nil then
			0
		end
	end

	% 7b)
	fun {Take List Count}
		if Count == 0 then
			nil
		else
			case List of Head|Tail then
				Head|{Take Tail Count-1}
			else
				nil
			end
		end
	end
	{System.show {Take [1 2 3 4] 2}}
	{System.show {Take [1 2 3 4] 8}}

	% 7c)
	fun {Drop List Count}
		if Count == 0 then
			List
		else
			case List of Head|Tail then
				{Drop Tail Count-1}
			else
				nil
			end
		end
	end
	{System.show {Drop [1 2 3 4] 2}}
	{System.show {Drop [1 2 3 4] 8}}

	% 7d)
	fun {Append List1 List2}
		case List1 of Head|Tail then
			Head|{Append Tail List2}
		else
			List2
		end
	end
	{System.show {Append [1 2 9] [3 4 8]}}

	% 7e)
	fun {Member List Element}
		case List of Head|Tail then
			if Head == Element then
				true
			else
				{Member Tail Element}
			end
		else
			false
		end
	end
	{System.show {Member [1 2 8 9] 3}}
	{System.show {Member [1 2 8 9] 8}}

	% 7f)
	fun {Position List Element}
		case List of Head|Tail then
			if Element == Head then
				0
			else
				1+{Position Tail Element}
			end
		else
			0
		end
	end
	{System.show {Position [1 2 4 8 9] 6}}
	{System.show {Position [1 2 4 8 9] 11}}

	{Exit 0}
end
