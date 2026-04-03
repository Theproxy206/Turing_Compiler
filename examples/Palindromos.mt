machine Palindromos:
    config {
        states: [q0, q1, q2, q3, q4, q5, q6, a],
        symbols: [0, 1, X, B],
        start: q0,
        blank: B,
        finals: [a]
    }

    state q0 ->
        on 0: { write: X, move: R, next: q1 }
        on 1: { write: X, move: R, next: q4 }
        on X: { write: X, move: S, next: a }
        on B: { write: B, move: S, next: a }
    ;

    state q1 ->
        on 0: { write: 0, move: R, next: q1 }
        on 1: { write: 1, move: R, next: q1 }
        on X: { write: X, move: L, next: q2 }
        on B: { write: B, move: L, next: q2 }
    ;

    state q2 ->
        on 0: { write: X, move: L, next: q3 }
        on X: { write: X, move: L, next: a }
    ;

    state q3 ->
        on 0: { write: 0, move: L, next: q3 }
        on 1: { write: 1, move: L, next: q3 }
        on X: { write: X, move: R, next: q0 }
    ;

    state q4 ->
        on 0: { write: 0, move: R, next: q4 }
        on 1: { write: 1, move: R, next: q4 }
        on X: { write: X, move: L, next: q5 }
        on B: { write: B, move: L, next: q5 }
    ;

    state q5 ->
        on 1: { write: X, move: L, next: q6 }
        on X: { write: X, move: L, next: a }
    ;

    state q6 ->
        on 0: { write: 0, move: L, next: q6 }
        on 1: { write: 1, move: L, next: q6 }
        on X: { write: X, move: R, next: q0 }
    ;
end