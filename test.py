import logging
import pprint
import random as rand

logger = logging.getLogger(__name__)


def main() -> int:
    return rand.randint(0, 10) * rand.randint(0, 10)


def foo(x: int, y: int) -> int:
    return x * y


if __name__ == "__main__":
    print(
        "Your randomly generated number is..............................",
        sep=" ",
        end=" ",
    )
    pprint.pprint(main())
    print("hello world")
