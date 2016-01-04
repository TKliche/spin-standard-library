{{
    This example shows you how to build a desktop calculator in Spin.
}}
CON

    _clkmode = xtal1 + pll16x
    _xinfreq = 5_000_000

OBJ

    term  : "com.serial.terminal"
    num   : "string.numbers"

VAR

    byte    look  
    long    sum
    byte    err
    byte    inputstring[32]

PUB Main

    term.Start (115200)

    repeat
        err := false

        term.Flush        
        term.Str (string("> "))

        GetChar
        SkipSpace
        
        sum := GetExpression
        
        if not err
            term.Char (term#NL)
            term.Chars (" ",2)
            term.Str (num.Dec(sum))
            term.Chars (term#NL,2)

PUB GetChar

    look := term.CharIn

PUB Error(str)

    if not err    
        err := true
        term.Str (string("Error: "))
        term.Str (str)
    
PUB Expected(str)

    if not err
        Error(string("Expected "))
        term.Str(str)
        term.Char (":")
        term.Char (" ")
        term.Char (look)
        term.Chars(term#NL, 2)

PUB IsDigit(c)

    return lookdown(c: "0".."9")
    
PUB IsAlpha(c)

    return lookdown(c: "a".."z", "A".."Z")

PUB IsSpace(c)

    return lookdown(c: " ",term#NL)
    
PUB SkipSpace

    repeat while IsSpace(look) and look <> term#NL
        GetChar

PUB Match(c)

    if look == c
        GetChar
        SkipSpace
        return true
    else
        Expected(string("a match"))
        return false

PUB GetNumber | i

    if not IsDigit(look) and look <> term#NL
        Expected(string("number"))
        return
    
    i := 0
    repeat while IsDigit(look) and look <> term#NL
        inputstring[i] := look
        GetChar
        i++
    
    inputstring[i] := 0
 
    result := num.StrToBase(@inputstring, 10)
    if IsAlpha(look)
        Expected(string("number"))
        return
    SkipSpace

PUB GetFactor

    if look == "("
        if Match("(")
            result := GetExpression
        else
            Expected(string("factor"))
            return
        Match(")")
    else        
        result := GetNumber

PUB GetTerm

    result := GetFactor
    if IsDigit(look)
        Expected(string("operator"))
        return
        
    repeat while look == "*" or look == "/"
        case look
            "*"     : result *= GetMultiply
            "/"     : result /= GetDivide
            term#NL : return
            other   : Expected(string("term"))

PUB GetExpression

    result := GetTerm
    if IsDigit(look)
        Expected(string("operator"))
        return
        
    repeat while look == "+" or look == "-"
        case look
            "+"     : result += GetAdd
            "-"     : result -= GetSubtract
            term#NL : return
            other   : Expected(string("expression"))

PUB GetAdd

    if Match("+")
        result := GetTerm
    else
        return

PUB GetSubtract

    if Match("-")
        result := GetTerm
    else
        return

PUB GetMultiply

    if Match("*")
        result := GetFactor
    else
        return

PUB GetDivide

    if Match("/")
        result := GetFactor
    else
        return