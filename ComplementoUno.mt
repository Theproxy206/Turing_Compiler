machine ComplementoUno:
    config {
        states: [q0, q1],
        symbols: [0, 1, B],
        start: q0,
        blank: B,
        finals: [q1]
    }

    state q0 ->
        on 0: { write: 1, move: R, next: q0 }
        on 1: { write: 0, move: R, next: q0 }
        on B: { write: B, move: S, next: q1 }
    ;

end