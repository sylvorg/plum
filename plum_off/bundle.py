from .python import plumeta, process


class Bundle(plumeta, metaclass=plumeta):
    def __new__(cls, name, bases, ns):
        pass


class bundle(metaclass=Bundle):
    pass
