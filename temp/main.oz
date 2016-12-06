functor
import
   Application
   System
define
    local X Z A B P in
        proc {P ?X Y}
					Y = X|Z
        end
        X = 4
        {P X A}
        Z = 8
        {P A B}
        {System.show A}
        {System.show B}
    end
end
