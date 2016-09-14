functor
import
	System
define

	fun {Min X Y}
		if X < Y then
			X
		else
			Y
		end
	end
	X = 30
	{System.showInfo "Hello Compiler!"}
	{System.showInfo 'Single quotes'}
	thread {System.showInfo Y} end
	Y = X
	{System.showInfo {Min 10 89}}
end
