functor
import
	System
define
		% 2.a
	fun {Lex Input}
		{String.tokens Input & }
	end

	% 2.b
	fun {Tokenize Lexemes} Token in
		case Lexemes
		of Lexeme|Rest then
			if {String.isFloat Lexeme} then
				Token = number({String.toFloat Lexeme})
			elseif Lexeme == "+" then
				Token = operator(type: plus)
			elseif Lexeme == "-" then
				Token = operator(type: minus)
			elseif Lexeme == "*" then
				Token = operator(type: multiply)
			elseif Lexeme == "/" then
				Token = operator(type: divide)
			end
			Token | {Tokenize Rest}
		[] nil then
			nil
		end
	end


	% 2.c
	fun {Interpret Tokens} Iterate in
		fun {Iterate Tokens Stack}
			{System.showInfo "Iteration:"}
			{System.show Tokens}
			{System.showInfo "Stack:"}
			{System.show Stack}

			case Tokens
			of number(N) | RestOfTokens then
				% Add N to stack
				{System.showInfo "Number "#N}

				{Iterate RestOfTokens N|Stack}
			[] operator(type: OperatorType) | RestOfTokens then
				{System.showInfo "Operator "#OperatorType}

				% Pop two values from stack, apply op, push result
				case Stack
				of RHS|LHS|RestOfStack then NewValue in
					case OperatorType of plus then
						NewValue = LHS + RHS
					[] minus then
						NewValue = LHS - RHS
					[] multiply then
						NewValue = LHS * RHS
					[] divide then
						NewValue = LHS / RHS
					end
					{Iterate RestOfTokens NewValue|RestOfStack}
				else
					nil
				end
			else
				nil
			end
		end

		{Iterate Tokens nil}
	end

	{System.showInfo "Leximizing"}
	Lexemes = {Lex "1 25 + 3 *"}
	{System.showInfo "Lexemes: "}
	{System.show Lexemes}

	{System.showInfo "Tokenizing"}
	Tokens = {Tokenize Lexemes}
	{System.showInfo "Tokens: "}
	{System.show Tokens}

	{System.showInfo "Interpreting"}
	Stack = {Interpret Tokens}
	{System.showInfo "Stack: "}
	{System.show Stack}

	{System.show {Interpret [number(10) number(3) operator(type:plus)]}}

end
