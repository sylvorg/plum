from plum import dispatch, Dispatcher


# # Adapted From: https://github.com/coady/multimethod/blob/main/multimethod/__init__.py#L488-L498
class plumeta(type):
    """Convert all callables in namespace to Dispatchers."""

    class __prepare__(dict):
        def __init__(self, *args):
            self.__dispatcher__ = Dispatcher()
            super().__setitem__("__dispatcher__", self.__dispatcher__)

        def __setitem__(self, key, value):
            if callable(value):
                args, kwargs = getattr(value, "__plume__", (tuple(), dict()))
                if not kwargs.get("disabled", False):
                    value = getattr(self.get(key), "dispatch", self.__dispatcher__)(
                        value, *args, **kwargs
                    )
            super().__setitem__(key, value)


@dispatch
def process(_: type):
    pass