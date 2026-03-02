machine Hol@:
    config {
        states: [q0, q1],
        symbols: [0, 1, X, Y, Z, B],
        start: q0
        blank: B,
        finals: [q1],
    }

    state q0 ->
        on 0: { write: 0, move: R, next: q1 }
        on 1: { write: A, move: R, next: q1 }
    ;

    state q1 ->
        on 0: { write: 0, move: R, next: q1 }
        on 1: { write: 1, move: R, next: q1 }
    ;

    state q0 ->
        on 0: { write: 0, move: R, next: q1 }
    ;

end