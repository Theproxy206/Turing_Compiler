machine DuplicarUnos {
    config {
        states: [q0, q1, q2, q3, q4, q5]
        symbols: [0, 1, X, B]
        start: q0
        blank: B
        finals: [q5]
    }

    state q0 {
        on 1: { write: X, move: R, next: q1 }
    }

    state q1 {
        on 0: { write: 0, move: R, next: q2 }
        on 1: { write: 1, move: R, next: q1 }
        on B: { write: 0, move: R, next: q2 }
    }

    state q2 {
        on 1: { write: 1, move: R, next: q2 }
        on B: { write: 1, move: L, next: q3 }
    }

    state q3 {
        on 0: { write: 0, move: L, next: q3 }
        on 1: { write: 1, move: L, next: q3 }
        on X: { write: 1, move: R, next: q4 }
    }

    state q4 {
        on 0: { write: 0, move: S, next: q5 }
        on 1: { write: X, move: R, next: q1 }
    }
}