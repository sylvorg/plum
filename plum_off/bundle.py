from .python import plumeta, process


class Bundle(plumeta, metaclass=plumeta):
    def __new__(cls, name, bases, ns):
        return super().__new__(cls, name, bases, ns)


class bundle(metaclass=Bundle):
    pass
