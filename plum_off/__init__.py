import rich.traceback as RichTraceback

RichTraceback.install(show_locals=True)

import rich.pretty as RichPretty

RichPretty.install()

from beartype.claw import beartype_this_package

beartype_this_package()

from plum_off.bundle import *
