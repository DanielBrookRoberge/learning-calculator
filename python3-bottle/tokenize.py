def tokenize(expression):
    inprogress = ''

    for c in expression:
        if c.isspace():
            continue
        if c.isdigit():
            inprogress += c
        elif c.isalpha():
            raise ValueError
        else:
            if inprogress:
                yield inprogress
                inprogress = ''
            yield c
    if inprogress:
        yield inprogress
